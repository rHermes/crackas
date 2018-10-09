#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#include "tests.h"

void cmp_mem(unsigned char *cal, unsigned char *exp, int length) {
	for (int i = 0; i < length; i++) {
		if (cal[i] != exp[i]) {
			printf("We expected 0x%02x but got 0x%02x at %d\n",
					(unsigned char)exp[i],
					(unsigned char)cal[i],
					i);
		}
	}
}

// This is most likely the RC4 cipher.
int RC4_KSA(unsigned char* ctx, unsigned char *key, int key_length, int set_to_zero) {
	// Part of this is also that we set the flag that signs that we have actually setup
	// the rc4 cipher.
	*(ctx + 48) = 1;

	// This is a pointer into a struct I would have to believe.
	unsigned char* arr_offset = ctx + 52;
	// This is the key scheduling.
	for (unsigned int i = 0; i < 256; i++) {
		arr_offset[i] = i;
	}


	// So we know that up til this point we are good.
	
	unsigned int j = 0;
	// shuffling of the things?
	for (unsigned int i = 0; i < 256; i++) {
		// Don't think we need the mod 256 here.
		j = (key[i % key_length] + arr_offset[i] + j) % 256;
		unsigned char ctmp = arr_offset[i];
		arr_offset[i] = arr_offset[j];
		arr_offset[j] = ctmp;
	}

	// Now do what they do and copy it to a temporary arrray.
	// We save two exact copies of this string.
	memmove(ctx + 308, arr_offset, 256*sizeof(unsigned char));
  
	return 0;
}

void RC4_Encrypt(unsigned char* ctx, unsigned char *text, unsigned char* out, int textLength) {
	// This is just to assert something we did earlier.
	assert(*(ctx + 48));

	unsigned char* S = ctx + 52;

	unsigned int i = 0;
	unsigned int j = 0;

	for (int k = 0; k < textLength; k++) {
		i = (i + 1) % 256;
		j = (j + S[i]) % 256;

		unsigned char tmp = S[i];
		S[i] = S[j];
		S[j] = tmp;

		out[k] = S[(S[i] + S[j]) % 256] ^ text[k];
	}
}

void RC4_Encrypt_Lowercase_Hex(unsigned char *text, unsigned char *key, unsigned char *sOut) {
	unsigned char ctx[1000];

	// sOut must be 2 times as big as the input. with space for 0.

	int key_length = strlen((char *)key);
	int text_length = strlen((char *)text);


	unsigned char *encryptOut = malloc(key_length+sizeof(unsigned char));

	RC4_KSA(ctx, key, key_length, 0);
	RC4_Encrypt(ctx, text, encryptOut, text_length);

	// now we just need to print it to the sOut
	
	for (int i = 0; i < text_length; i++) {
		sprintf((char *)sOut + i*2, "%02x", (unsigned char)encryptOut[i]);
	}
	
	free(encryptOut);
}

// SERIAL STUFF

// have not verified this yet.
void some_weird_func_1(unsigned char *serial, unsigned char **serial_out) {
	size_t serial_len = strlen((char*)serial);

	// I need both 0 and one more.
	unsigned char *tmp = malloc((serial_len+2) * sizeof(unsigned char));
	size_t tmp_len = 0;
	if (serial_len % 2 == 1) {
		tmp[0] = '0';
		memmove(&tmp[1], serial, serial_len);
		tmp_len = serial_len + 1;
	} else {
		memmove(tmp, serial, serial_len);
		tmp_len = serial_len;
	}



	int len_div_2 = tmp_len / 2;

	// we allocate the buffer for the output.
	unsigned char *output = malloc(sizeof(unsigned char) * (len_div_2+1));

	int i;
	int j;
	if (len_div_2  > 0) {
		i = len_div_2;
		j = 1;

		do {
			unsigned char dl = tmp[2*j - 1];
			unsigned char al = tmp[2*j - 2];


			unsigned char bl = al;
			if (al >= ':') {
				bl = al;
				bl = bl - '7';
				bl = bl*16;
			} else {
				bl = al;
				bl = bl - '0';
				bl = bl*16;
			}


			if (dl >= ':') {
				dl = dl - '7';
				dl = dl & 0xF;
				bl = bl | dl;
			} else {
				dl = dl - '0';
				bl = bl | dl;
			}

			// printf ("BL: 0x%02x\n", bl);
			output[j-1] = bl;
			// j = esi;
			j++;
			i--;
		} while (i > 0);

		output[j-1] = '\0';
	}


	*serial_out = output;


	free(tmp);
}

