#include <cstdio>
#include <cstdint>
#include <string>
#include <vector>
#include <array>
#include <cassert>
#include <climits>
#include <algorithm>

// This is just a custom implementation of SHA1


// I've taken this from wikipedia pesudocode
class SHA1 {

	public:
		void add_str(std::string_view data);
		std::array<uint8_t,20> digest() const;


	private:
		void update(const std::array<uint8_t,64>& data);

		// Constants. These are taken from the binary.
		uint32_t h0 = 0x67452300;
		uint32_t h1 = 0xEFCDAB89;
		uint32_t h2 = 0x98BADCFE;
		uint32_t h3 = 0x10325475;
		uint32_t h4 = 0xC3D2E1EF;
};


// utility function for rotating left.
// This is overkill as we need to make sure to avoid undefined behavior
constexpr uint32_t rotl(uint32_t x, unsigned int n) {
	const decltype(n) mask = (CHAR_BIT*sizeof(x) - 1);
	assert (n<=mask && "rotate by more than type width");
	n &= mask;  // avoid undef behaviour with NDEBUG.
	return (x<<n) | (x>>( (-n)&mask ));
}

// Utility function for hashing a string
// This is a real mess, but it works. Uses a lot of data though.
void SHA1::add_str(std::string_view data) {
	// we need to 

	// append it to the message.
	std::vector<uint8_t> msg;
	
	msg.insert(msg.cend(), data.cbegin(), data.cend());
	
	// Since we are always a multiple of the bytes we add 1
	msg.emplace_back(0x80);

	uint64_t start = msg.size();
	for (int i = (64 - (start % 64)); i > 0; i--) {
		msg.emplace_back(0);
	}

	// now we put in the original message.
	uint64_t ml = data.size()*CHAR_BIT;
	for (int i = 0; i < 8; i++) {
		// This is so gross, but it works.
		msg[msg.size()-(8-i)] =  (uint8_t)((ml >> 8*(7 - i)) & 0xFF);
	}
	
	// now for the updating
	std::array<uint8_t,64> part;
	for (auto it = msg.begin(); it != msg.end(); std::advance(it,64)) {
		std::copy_n(it, 64, part.begin());
		this->update(part);
	}

}

void SHA1::update(const std::array<uint8_t,64>& data) {
	std::array<uint32_t,80> w;

	// Create 32-bit words.
	for (int i = 0; i < 16; i++) {
		const auto k = i*4;
		w[i] = (data[k] << 24) | (data[k+1] << 16) | (data[k+2] << 8) | data[k+3];
	}

	for (int i = 16; i < 80; i++) {
		w[i] = rotl(w[i-3] ^ w[i-8] ^ w[i-14] ^ w[i-16], 1);
	}

	uint32_t a = this->h0;
	uint32_t b = this->h1;
	uint32_t c = this->h2;
	uint32_t d = this->h3;
	uint32_t e = this->h4;

	for (int i = 0; i < 80; i++) {
		uint32_t k;
		uint32_t f;

		// The constants in this are retrived from the binary.
		if (i < 20) {
			f = (b & c) | ((~b) & d);
			k = 0x5C27C99;
		} else if (i < 40) {
			f = b ^ c ^ d;
			k = 0x6AAAEBA1;
		} else if (i < 60) {
			f = (b & c) | (b & d) | (c & d);
			k = 0x2F1BB5DC;
		} else {
			f = b ^ c ^ d;
			k = 0xC5B2C1D6;
		}

		uint32_t tmp = rotl(a, 5) + f + e + k + w[i];
		e = d;
		d = c;
		c = rotl(b, 30);
		b = a;
		a = tmp;
	}

	this->h0 += a;
	this->h1 += b;
	this->h2 += c;
	this->h3 += d;
	this->h4 += e;
}

std::array<uint8_t,20> SHA1::digest() const {
	std::array<uint8_t,20> res;

	// Convert to 160 bit number.
	for (int i = 0; i < 4; i++) {
		res[i] = (uint8_t)((this->h0 >> 8*(3 - i)) & 0xFF);
		res[i+4] = (uint8_t)((this->h1 >> 8*(3 - i)) & 0xFF);
		res[i+8] = (uint8_t)((this->h2 >> 8*(3 - i)) & 0xFF);
		res[i+12] = (uint8_t)((this->h3 >> 8*(3 - i)) & 0xFF);
		res[i+16] = (uint8_t)((this->h4 >> 8*(3 - i)) & 0xFF);
	}

	return res;
}

std::string get_serial(std::string_view name) {
	SHA1 hasher;
	hasher.add_str(name);
	std::string ret('a', 41);

	const auto digest = hasher.digest();

	for (size_t i = 0; i < digest.size(); i++) {
		sprintf(&ret[i*2], "%02x", digest[i]);
	}

	return ret;
}

int main(int argc, char** argv) {
	if (argc <= 1) {
		printf("Usage: %s <name1> <name2> ...\n", argv[0]);
		return 1;
	}

	for (int i = 1; i < argc; i++) {
		const auto& serial = get_serial(argv[i]);
		printf("%s -> %s\n", argv[i], serial.c_str());

	}

	return 0;
}
