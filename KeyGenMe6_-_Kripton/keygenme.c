#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#include <assert.h>

#include <gmp.h>


// These are the cryptographic constants.
// I have included them in hex, because it's faster for GNU MP

// MOD N
const char raw_N[] = "DE8EFFA50D23F5B6B9CB5BEB16BAB180309EC5787FECE557BEE7449";

// Private exponent
const char raw_D[] = "4F27D2FAD4129F18CF39E9C6523B8A2A6DB9ED972B2F38BF012EFF5";

// Public exponent, very common.
const char raw_E[] = "10001";

const size_t MAX_NAME_SIZE = 100;

char* ascii_to_hex(const char* ascii) {
	int ascii_size = strnlen(ascii, MAX_NAME_SIZE);
	// it will be exactly twice as big.
	char* hex = malloc((ascii_size*2 + 1)*sizeof(char));

	for (int i = 0; i < ascii_size; i++) {
		sprintf(&hex[i*2], "%02X", (unsigned char)(ascii[i]));
	}

	// zero terminate it.
	hex[ascii_size*2] = 0;
	return hex;
}


// So in the weird func, two pairs are reduced down to one.
// 
// qweqwe becomes 0xA0 EA 0E
//
// qw -> A0
// eq -> EA
// we -> OE


// returns string that needs to be freed.
char* generate_license(const char* name) {
	int rc;
	mpz_t name_n;
	mpz_t out_weird;
	mpz_t N, D, E;

	printf("Starting license generation for name: %s\n", name);

	mpz_init(out_weird);
	
	mpz_init_set_str(N, raw_N, 16);
	mpz_init_set_str(D, raw_D, 16);
	mpz_init_set_str(E, raw_E, 16);

	/*
	mpz_init(name_n);
	mpz_init(out_weird);
	*/

	// We get the hex name
	char* hex_name = ascii_to_hex(name);
	printf("ASCII TO HEX: %s -> %s\n", name, hex_name);
	
	rc = mpz_init_set_str(name_n, hex_name, 16);
	assert(rc == 0);

	gmp_printf("Name number: %Zd\n", name_n);


	mpz_powm(out_weird, name_n, D, N);

	gmp_printf("Decrypted name: %Zx\n", out_weird);

	free(hex_name);

	// Clear everything.
	mpz_clears(name_n, out_weird, N, D, E, NULL);

	printf("Ending license generation for name: %s\n", name);
	return NULL;
}

int main(int argc, char** argv) {
	// TODO(rHermes): Take name from argv.
	
	// const char* name = "mihika-is-my-love<3";
	// const char* name = "mihika";
	const char* name = "mats elsker crypto";
	
	/*
	char* hexa = ascii_to_hex(name);
	free(hexa);
	*/
	
	generate_license(name);


	return 0;
}
