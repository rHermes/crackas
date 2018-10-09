#include <array>
#include <cstdint>
#include <string_view>
#include <charconv>

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

constexpr std::pair<uint8_t,uint8_t> pair_split(const uint16_t c) {
	return std::make_pair( c >> 8, c & 0xFF);
}


// We can generate any key from this.
constexpr std::array<uint16_t, 256> pre_gen() noexcept {
	std::array<uint16_t, 256> T = {};

    for (uint8_t i = 'A'; i <= 'Z'; i++) {
        for (uint8_t j = 'A'; j <= 'Z'; j++) {
            uint8_t z = F(i,j);
			if (T[z] == 0) {
				T[z] = pair_merge(i, j);
			}
        }
    }

    return T;
}

// pre generate the solution.
constexpr std::array<uint16_t,256> f_table = pre_gen();

// This is the inverse of that crypto function.
constexpr uint16_t F_inv(uint8_t z) {
    return f_table[z];
}

// This is just to make sure the pre_gen() fills entire keyspace.
constexpr bool all_ok() {
	for (int i = 0; i < 256; i++) {
		if (f_table[i] == 0) {
			return false;
		}
	}
	return true;
}

static_assert(all_ok(), "We are not filling the entire keyspace!");


// Convert a ascii to it's string representation.
std::string ascii_to_hex(std::string_view ascii) {
	std::string hex;
	hex.reserve(ascii.size()*2);

	// convert each char to hex.
	for (size_t i = 0; i < ascii.size(); i++) {
		std::to_chars(hex.data()+i*2, hex.data()+i*2 + 2, ascii[i], 16);
	}

	return hex;
}

std::string generate_license(std::string_view name) {
	// The constants we are going to need.
	// These are the cryptographic constants.
	// I have included them in hex, because it's faster for GNU MP
	mpz_class N{"DE8EFFA50D23F5B6B9CB5BEB16BAB180309EC5787FECE557BEE7449", 16};
    mpz_class D{"4F27D2FAD4129F18CF39E9C6523B8A2A6DB9ED972B2F38BF012EFF5", 16};


	std::string hex_name = ascii_to_hex(name);
	mpz_class num_name{hex_name, 16};

	mpz_class decrypted;
	mpz_powm(decrypted.get_mpz_t(), num_name.get_mpz_t(), D.get_mpz_t(), N.get_mpz_t());


	std::string post_f = decrypted.get_str(16);
	// We need an even balanced string where we are going.
	if (post_f.size() % 2 == 1) {
		post_f = "0" + post_f;
	}

	std::string serial{};
	serial.reserve(2*post_f.size());

	uint16_t c = 0;
	for (size_t i = 0; i < post_f.size(); i += 2) {
		std::from_chars(post_f.data()+i, post_f.data()+i+2, c, 16);
		auto [a, b] = pair_split(F_inv(c));
		serial[i] = a;
		serial[i+1] = b;
	}
	return serial;
}

// ACtivation is always 23479-81214-94578-61954
int main(int argc, char** argv) {
	// The serial is 
	if (argc != 2) {
		printf("Usage: %s <name>\n", argv[0]);
		return 1;
	}
	std::string serial = generate_license(argv[1]);
	printf("%s\n", serial.c_str());

	return 0;
}
