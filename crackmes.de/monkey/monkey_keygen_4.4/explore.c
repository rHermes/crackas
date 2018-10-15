#include <stdio.h>
#include <string.h>
#include <stdint.h>


// macro for doing things
// #define print(a, args...) printf("%s(%s:%d) " a,  __func__,__FILE__, __LINE__, ##args)

// Might be a structure here.

typedef struct {
	// These are never touched for anything i think.
	uint32_t len;
	uint32_t overflows;

	// This is the 
	uint32_t tmp_0;
	uint32_t tmp_1;
	uint32_t tmp_2;
	uint32_t tmp_3;
	uint32_t tmp_4;

	// This is then a char array for 64 characters.
	uint8_t arr[64];
} cstate;

// Not sure what this does.
void init_cstate(cstate* state) {
  state->len = 0;
  state->overflows = 0;
  state->tmp_0 = 1732584192;
  state->tmp_1 = 4023233417;
  state->tmp_2 = 2562383102;
  state->tmp_3 = 271733877;
  state->tmp_4 = 3285377519;
}


extern char* hash(cstate* state, uint8_t* arr);

// This is the mother fucker.
char* change_tmps(cstate* state, uint8_t* arr) {
	char* result = NULL;

	result = hash(state, arr);

	return result;
}

//extern char* change_tmps(cstate* state, uint8_t* arr);

char* weird_1(cstate* state, uint8_t* src, size_t src_len) {
	char* result = NULL;

	if (src_len) {
		// This will basically force the number to be 63 or less.
    // int bound_state_len = state->len & 0x3F;
		int bound_state_len = state->len % 64;
		unsigned int size = 64 - bound_state_len;

		state->len += src_len;

		// This has no effect, so I will just ignore it for now.

		// This could be wrap around?
		if (state->len < src_len) {
			state->overflows++;
		}


		// Overflow?
		if (bound_state_len && src_len >= size) {
			memcpy(&state->arr[bound_state_len], src, size);
			result = change_tmps(state, state->arr);

			src_len -= size;
			src += size;
			bound_state_len = 0;
		}


		// we read these 64 at a time.
		while (src_len >= 64) {
			result = change_tmps(state, src);
			src_len -= 64;
			src = src + 64;
		}

		// What is left
		if (src_len) {
			result = memcpy(&state->arr[bound_state_len], src, src_len);
		}
	}

	return result;
}

// The out here will simply be the bytes of the tmps.
char* weird_2(cstate *state, uint8_t* out) {
	char* result = NULL;
	uint8_t padding[64] = {128};
	size_t pad_length;
	uint8_t src[8];
	
	// Calculate src

	// The src is simply combining state_len and state_overflow to 64 bit 
	// and multiplying by 8. Then we convert that to a number in little enidan
	uint64_t x = ((uint64_t)state->overflows << 32) | state->len;
	x *= 8;
	// Convert the result to a src.
	for (int i = 0; i < 8; i++) {
		src[i] = (uint8_t)((x >> 8*(7 - i)) & 0xFF);
	}

	int bound_state_len = state->len % 64;
	if ( bound_state_len >= 56 )
		pad_length = 120 - bound_state_len;
	else
		pad_length = 56 - bound_state_len;

	weird_1(state, padding, pad_length);
	weird_1(state, src, 8);

	// copying to the bytes the state into the out
	for (int i = 0; i < 4; i++) {
		out[i] = (uint8_t)((state->tmp_0 >> 8*(3 - i)) & 0xFF);
		out[i+4] = (uint8_t)((state->tmp_1 >> 8*(3 - i)) & 0xFF);
		out[i+8] = (uint8_t)((state->tmp_2 >> 8*(3 - i)) & 0xFF);
		out[i+12] = (uint8_t)((state->tmp_3 >> 8*(3 - i)) & 0xFF);
		out[i+16] = (uint8_t)((state->tmp_4 >> 8*(3 - i)) & 0xFF);
	}

	return result;
}

void diag() {
	cstate state;

	uint8_t name[32] = "ghost_in_shell";
	uint8_t computed_serial[20];
	char actual_serial[41];


	init_cstate(&state);
	weird_1(&state, name, strlen(name));
	weird_2(&state, computed_serial);

	// Convert to hex string.
	for (int i = 0; i < 20; i++) {
		sprintf(&actual_serial[2*i], "%02x", computed_serial[i]);
	}

	printf("Serial is: %s\n", actual_serial);
}

// Panel is at: 0x004031ca
int main(int argc, char** argv) {
	diag();
	return 0;
}
