# monkey_keygen_4.4

I got the keygen here: https://crackmes.one/crackme/5ab77f6633c5d40ad448cc4e

Level: 3

Language: C/C++

Solved: 2018-10-15

Timespent: 10 hours

Tags: SHA-1, Windows, 32bit, Keygen

## TLDR

Could have broken this one a lot faster, but I wanted to do it without
running a debugger. I also was really curious about the hashing function.

I gave up on really understanding it and broke it with Z3 first, and then
I actually dumped the hash function from the binary with r2 and created
a 32 bit binary in C.

After I had done that, I realized that it was most likely a variant of
SHA-1 but with different constants. 

The keygen is keygen.cpp, it isn't very well coded, but it's ok. Explore.c
is from my exploration of the program and is really a mess.
