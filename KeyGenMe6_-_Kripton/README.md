# KeyGenMe6_-_Kripton

I got the keygen here: https://crackmes.one/crackme/5ab77f6633c5d40ad448cc61

Level: 3

Solved: 2018-10-9

Timespent: 12 hours ish

Tags: RSA, Delphi, Windows, 32bit, RC4, Keygen

## TLDR

It turns out that the activation code is always the same and it's 23479-81214-94578-61954


The name and the serial is connected. The serial will first have a function F(x)
applied to it which then will be encrypted with RSA. The RSA keylength was short so
I could break it by factoring. After this, the answer is converted to Base256 and
then this is compared against the name as if they where both hex numbers.


## LONG

This was my first serious keygen and I learned a lot about various tools and
techniques while doing this. I wrote a keygen and I am very happy with that
keygen as it does many cool things, like compute the inverse of the F function
and fill a table at compile time and checks if the table is correct or not,
also at compile time.

The keygen requires c++2a to compile, due to my usage of to_chars and
from_chars.

The file you find in information are two implementation of FGInt that
the binary might have used.