// Once we have a weird_output we can make the answer, by doing:
// (SerialWeird ** 65537) % 1464884685465617123855583221184892505359516117214651507260039001161
//  So "lover" gives out: 0x05 8F EB == 364523 
//
//  Plugging this into the equation we get the answer:
//	642649140068845060865625545447408194368011621915404695750111032641
//	
//	this is then converted into a 256 Base number in a string. This is basically the same as 
//	printing the number out in hex and then taking the numbers you get out and putting that
//	into memory.

void serial_to_RC4_input(unsigned char *serial, unsigned char **serial_out) {
	some_weird_func_1(serial, serial_out);
}

void serial_calc(unsigned char *serial, char *sOut) {
	unsigned char ctx[1000];

	int serial_length = strlen((char *)serial);
	// after this serial is changed.
	unsigned char *pserial = NULL;
	serial_to_RC4_input(serial, &pserial);

	printf("START SERIAL_TO_RC4_output\n");
	for (int i = 0; i < strlen(pserial); i++) {
		printf("0x%02x\n", pserial[i]);
	}
	printf("END SERIAL_TO_RC4_output\n");

	// it is the text i pserial that we will then use to do the honors.
	

	// This is the encryption key.
	unsigned char ILM[] = "..::ILM::..";
	RC4_Encrypt_Lowercase_Hex(pserial, ILM, sOut);
	free(pserial);
}


unsigned char expected_encrypt_out[] = {
	0x24, 0x0C, 0xA0, 0x63, 0x6B, 0x68, 0x28, 0xE4, 0xE5, 0x04, 0xBA, 0x1D, 0xD1, 0x2A, 0x93, 0xB5,
	0xF6, 0xBF
};


const char activation_key[] = "23479-81214-94578-61954";


// Ok, so I fixed up the the actualy numbers.
//

int main(int argc, char** argv) {
	// This is the key used for the RC4 encryption
	unsigned char ILM[] = "..::ILM::..";
	const size_t ILM_len = 11;


	// Just for the encryption
	unsigned char Name[] = "mikiha-is-a-love<3";
	unsigned char NameOut[] = "mikiha-is-a-love<3";
	const size_t name_length = (sizeof(Name)-1)/sizeof(unsigned char);


	// This is our weird object.
	size_t length = 10000;
	unsigned char ctx[1000];

	RC4_KSA(ctx, ILM, ILM_len, 0);

	// Now to compare.
	printf("verifying results\n");
	cmp_mem(ctx+52, rawData_256, 256);
	printf("done verifying results\n");

	RC4_Encrypt(ctx, Name, NameOut, name_length);

	printf("verifying encryption\n");
	cmp_mem(NameOut, expected_encrypt_out, name_length);
	printf("done verifying encryption\n");


	printf("verifying whole stack encryption\n");
	unsigned char WeAreOut[10000];
	RC4_Encrypt_Lowercase_Hex(Name, ILM, WeAreOut);
	printf("And the out is: %s\n", WeAreOut);
	printf("done verivfying whole stack encrpytion\n");



	printf("Trying out serial thing\n");
	unsigned char WeAreSerial[10000];
	unsigned char serial[] = "lover";
	serial_calc(serial, WeAreSerial);
	for (int i = 0; i < strlen(WeAreSerial); i++) {
		printf("0x%02x\n", WeAreSerial[i]);
	}
	printf("done trying out serial thing\n");



	if (0) {
		// We just write it.
		FILE *f = fopen("lol.bin", "wb");
		if (f == NULL) {
			printf("Couldn't open file!\n");
			exit(1);
		}

		fwrite(ctx, sizeof(unsigned char), length, f);

		fclose(f);
	}

	return 0;
}
