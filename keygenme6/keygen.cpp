#include <array>
#include <cstdint>
#include <string_view>

#include <gmpxx.h>


// This is the crypto function they used.
constexpr uint8_t F(uint8_t x, uint8_t y) noexcept {
    uint8_t z = 0;
    if (x >= ':') {
        z = (x - '7') << 4;
    } else {
        z = (x - '0') << 4;
    }

    if (y >= ':') {
        return z | ((y - '7') & 0x0F);
    } else {
        return z | (y - '0');
    }
}

constexpr uint16_t pair_merge(const uint8_t a, const uint8_t b) {
	return (static_cast<uint16_t>(a) << 8 ) | b;
}


// We can generate any key from this.
constexpr std::array<uint16_t, 256> pre_gen() noexcept {
	std::array<uint16_t, 256> T = {};

    for (uint8_t i = 'A'; i <= 'Z'; i++) {
        for (uint8_t j = 'A'; j <= 'Z'; j++) {
            uint8_t z = F(i,j);
            T[z] = pair_merge(i, j);
        }
    }

    return T;
}

// pre generate the solution.
constexpr std::array<uint16_t,256> f_table = pre_gen();


// This is the inverse of that crypto function.
constexpr uint16_t F_INV(uint8_t z) {
    return f_table[z];
}



// These are the cryptographic constants.
// I have included them in hex, because it's faster for GNU MP

// MOD N
const char raw_N[] = "DE8EFFA50D23F5B6B9CB5BEB16BAB180309EC5787FECE557BEE7449";
const char raw_D[] = "4F27D2FAD4129F18CF39E9C6523B8A2A6DB9ED972B2F38BF012EFF5";
const char raw_E[] = "10001";

const size_t MAX_NAME_SIZE = 100;



/*
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
*/


// So in the weird func, two pairs are reduced down to one.
// 
// qweqwe becomes 0xA0 EA 0E
//
// qw -> A0
// eq -> EA
// we -> OE


/*
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


	// We get the hex name
	char* hex_name = ascii_to_hex(name);
	printf("ASCII TO HEX: %s -> %s\n", name, hex_name);
	
	rc = mpz_init_set_str(name_n, hex_name, 16);
//	assert(rc == 0);

	gmp_printf("Name number: %Zd\n", name_n);


	mpz_powm(out_weird, name_n, D, N);

	gmp_printf("Decrypted name: %Zx\n", out_weird);

	free(hex_name);

	// Clear everything.
	mpz_clears(name_n, out_weird, N, D, E, NULL);

	printf("Ending license generation for name: %s\n", name);
	return NULL;
}
*/


std::string generate_license(std::string_view name) {
	mpz_class N{"DE8EFFA50D23F5B6B9CB5BEB16BAB180309EC5787FECE557BEE7449",16};

}

int main(int argc, char** argv) {
	// TODO(rHermes): Take name from argv.
	
	// const char* name = "mihika-is-my-love<3";
	// const char* name = "mihika";
	const char* name = "mats elsker crypto";
	generate_license(name);


	return 0;
}
