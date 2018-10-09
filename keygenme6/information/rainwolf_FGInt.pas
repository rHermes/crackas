{License, info, etc
 ------------------
This implementation is made by me, Walied Othman, to contact me
mail to rainwolf@submanifold.be or triade@submanifold.be ,
always mention wether it 's about the FGInt or about the 6xs, 
preferably in the subject line.
This source code is free, but only to other free software, 
it's a two-way street, if you use this code in an application from which 
you won't make any money of (e.g. software for the good of mankind) 
then go right ahead, I won't stop you, I do demand acknowledgement for 
my work.  However, if you're using this code in a commercial application, 
an application from which you'll make money, then yes, I charge a 
license-fee, as described in the license agreement for commercial use, see 
the textfile in this zip-file.
If you 're going to use these implementations, let me know, so I ca, put a link 
on my page if desired, I 'm always curious as to see where the spawn of my 
mind ends up in.  If any algorithm is patented in your country, you should
acquire a license before using this software.  Modified versions of this
software must contain an acknowledgement of the original author (=me).

This implementation is available at 
http://www.submanifold.be

copyright 2000, Walied Othman
This header may not be removed.}

Unit FGInt;

{$H+}{$LongStrings ON}  

Interface

Uses SysUtils, Math;

Type
   TCompare = (Lt, St, Eq, Er);
   TSign = (negative, positive);
   TFGInt = Record
      Sign : TSign;
      Number : Array Of LongWord;
   End;

Procedure FGIntDestroy(Var FGInt : TFGInt);
Procedure FGIntCopy(Const FGInt1 : TFGInt; Var FGInt2 : TFGInt);
Function FGIntCompareAbs(Const FGInt1, FGInt2 : TFGInt) : TCompare;
Procedure FGIntAbs(Var FGInt : TFGInt);
Procedure FGIntShiftLeft(Var FGInt : TFGInt);
Procedure FGIntShiftLeftBy32(Var FGInt : TFGInt);
Procedure FGIntShiftRight(Var FGInt : TFGInt);
Procedure FGIntShiftRightBy32(Var FGInt : TFGInt);
Procedure FGIntShiftLeftBy32Times(Var FGInt : TFGInt; times : LongWord);
Procedure FGIntShiftRightBy32Times(Var FGInt : TFGInt; times : LongWord);
Procedure FGIntShiftLeftBy(Var FGInt : TFGInt; by : LongWord);
Procedure FGIntShiftRightBy(Var FGInt : TFGInt; by : LongWord);
Procedure FGIntToBase2String(Const FGInt : TFGInt; Var S : String);
Procedure Base2StringToFGInt(S : String; Var FGInt : TFGInt);
Procedure Base10StringToFGInt(Base10 : String; Var FGInt : TFGInt);
Procedure FGIntToBase10String(Const FGInt : TFGInt; Var Base10 : String);
Procedure FGIntToBase256String(Const FGInt : TFGInt; Var str256 : String);
Procedure Base256StringToFGInt(str256 : String; Var FGInt : TFGInt);
Procedure ConvertBase256StringToHexString(Str256 : String; Var HexStr : String);
Procedure ConvertHexStringToBase256String(HexStr : String; Var Str256 : String);
Procedure PGPMPIToFGInt(PGPMPI : String; Var FGInt : TFGInt);
Procedure FGIntToPGPMPI(FGInt : TFGInt; Var PGPMPI : String);

Procedure FGIntDivByIntBis(Var FGInt : TFGInt; by : LongWord; Var modres : LongWord);
Procedure FGIntAdd(Const FGInt1, FGInt2 : TFGInt; Var Sum : TFGInt);
Procedure FGIntChangeSign(Var FGInt : TFGInt);
Procedure FGIntSub(Const FGInt1 : TFGInt; Var FGInt2, dif : TFGInt);
Procedure FGIntAddBis(Var FGInt1 : TFGInt; Const FGInt2 : TFGInt);
Procedure FGIntSubBis(Var FGInt1 : TFGInt; Const FGInt2 : TFGInt);
Procedure FGIntPencilPaperMultiply(Const FGInt1, FGInt2 : TFGInt; Var Prod : TFGInt);
Procedure FGIntKaratsubaMultiply(Const FGInt1, FGInt2 : TFGInt; Var Prod : TFGInt);
// Procedure FGIntKaratsubaMultiply(Const FGInt1, FGInt2 : TFGInt; Var Prod : TFGInt; Const karatsubaThreshold : LongWord);
Procedure FGIntMul(Const FGInt1, FGInt2 : TFGInt; Var Prod : TFGInt);
Procedure FGIntPencilPaperSquare(Const FGInt : TFGInt; Var Square : TFGInt);
// Procedure FGIntKaratsubaSquare(Const FGInt : TFGInt; Var Square : TFGInt; Const karatsubaThreshold : LongWord);
Procedure FGIntKaratsubaSquare(Const FGInt : TFGInt; Var Square : TFGInt);
Procedure FGIntSquare(Const FGInt : TFGInt; Var Square : TFGInt);
Procedure FGIntMulByInt(Const FGInt : TFGInt; Var res : TFGInt; by : LongWord);
Procedure FGIntMulByIntbis(Var FGInt : TFGInt; by : LongWord);
Procedure FGIntDivByInt(Const FGInt : TFGInt; Var res : TFGInt; by : LongWord; Var modres : LongWord);
// Procedure FGIntDivByIntBis(Var FGInt : TFGInt; by : LongWord; Var modres : LongWord);
Procedure FGIntExp(Const FGInt, exp : TFGInt; Var res : TFGInt);
Procedure FGIntFac(Const FGInt : TFGInt; Var res : TFGInt);
Procedure FGIntDivMod(Var FGInt1, FGInt2, QFGInt, MFGInt : TFGInt);
Procedure FGIntDiv(Var FGInt1, FGInt2, QFGInt : TFGInt);
Procedure FGIntMulByIntSubBis(Var FGInt1 : TFGInt; Const FGInt2 : TFGInt; divInt : LongWord);
Procedure FGIntMod(Var FGInt1, FGInt2, MFGInt : TFGInt);
Procedure FGIntSquareMod(Var FGInt, Modb, FGIntSM : TFGInt);
Procedure FGIntAddMod(Var FGInt1, FGInt2, base, FGIntres : TFGInt);
Procedure FGIntMulMod(Var FGInt1, FGInt2, base, FGIntres : TFGInt);

Procedure FGIntModBis(Const FGInt : TFGInt; Var FGIntOut : TFGInt; b, head : LongWord);
Procedure FGIntMulModBis(Const FGInt1, FGInt2 : TFGInt; Var Prod : TFGInt; b, head : LongWord);
Procedure FGIntMontgomeryModExp(Var FGInt, exp, modb, res : TFGInt);
Procedure FGIntModExp(Var FGInt, exp, modb, res : TFGInt);

Procedure FGIntGCD(Const FGInt1, FGInt2 : TFGInt; Var GCD : TFGInt);
Procedure FGIntLCM(Const FGInt1, FGInt2 : TFGInt; Var LCM : TFGInt);
Procedure FGIntRandom1(Var Seed, RandomFGInt : TFGInt);
Procedure FGIntRabinMiller(Var FGIntp : TFGInt; nrtest : Longword; Var ok : boolean);
Procedure FGIntBezoutBachet(Var FGInt1, FGInt2, a, b : TFGInt);
Procedure FGIntModInv(Const FGInt1, base : TFGInt; Var Inverse : TFGInt);
Procedure FGIntPrimetest(Var FGIntp : TFGInt; nrRMtests : integer; Var ok : boolean);
Procedure FGIntLegendreSymbol(Var a, p : TFGInt; Var L : integer);
Procedure FGIntSquareRootModP(Square, Prime : TFGInt; Var SquareRoot : TFGInt);


Procedure newtonInitialValue(Const FGInt : TFGInt; Const kZero: LongWord; Var resFGInt : TFGInt);
Procedure newtonInversion(Const fGInt : TFGInt; Const precision : LongWord; Var resFGInt : TFGInt);
Procedure FGIntBarretDivMod(Var FGInt1, FGInt2, QFGInt, MFGInt : TFGInt);
Procedure FGIntBarretMod(Var FGInt1, FGInt2, MFGInt : TFGInt);
Procedure FGIntBarrettModWithInvertedDivisorAndPrecision(Const GInt, divisorFGInt, invertedDivisor : TFGInt; precision : LongWord; Var modFGInt : TFGInt);
// Procedure FGIntBarrettModWithInvertedDivisorAndPrecisionBis(Const fGInt, divisorFGInt, invertedDivisor : TFGInt; precision : LongWord; Var modFGInt : TFGInt);
Procedure FGIntBarretModExp(Var FGInt, exp, modFGInt, res : TFGInt);



Implementation

Var
   primes : Array[1..1228] Of integer =
      (3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127,
      131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227, 229, 233, 239, 241, 251,
      257, 263, 269, 271, 277, 281, 283, 293, 307, 311, 313, 317, 331, 337, 347, 349, 353, 359, 367, 373, 379, 383, 389,
      397, 401, 409, 419, 421, 431, 433, 439, 443, 449, 457, 461, 463, 467, 479, 487, 491, 499, 503, 509, 521, 523, 541,
      547, 557, 563, 569, 571, 577, 587, 593, 599, 601, 607, 613, 617, 619, 631, 641, 643, 647, 653, 659, 661, 673, 677,
      683, 691, 701, 709, 719, 727, 733, 739, 743, 751, 757, 761, 769, 773, 787, 797, 809, 811, 821, 823, 827, 829, 839,
      853, 857, 859, 863, 877, 881, 883, 887, 907, 911, 919, 929, 937, 941, 947, 953, 967, 971, 977, 983, 991, 997, 1009,
      1013, 1019, 1021, 1031, 1033, 1039, 1049, 1051, 1061, 1063, 1069, 1087, 1091, 1093, 1097, 1103, 1109, 1117, 1123,
      1129, 1151, 1153, 1163, 1171, 1181, 1187, 1193, 1201, 1213, 1217, 1223, 1229, 1231, 1237, 1249, 1259, 1277, 1279,
      1283, 1289, 1291, 1297, 1301, 1303, 1307, 1319, 1321, 1327, 1361, 1367, 1373, 1381, 1399, 1409, 1423, 1427, 1429,
      1433, 1439, 1447, 1451, 1453, 1459, 1471, 1481, 1483, 1487, 1489, 1493, 1499, 1511, 1523, 1531, 1543, 1549, 1553,
      1559, 1567, 1571, 1579, 1583, 1597, 1601, 1607, 1609, 1613, 1619, 1621, 1627, 1637, 1657, 1663, 1667, 1669, 1693,
      1697, 1699, 1709, 1721, 1723, 1733, 1741, 1747, 1753, 1759, 1777, 1783, 1787, 1789, 1801, 1811, 1823, 1831, 1847,
      1861, 1867, 1871, 1873, 1877, 1879, 1889, 1901, 1907, 1913, 1931, 1933, 1949, 1951, 1973, 1979, 1987, 1993, 1997,
      1999, 2003, 2011, 2017, 2027, 2029, 2039, 2053, 2063, 2069, 2081, 2083, 2087, 2089, 2099, 2111, 2113, 2129, 2131,
      2137, 2141, 2143, 2153, 2161, 2179, 2203, 2207, 2213, 2221, 2237, 2239, 2243, 2251, 2267, 2269, 2273, 2281, 2287,
      2293, 2297, 2309, 2311, 2333, 2339, 2341, 2347, 2351, 2357, 2371, 2377, 2381, 2383, 2389, 2393, 2399, 2411, 2417,
      2423, 2437, 2441, 2447, 2459, 2467, 2473, 2477, 2503, 2521, 2531, 2539, 2543, 2549, 2551, 2557, 2579, 2591, 2593,
      2609, 2617, 2621, 2633, 2647, 2657, 2659, 2663, 2671, 2677, 2683, 2687, 2689, 2693, 2699, 2707, 2711, 2713, 2719,
      2729, 2731, 2741, 2749, 2753, 2767, 2777, 2789, 2791, 2797, 2801, 2803, 2819, 2833, 2837, 2843, 2851, 2857, 2861,
      2879, 2887, 2897, 2903, 2909, 2917, 2927, 2939, 2953, 2957, 2963, 2969, 2971, 2999, 3001, 3011, 3019, 3023, 3037,
      3041, 3049, 3061, 3067, 3079, 3083, 3089, 3109, 3119, 3121, 3137, 3163, 3167, 3169, 3181, 3187, 3191, 3203, 3209,
      3217, 3221, 3229, 3251, 3253, 3257, 3259, 3271, 3299, 3301, 3307, 3313, 3319, 3323, 3329, 3331, 3343, 3347, 3359,
      3361, 3371, 3373, 3389, 3391, 3407, 3413, 3433, 3449, 3457, 3461, 3463, 3467, 3469, 3491, 3499, 3511, 3517, 3527,
      3529, 3533, 3539, 3541, 3547, 3557, 3559, 3571, 3581, 3583, 3593, 3607, 3613, 3617, 3623, 3631, 3637, 3643, 3659,
      3671, 3673, 3677, 3691, 3697, 3701, 3709, 3719, 3727, 3733, 3739, 3761, 3767, 3769, 3779, 3793, 3797, 3803, 3821,
      3823, 3833, 3847, 3851, 3853, 3863, 3877, 3881, 3889, 3907, 3911, 3917, 3919, 3923, 3929, 3931, 3943, 3947, 3967,
      3989, 4001, 4003, 4007, 4013, 4019, 4021, 4027, 4049, 4051, 4057, 4073, 4079, 4091, 4093, 4099, 4111, 4127, 4129,
      4133, 4139, 4153, 4157, 4159, 4177, 4201, 4211, 4217, 4219, 4229, 4231, 4241, 4243, 4253, 4259, 4261, 4271, 4273,
      4283, 4289, 4297, 4327, 4337, 4339, 4349, 4357, 4363, 4373, 4391, 4397, 4409, 4421, 4423, 4441, 4447, 4451, 4457,
      4463, 4481, 4483, 4493, 4507, 4513, 4517, 4519, 4523, 4547, 4549, 4561, 4567, 4583, 4591, 4597, 4603, 4621, 4637,
      4639, 4643, 4649, 4651, 4657, 4663, 4673, 4679, 4691, 4703, 4721, 4723, 4729, 4733, 4751, 4759, 4783, 4787, 4789,
      4793, 4799, 4801, 4813, 4817, 4831, 4861, 4871, 4877, 4889, 4903, 4909, 4919, 4931, 4933, 4937, 4943, 4951, 4957,
      4967, 4969, 4973, 4987, 4993, 4999, 5003, 5009, 5011, 5021, 5023, 5039, 5051, 5059, 5077, 5081, 5087, 5099, 5101,
      5107, 5113, 5119, 5147, 5153, 5167, 5171, 5179, 5189, 5197, 5209, 5227, 5231, 5233, 5237, 5261, 5273, 5279, 5281,
      5297, 5303, 5309, 5323, 5333, 5347, 5351, 5381, 5387, 5393, 5399, 5407, 5413, 5417, 5419, 5431, 5437, 5441, 5443,
      5449, 5471, 5477, 5479, 5483, 5501, 5503, 5507, 5519, 5521, 5527, 5531, 5557, 5563, 5569, 5573, 5581, 5591, 5623,
      5639, 5641, 5647, 5651, 5653, 5657, 5659, 5669, 5683, 5689, 5693, 5701, 5711, 5717, 5737, 5741, 5743, 5749, 5779,
      5783, 5791, 5801, 5807, 5813, 5821, 5827, 5839, 5843, 5849, 5851, 5857, 5861, 5867, 5869, 5879, 5881, 5897, 5903,
      5923, 5927, 5939, 5953, 5981, 5987, 6007, 6011, 6029, 6037, 6043, 6047, 6053, 6067, 6073, 6079, 6089, 6091, 6101,
      6113, 6121, 6131, 6133, 6143, 6151, 6163, 6173, 6197, 6199, 6203, 6211, 6217, 6221, 6229, 6247, 6257, 6263, 6269,
      6271, 6277, 6287, 6299, 6301, 6311, 6317, 6323, 6329, 6337, 6343, 6353, 6359, 6361, 6367, 6373, 6379, 6389, 6397,
      6421, 6427, 6449, 6451, 6469, 6473, 6481, 6491, 6521, 6529, 6547, 6551, 6553, 6563, 6569, 6571, 6577, 6581, 6599,
      6607, 6619, 6637, 6653, 6659, 6661, 6673, 6679, 6689, 6691, 6701, 6703, 6709, 6719, 6733, 6737, 6761, 6763, 6779,
      6781, 6791, 6793, 6803, 6823, 6827, 6829, 6833, 6841, 6857, 6863, 6869, 6871, 6883, 6899, 6907, 6911, 6917, 6947,
      6949, 6959, 6961, 6967, 6971, 6977, 6983, 6991, 6997, 7001, 7013, 7019, 7027, 7039, 7043, 7057, 7069, 7079, 7103,
      7109, 7121, 7127, 7129, 7151, 7159, 7177, 7187, 7193, 7207, 7211, 7213, 7219, 7229, 7237, 7243, 7247, 7253, 7283,
      7297, 7307, 7309, 7321, 7331, 7333, 7349, 7351, 7369, 7393, 7411, 7417, 7433, 7451, 7457, 7459, 7477, 7481, 7487,
      7489, 7499, 7507, 7517, 7523, 7529, 7537, 7541, 7547, 7549, 7559, 7561, 7573, 7577, 7583, 7589, 7591, 7603, 7607,
      7621, 7639, 7643, 7649, 7669, 7673, 7681, 7687, 7691, 7699, 7703, 7717, 7723, 7727, 7741, 7753, 7757, 7759, 7789,
      7793, 7817, 7823, 7829, 7841, 7853, 7867, 7873, 7877, 7879, 7883, 7901, 7907, 7919, 7927, 7933, 7937, 7949, 7951,
      7963, 7993, 8009, 8011, 8017, 8039, 8053, 8059, 8069, 8081, 8087, 8089, 8093, 8101, 8111, 8117, 8123, 8147, 8161,
      8167, 8171, 8179, 8191, 8209, 8219, 8221, 8231, 8233, 8237, 8243, 8263, 8269, 8273, 8287, 8291, 8293, 8297, 8311,
      8317, 8329, 8353, 8363, 8369, 8377, 8387, 8389, 8419, 8423, 8429, 8431, 8443, 8447, 8461, 8467, 8501, 8513, 8521,
      8527, 8537, 8539, 8543, 8563, 8573, 8581, 8597, 8599, 8609, 8623, 8627, 8629, 8641, 8647, 8663, 8669, 8677, 8681,
      8689, 8693, 8699, 8707, 8713, 8719, 8731, 8737, 8741, 8747, 8753, 8761, 8779, 8783, 8803, 8807, 8819, 8821, 8831,
      8837, 8839, 8849, 8861, 8863, 8867, 8887, 8893, 8923, 8929, 8933, 8941, 8951, 8963, 8969, 8971, 8999, 9001, 9007,
      9011, 9013, 9029, 9041, 9043, 9049, 9059, 9067, 9091, 9103, 9109, 9127, 9133, 9137, 9151, 9157, 9161, 9173, 9181,
      9187, 9199, 9203, 9209, 9221, 9227, 9239, 9241, 9257, 9277, 9281, 9283, 9293, 9311, 9319, 9323, 9337, 9341, 9343,
      9349, 9371, 9377, 9391, 9397, 9403, 9413, 9419, 9421, 9431, 9433, 9437, 9439, 9461, 9463, 9467, 9473, 9479, 9491,
      9497, 9511, 9521, 9533, 9539, 9547, 9551, 9587, 9601, 9613, 9619, 9623, 9629, 9631, 9643, 9649, 9661, 9677, 9679,
      9689, 9697, 9719, 9721, 9733, 9739, 9743, 9749, 9767, 9769, 9781, 9787, 9791, 9803, 9811, 9817, 9829, 9833, 9839,
      9851, 9857, 9859, 9871, 9883, 9887, 9901, 9907, 9923, 9929, 9931, 9941, 9949, 9967, 9973);
   chr64 : Array[1..64] Of char = ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
      'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
      'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y',
      'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/');
    karatsubaThreshold : Longword = 90;
    karatsubaSquaringThreshold : Longword = 175;











// Destroy a FGInt to free memory

Procedure FGIntDestroy(Var FGInt : TFGInt);
Begin
   FGInt.Number := Nil;
End;


// Returns the FGInt in absolute value

Procedure FGIntAbs(Var FGInt : TFGInt);
Begin
   FGInt.Sign := positive;
End;


// Copy a FGInt1 into FGInt2

Procedure FGIntCopy(Const FGInt1 : TFGInt; Var FGInt2 : TFGInt);
Begin
   FGInt2.Sign := FGInt1.Sign;
   FGInt2.Number := Nil;
   FGInt2.Number := Copy(FGInt1.Number, 0, FGInt1.Number[0] + 1);
End;


// Compare 2 FGInts in absolute value, returns
// Lt if FGInt1 > FGInt2, St if FGInt1 < FGInt2, Eq if FGInt1 = FGInt2,
// Er otherwise

Function FGIntCompareAbs(Const FGInt1, FGInt2 : TFGInt) : TCompare;
Var
   size1, size2, i : LongWord;
Begin
   FGIntCompareAbs := Er;
   size1 := FGInt1.Number[0];
   size2 := FGInt2.Number[0];
   If size1 > size2 Then FGIntCompareAbs := Lt Else
      If size1 < size2 Then FGIntCompareAbs := St Else
      Begin
         i := size2;
         While (FGInt1.Number[i] = FGInt2.Number[i]) And (i > 1) Do i := i - 1;
         If FGInt1.Number[i] = FGInt2.Number[i] Then FGIntCompareAbs := Eq Else
            If FGInt1.Number[i] < FGInt2.Number[i] Then FGIntCompareAbs := St Else
               If FGInt1.Number[i] > FGInt2.Number[i] Then FGIntCompareAbs := Lt;
      End;
End;


// Shift the FGInt to the left in base 2 notation, ie FGInt = FGInt * 2

Procedure FGIntShiftLeft(Var FGInt : TFGInt);
Var
   i, size : LongWord;
   m, l: uint64;
Begin
   size := FGInt.Number[0];
   l := 0;
   For i := 1 To Size Do
   Begin
      m := FGInt.Number[i];
      FGInt.Number[i] := ((m Shl 1) Or l) And 4294967295;
      l := m shr 31;
   End;
   If l <> 0 Then
   Begin
      setlength(FGInt.Number, size + 2);
      FGInt.Number[size + 1] := l;
      FGInt.Number[0] := size + 1;
   End;
End;


// FGInt = FGInt * 4294967296

Procedure FGIntShiftLeftBy32(Var FGInt : TFGInt);
Var
   f1, f2 : LongWord;
   i, size : longint;
Begin
   if ((FGInt.Number[0] = 1) and (FGInt.Number[1] = 0)) then Exit;
   size := FGInt.Number[0];
   SetLength(FGInt.Number, size + 2);
   f1 := 0;
   For i := 1 To (size + 1) Do
   Begin
      f2 := FGInt.Number[i];
      FGInt.Number[i] := f1;
      f1 := f2;
   End;
   FGInt.Number[0] := size + 1;
End;


// Shift the FGInt to the right in base 2 notation, ie FGInt = FGInt div 2

Procedure FGIntShiftRight(Var FGInt : TFGInt);
Var
   l, m, i, size : LongWord;
Begin
   size := FGInt.Number[0];
   l := 0;
   For i := size Downto 1 Do
   Begin
      m := FGInt.Number[i] And 1;
      FGInt.Number[i] := (FGInt.Number[i] Shr 1) Or l;
      l := m Shl 31;
   End;
   If (FGInt.Number[size] = 0) And (size > 1) Then
   Begin
      setlength(FGInt.Number, size);
      FGInt.Number[0] := size - 1;
   End;
End;


// FGInt = FGInt / 4294967296

Procedure FGIntShiftRightBy32(Var FGInt : TFGInt);
Var
   size, i : LongWord;
Begin
   size := FGInt.Number[0];
   If size > 1 Then
   Begin
      For i := 1 To size - 1 Do
      Begin
         FGInt.Number[i] := FGInt.Number[i + 1];
      End;
      SetLength(FGInt.Number, Size);
      FGInt.Number[0] := size - 1;
   End
   Else
      FGInt.Number[1] := 0;
End;


Procedure FGIntShiftLeftBy32Times(Var FGInt : TFGInt; times : LongWord);
Var
   i, size : longint;
Begin
   if times = 0 then Exit;
   if not ((FGInt.Number[0] = 1) and (FGInt.Number[1] = 0)) then
   begin
      size := FGInt.Number[0];
      SetLength(FGInt.Number, size + 1 + times);
      For i := size Downto 1 Do
      Begin
         FGInt.Number[i + times] := FGInt.Number[i];
      End;
      For i := 1 To times Do
      Begin
         FGInt.Number[i] := 0;
      End;
      FGInt.Number[0] := size + times;
   end;
End;

Procedure FGIntShiftRightBy32Times(Var FGInt : TFGInt; times : LongWord);
Var
   i, size : longint;
Begin
   if times = 0 then Exit;
   size := FGInt.Number[0];
   if times >= size then
   begin
      SetLength(FGInt.Number, 2);
      FGInt.Number[0] := 1;
      FGInt.Number[1] := 0;
   end 
   else if not ((FGInt.Number[0] = 1) and (FGInt.Number[1] = 0)) then
   begin
      For i := 1 to (size - times) Do
      Begin
         FGInt.Number[i] := FGInt.Number[i + times];
      End;
      FGInt.Number[0] := size - times;
      SetLength(FGInt.Number, size + 1 - times);
   end;
End;


Procedure FGIntShiftLeftBy(Var FGInt : TFGInt; by : LongWord);
Var
   i, size, m32Shift : LongWord;
Begin
   if by = 0 then Exit;

   m32Shift := by mod 32;
   size := FGInt.Number[0];
   if (not ((size = 1) and (FGInt.Number[1] = 0))) and (m32Shift <> 0) then
   begin
      if ((FGInt.Number[size] shr (32 - m32Shift)) > 0) then 
      begin
         SetLength(FGInt.Number, size + 2);
         FGInt.Number[0] := size + 1;
         FGInt.Number[size + 1] := 0;
         size := size + 1;
      end;
      For i := size - 1 Downto 1 Do
      Begin
         FGInt.Number[i + 1] := (FGInt.Number[i + 1] shl m32Shift) or (FGInt.Number[i] shr (32 - m32Shift));
      End;
         FGInt.Number[1] := (FGInt.Number[1] shl m32Shift);
   end;
   if (by div 32) > 0 then
      FGIntShiftLeftBy32Times(FGInt, by div 32);
End;

Procedure FGIntShiftRightBy(Var FGInt : TFGInt; by : LongWord);
Var
   i, size, shift : LongWord;
Begin
   if by = 0 then Exit;
   if (by div 32) > 0 then
      FGIntShiftRightBy32Times(FGInt, by div 32);
   shift := by mod 32;
   size := FGInt.Number[0];
   if (not ((FGInt.Number[0] = 1) and (FGInt.Number[1] = 0))) and (shift > 0) then
   begin
      For i := 1 to size - 1 Do
      Begin
         FGInt.Number[i] := (FGInt.Number[i] shr shift) or (FGInt.Number[i + 1] shl (32 - shift));
      End;
      FGInt.Number[size] := (FGInt.Number[size] shr shift);
      if FGInt.Number[size] = 0 then 
      begin
         SetLength(FGInt.Number, size);
         FGInt.Number[0] := size - 1;
      end;
   end;

End;






// Convert a FGInt to a binary string (base 2) & visa versa

Procedure FGIntToBase2String(Const FGInt : TFGInt; Var S : String);
Var
   i : LongWord;
   j : integer;
Begin
   S := '';
   For i := 1 To FGInt.Number[0] Do
   Begin
      For j := 0 To 31 Do
         If (1 And (FGInt.Number[i] Shr j)) = 1 Then
            S := '1' + S
         Else
            S := '0' + S;
   End;
   While (length(S) > 1) And (S[1] = '0') Do
      delete(S, 1, 1);
   If S = '' Then S := '0';
End;


Procedure Base2StringToFGInt(S : String; Var FGInt : TFGInt);
Var
   i, j, size : LongWord;
Begin
   While (S[1] = '0') And (length(S) > 1) Do
      delete(S, 1, 1);
   size := length(S) Div 32;
   If (length(S) Mod 32) <> 0 Then size := size + 1;
   SetLength(FGInt.Number, (size + 1));
   FGInt.Number[0] := size;
   j := 1;
   FGInt.Number[j] := 0;
   i := 0;
   While length(S) > 0 Do
   Begin
      If S[length(S)] = '1' Then
         FGInt.Number[j] := FGInt.Number[j] Or (1 Shl i);
      i := i + 1;
      If i = 32 Then
      Begin
         i := 0;
         j := j + 1;
         If j <= size Then FGInt.Number[j] := 0;
      End;
      delete(S, length(S), 1);
   End;
   FGInt.Sign := positive;
End;



// Convert a base 10 string to a FGInt

Procedure Base10StringToFGInt(Base10 : String; Var FGInt : TFGInt);
Var
   i, size : LongWord;
   j : word;
   S, x : String;
   sign : TSign;

   Procedure FGIntDivByIntBis1(Var GInt : TFGInt; by : LongWord; Var modres : word);
   Var
      i, size, rest, temp : LongWord;
   Begin
      size := GInt.Number[0];
      temp := 0;
      For i := size Downto 1 Do
      Begin
         temp := temp * 10000;
         rest := temp + GInt.Number[i];
         GInt.Number[i] := rest Div by;
         temp := rest Mod by;
      End;
      modres := temp;
      While (GInt.Number[size] = 0) And (size > 1) Do
         size := size - 1;
      If size <> GInt.Number[0] Then
      Begin
         SetLength(GInt.Number, size + 1);
         GInt.Number[0] := size;
      End;
   End;

Begin
   While (Not (Base10[1] In ['-', '0'..'9'])) And (length(Base10) > 1) Do
      delete(Base10, 1, 1);
   If copy(Base10, 1, 1) = '-' Then
   Begin
      Sign := negative;
      delete(Base10, 1, 1);
   End
   Else
      Sign := positive;
   While (length(Base10) > 1) And (copy(Base10, 1, 1) = '0') Do
      delete(Base10, 1, 1);
   size := length(Base10) Div 4;
   If (length(Base10) Mod 4) <> 0 Then size := size + 1;
   SetLength(FGInt.Number, size + 1);
   FGInt.Number[0] := size;
   For i := 1 To (size - 1) Do
   Begin
      x := copy(Base10, length(Base10) - 3, 4);
      FGInt.Number[i] := StrToInt(x);
      delete(Base10, length(Base10) - 3, 4);
   End;
   FGInt.Number[size] := StrToInt(Base10);

   S := '';
   While (FGInt.Number[0] <> 1) Or (FGInt.Number[1] <> 0) Do
   Begin
      FGIntDivByIntBis1(FGInt, 2, j);
      S := inttostr(j) + S;
   End;
   If S = '' Then S := '0';
   FGIntDestroy(FGInt);
   Base2StringToFGInt(S, FGInt);
   FGInt.Sign := sign;
End;


// Convert a FGInt to a base 10 string

Procedure FGIntToBase10String(Const FGInt : TFGInt; Var Base10 : String);
Var
   S : String;
   j : LongWord;
   temp : TFGInt;
Begin
   FGIntCopy(FGInt, temp);
   Base10 := '';
   While not ((temp.Number[0] = 1) and (temp.Number[1] = 0)) Do
   Begin
      FGIntDivByIntBis(temp, 10000, j);
      S := IntToStr(j);
      While Length(S) < 4 Do
      begin
         S := '0' + S;
      end;
      Base10 := S + Base10;
   End;
   Base10 := '0' + Base10;
   While (length(Base10) > 1) And (Base10[1] = '0') Do
      delete(Base10, 1, 1);
   If FGInt.Sign = negative Then Base10 := '-' + Base10;
End;



// Convert a FGInt to an base 256 string & visa versa

Procedure FGIntToBase256String(Const FGInt : TFGInt; Var str256 : String);
Var
   i, j : LongWord;
   b : byte;
Begin
   str256 := '';
   For i := 1 To FGInt.Number[0] Do
   Begin
      for j := 0 to 3 do
      begin
         b := (FGInt.Number[i] shr (j * 8)) and 255;
         str256 := chr(b) + str256;
      end;
   End;
End;


Procedure Base256StringToFGInt(str256 : String; Var FGInt : TFGInt);
Var
   temp : String;
   i, l, j : LongWord;
Begin
   temp := str256;
   while length(temp) mod 4 <> 0 do temp := chr(0) + temp;
   l := length(temp) div 4;
   FGInt.sign := positive;
   setLength(FGInt.Number, l + 1);
   FGInt.Number[0] := l;
   For i := 1 To l Do 
   begin
      j := 4 * (i - 1);
      FGInt.Number[l - i + 1] := ord(temp[j + 1]);
      FGInt.Number[l - i + 1] := (FGInt.Number[l - i + 1] shl 8) or ord(temp[j + 2]);
      FGInt.Number[l - i + 1] := (FGInt.Number[l - i + 1] shl 8) or ord(temp[j + 3]);
      FGInt.Number[l - i + 1] := (FGInt.Number[l - i + 1] shl 8) or ord(temp[j + 4]);
   end;
End;


// Convert base 256 strings to base 16 (HexaDecimal) strings and visa versa

Procedure ConvertBase256StringToHexString(Str256 : String; Var HexStr : String);
Var
   i : longint;
   b : byte;
Begin
   HexStr := '';
   For i := 1 To length(str256) Do
   Begin
      b := ord(str256[i]);
      If (b Shr 4) < 10 Then HexStr := HexStr + chr(48 + (b Shr 4))
      Else HexStr := HexStr + chr(55 + (b Shr 4));
      If (b And 15) < 10 Then HexStr := HexStr + chr(48 + (b And 15))
      Else HexStr := HexStr + chr(55 + (b And 15));
   End;
End;


Procedure ConvertHexStringToBase256String(HexStr : String; Var Str256 : String);
Var
   i : longint;
   b, h1, h2 : byte;
   temp : string;
Begin
   Str256 := '';
   If (length(Hexstr) mod 2) = 1 Then temp := '0' + HexStr Else temp := HexStr;
   For i := 1 To (length(temp) Div 2) Do
   Begin
      h2 := ord(temp[2 * i]);
      h1 := ord(temp[2 * i - 1]);
      If h1 < 58 Then
         b := ((h1 - 48) Shl 4)
      Else
         b := ((h1 - 55) Shl 4);
      If h2 < 58 Then
         b := (b Or (h2 - 48))
      Else
         b := (b Or ((h2 - 55) and 15));
      Str256 := Str256 + chr(b);
   End;
End;


// Convert an MPI (Multiple Precision Integer, PGP style) to an FGInt &
// visa versa

Procedure PGPMPIToFGInt(PGPMPI : String; Var FGInt : TFGInt);
Var
   temp : String;
Begin
   temp := PGPMPI;
   delete(temp, 1, 2);
   Base256StringToFGInt(temp, FGInt);
End;


Procedure FGIntToPGPMPI(FGInt : TFGInt; Var PGPMPI : String);
Var
   len, i : word;
   c : char;
   b : byte;
Begin
   FGIntToBase256String(FGInt, PGPMPI);
   len := length(PGPMPI) * 8;
   c := PGPMPI[1];
   For i := 7 Downto 0 Do If (ord(c) Shr i) = 0 Then len := len - 1 Else break;
   b := len Mod 256;
   PGPMPI := chr(b) + PGPMPI;
   b := len Div 256;
   PGPMPI := chr(b) + PGPMPI;
End;

// divide a FGInt by an integer, FGInt = FGInt * by + modres

Procedure FGIntDivByIntBis(Var FGInt : TFGInt; by : LongWord; Var modres : LongWord);
Var
   i, size : LongWord;
   temp, rest : uint64;
Begin
   size := FGInt.Number[0];
   temp := 0;
   For i := size Downto 1 Do
   Begin
      temp := temp Shl 32;
      rest := temp Or FGInt.Number[i];
      FGInt.Number[i] := rest Div by;
      temp := rest Mod by;
   End;
   modres := temp;
   While (FGInt.Number[size] = 0) And (size > 1) Do
      size := size - 1;
   If size <> FGInt.Number[0] Then
   Begin
      SetLength(FGInt.Number, size + 1);
      FGInt.Number[0] := size;
   End;
End;



// Add 2 FGInts, FGInt1 + FGInt2 = Sum

Procedure FGIntAdd(Const FGInt1, FGInt2 : TFGInt; Var Sum : TFGInt);
Var
   i, size1, size2, size, rest : LongWord;
   Trest : int64;
Begin
   size1 := FGInt1.Number[0];
   size2 := FGInt2.Number[0];
   If size1 < size2 Then
      FGIntAdd(FGInt2, FGInt1, Sum)
   Else
   Begin
      If FGInt1.Sign = FGInt2.Sign Then
      Begin
         Sum.Sign := FGInt1.Sign;
         setlength(Sum.Number, (size1 + 2));
         rest := 0;
         For i := 1 To size2 Do
         Begin
            Trest := FGInt1.Number[i];
            Trest := Trest + FGInt2.Number[i];
            Trest := Trest + rest;
            Sum.Number[i] := Trest And 4294967295;
            rest := Trest Shr 32;
         End;
         For i := (size2 + 1) To size1 Do
         Begin
            Trest := FGInt1.Number[i] + rest;
            Sum.Number[i] := Trest And 4294967295;
            rest := Trest Shr 32;
         End;
         size := size1 + 1;
         Sum.Number[0] := size;
         Sum.Number[size] := rest;
         While (Sum.Number[size] = 0) And (size > 1) Do
            size := size - 1;
         If Sum.Number[0] <> size Then SetLength(Sum.Number, size + 1);
         Sum.Number[0] := size;
      End
      Else
      Begin
         If FGIntCompareAbs(FGInt2, FGInt1) = Lt Then
            FGIntAdd(FGInt2, FGInt1, Sum)
         Else
         Begin
            SetLength(Sum.Number, (size1 + 1));
            rest := 0;
            For i := 1 To size2 Do
            Begin
               Trest := 4294967296;
               TRest := Trest + FGInt1.Number[i];
               TRest := Trest - FGInt2.Number[i];
               TRest := Trest - rest;
               Sum.Number[i] := Trest And 4294967295;
               If (Trest > 4294967295) Then
                  rest := 0
               Else
                  rest := 1;
            End;
            For i := (size2 + 1) To size1 Do
            Begin
               Trest := 4294967296;
               TRest := Trest + FGInt1.Number[i];
               TRest := Trest - rest;
               Sum.Number[i] := Trest And 4294967295;
               If (Trest > 4294967295) Then
                  rest := 0
               Else
                  rest := 1;
            End;
            size := size1;
            While (Sum.Number[size] = 0) And (size > 1) Do
               size := size - 1;
            If size <> size1 Then SetLength(Sum.Number, size + 1);
            Sum.Number[0] := size;
            Sum.Sign := FGInt1.Sign;
         End;
      End;
   End;
End;



Procedure FGIntChangeSign(Var FGInt : TFGInt);
Begin
   If FGInt.Sign = negative Then FGInt.Sign := positive Else FGInt.Sign := negative;
End;


// Substract 2 FGInts, FGInt1 - FGInt2 = dif

Procedure FGIntSub(Const FGInt1 : TFGInt; Var FGInt2, dif : TFGInt);
Begin
   FGIntChangeSign(FGInt2);
   FGIntAdd(FGInt1, FGInt2, dif);
   FGIntChangeSign(FGInt2);
End;


Procedure FGIntAddBis(Var FGInt1 : TFGInt; Const FGInt2 : TFGInt);
Var
   i, size1, size2, rest, minLength, maxLength : LongWord;
   Trest : int64;
   tmpFGInt1, tmpFGInt2 : TFGInt;
Begin
   size1 := FGInt1.Number[0];
   size2 := FGInt2.Number[0];
   if size1 < size2 then 
   begin
      minLength := size1;
      maxLength := size2;
      FGIntCopy(FGInt2, tmpFGInt1);
      tmpFGInt2 := FGInt1;
   end else 
   begin
      minLength := size2;
      maxLength := size1;
      tmpFGInt2 := FGInt2;
      tmpFGInt1 := FGInt1;
   end;
   rest := 0;
// if size1 < size2 then writeln('uh-ohhhh add '+IntToStr(size1) + ' ' + inttostr(size2) + ' hahaha fys: ' + inttostr(FGInt1.Number[1]));
   For i := 1 To minLength Do
   Begin
      Trest := tmpFGInt1.Number[i];
      Trest := Trest + tmpFGInt2.Number[i] + rest;
      rest := Trest Shr 32;
      tmpFGInt1.Number[i] := Trest And 4294967295;
   End;
   For i := minLength + 1 To maxLength Do
   Begin
      if rest = 0 then break;
      Trest := tmpFGInt1.Number[i];
      Trest := Trest + rest;
      rest := Trest Shr 32;
      tmpFGInt1.Number[i] := Trest And 4294967295;
   End;
   If rest <> 0 Then
   Begin
      SetLength(tmpFGInt1.Number, maxLength + 2);
      tmpFGInt1.Number[0] := maxLength + 1;
      tmpFGInt1.Number[maxLength + 1] := rest;
   End;
   If size1 < maxLength then
   begin
      FGIntDestroy(FGInt1);
   end; 
   FGInt1 := tmpFGInt1;
End;


// FGInt1 = FGInt1 - FGInt2, use only when 0 < FGInt2 < FGInt1

Procedure FGIntSubBis(Var FGInt1 : TFGInt; Const FGInt2 : TFGInt);
Var
   i, size1, size2, rest : LongWord;
   Trest : int64;
Begin
   size1 := FGInt1.Number[0];
   size2 := FGInt2.Number[0];
// if size1 < size2 then writeln('uh-ohhhh '+IntToStr(size1) + ' ' + inttostr(size2) + ' hahaha fys: ' + inttostr(FGInt1.Number[1]));
   rest := 0;
   For i := 1 To size2 Do
   Begin
      Trest := (4294967296 Or FGInt1.Number[i]) - FGInt2.Number[i] - rest;
      If (Trest > 4294967295) Then
         rest := 0
      Else
         rest := 1;
      FGInt1.Number[i] := Trest And 4294967295;
   End;
   For i := size2 + 1 To size1 Do
   Begin
      Trest := (4294967296 Or FGInt1.Number[i]) - rest;
      If (Trest > 4294967295) Then
         rest := 0
      Else
         rest := 1;
      FGInt1.Number[i] := Trest And 4294967295;
   End;
   i := size1;
   While (FGInt1.Number[i] = 0) And (i > 1) Do
      i := i - 1;
   If i <> size1 Then
   Begin
      SetLength(FGInt1.Number, i + 1);
      FGInt1.Number[0] := i;
   End;
End;



// Multiply 2 FGInts with the pencil-and-paper method

Procedure FGIntPencilPaperMultiply(Const FGInt1, FGInt2 : TFGInt; Var Prod : TFGInt);
Var
   i, j, size, size1, size2, rest : LongWord;
   Trest : uint64;
Begin
   size1 := FGInt1.Number[0];
   size2 := FGInt2.Number[0];
   size := size1 + size2;
   SetLength(Prod.Number, (size + 1));
   For i := 1 To size Do
      Prod.Number[i] := 0;

   For i := 1 To size2 Do
   Begin
      rest := 0;
      For j := 1 To size1 Do
      Begin
         Trest := FGInt1.Number[j];
         Trest := Trest * FGInt2.Number[i];
         Trest := Trest + Prod.Number[j + i - 1];
         Trest := Trest + rest;
         Prod.Number[j + i - 1] := Trest;
         rest := Trest Shr 32;
      End;
      Prod.Number[i + size1] := rest;
   End;

   Prod.Number[0] := size;
   While (Prod.Number[size] = 0) And (size > 1) Do
      size := size - 1;
   If size <> Prod.Number[0] Then
   Begin
      SetLength(Prod.Number, size + 1);
      Prod.Number[0] := size;
   End;
   If FGInt1.Sign = FGInt2.Sign Then
      Prod.Sign := Positive
   Else
      prod.Sign := negative;
End;


// Procedure FGIntKaratsubaMultiply(Const FGInt1, FGInt2 : TFGInt; Var Prod : TFGInt; Const karatsubaThreshold : LongWord);

Procedure FGIntKaratsubaMultiply(Const FGInt1, FGInt2 : TFGInt; Var Prod : TFGInt);
Var
   halfLength, size1, size2, max : LongWord;
   f1a, f1b, f2a, f2b, faa, fbb, fab, f1ab, f2ab, zero : TFGInt;
Begin
   size1 := FGInt1.Number[0];
   size2 := FGInt2.Number[0];
   if (size1 < size2) Then max := size2 Else max := size1;
   if (max < karatsubaThreshold) Then 
   Begin
      FGIntPencilPaperMultiply(FGInt1, FGInt2, Prod);
      Exit;
   End; 

   if (size1 < max) Then
   Begin
      // FGIntKaratsubaMultiply(FGInt2, FGInt1, Prod, karatsubaThreshold);
      FGIntKaratsubaMultiply(FGInt2, FGInt1, Prod);
      Exit;
   End;

   halfLength := (max Div 2) + (max mod 2);
   f1b.Sign := FGInt1.Sign;
   f1a.Sign := FGInt1.Sign;
   f1b.Number := copy(FGInt1.Number, 0, halfLength + 1);
   f1b.Number[0] := halfLength;
   f1a.Number := copy(FGInt1.Number, halfLength, size1 - halfLength + 1);
   f1a.Number[0] := size1 - halfLength;

   Base2StringToFGInt('0', zero);

   if (size2 <= halfLength) then
   Begin
      FGIntCopy(zero, f2a);
      FGIntCopy(FGInt2, f2b);
   End else
   Begin
      f2b.Sign := FGInt2.Sign;
      f2a.Sign := FGInt2.Sign;
      f2b.Number := copy(FGInt2.Number, 0, halfLength + 1);
      f2b.Number[0] := halfLength;
      f2a.Number := copy(FGInt2.Number, halfLength, size2 - halfLength + 1);
      f2a.Number[0] := size2 - halfLength;
   end;

   if ((FGIntCompareAbs(f1a, zero) <> Eq) and (FGIntCompareAbs(f2a, zero) <> Eq)) then
   begin
      FGIntKaratsubaMultiply(f1a, f2a, faa);
      // FGIntKaratsubaMultiply(f1a, f2a, faa, karatsubaThreshold);
   end 
   else
   begin
      FGIntCopy(zero, faa);
   end;

   if ((FGIntCompareAbs(f1b, zero) <> Eq) and (FGIntCompareAbs(f2b, zero) <> Eq)) then
   begin
      // FGIntKaratsubaMultiply(f1b, f2b, fbb, karatsubaThreshold);
      FGIntKaratsubaMultiply(f1b, f2b, fbb);
   end 
   else
   begin
      FGIntCopy(zero, fbb);
   end;


   FGIntAdd(f1a, f1b, f1ab);
   FGIntAdd(f2a, f2b, f2ab);
   FGIntDestroy(f1a);   
   FGIntDestroy(f1b);   
   FGIntDestroy(f2a);   
   FGIntDestroy(f2b);   

   if ((FGIntCompareAbs(f1ab, zero) <> Eq) and (FGIntCompareAbs(f2ab, zero) <> Eq)) then
   begin
      // FGIntKaratsubaMultiply(f1ab, f2ab, fab, karatsubaThreshold);
      FGIntKaratsubaMultiply(f1ab, f2ab, fab);
   end
   else
   begin
      FGIntCopy(zero, fab);
   end;


   FGIntDestroy(zero);
   FGIntDestroy(f1ab);
   FGIntDestroy(f2ab);
   FGIntSubBis(fab, faa);
   FGIntSubBis(fab, fbb);


   Prod := faa;
   FGIntShiftLeftBy32Times(Prod, halfLength * 2);
   FGIntShiftLeftBy32Times(fab, halfLength);
   FGIntAddBis(prod, fab);
   FGIntAddBis(prod, fbb);

   if fGInt1.sign = fGInt2.sign then Prod.sign := positive else Prod.sign := negative;

   FGIntDestroy(fab);
   FGIntDestroy(fbb);
End;



// Multiply 2 FGInts, FGInt1 * FGInt2 = Prod

Procedure FGIntMul(Const FGInt1, FGInt2 : TFGInt; Var Prod : TFGInt);
Var
   size1, size2 : LongWord;
Begin
   size1 := FGInt1.Number[0];
   size2 := FGInt2.Number[0];
   if (size1 > karatsubaThreshold) or (size2 > karatsubaThreshold) then
      FGIntKaratsubaMultiply(FGInt1, FGInt2, Prod)
   else
      FGIntPencilPaperMultiply(FGInt1, FGInt2, Prod);
End;



// Square a FGInt, FGInt² = Square

Procedure FGIntPencilPaperSquare(Const FGInt : TFGInt; Var Square : TFGInt);
Var
   size, size1, i, j, k : LongWord;
   Trest, overflow, rest, tmpInt : uint64;
Begin
   size1 := FGInt.Number[0];
   size := 2 * size1;
   SetLength(Square.Number, (size + 1));
   Square.Number[0] := size;
   For i := 1 To size Do
      Square.Number[i] := 0;
   For i := 1 To size1 Do
   Begin
      tmpInt := FGInt.Number[i];
      Trest := tmpInt * tmpInt;
      Trest := Trest + Square.Number[2 * i - 1];
      Square.Number[2 * i - 1] := Trest And 4294967295;
      rest := Trest Shr 32;
      For j := i + 1 To size1 Do
      Begin
         Trest := FGInt.Number[j];
         Trest := Trest * tmpInt;
         if (Trest shr 63) = 1 then overflow := 1 else overflow := 0;
         Trest := (Trest Shl 1) + Square.Number[i + j - 1] + rest;
         Square.Number[i + j - 1] := Trest And 4294967295;
         rest := (Trest Shr 32) or (overflow shl 32);
      End;
      k := 0;
      while rest <> 0 do
      begin
         Trest := square.Number[i + size1 + k];
         Trest := Trest + rest;
         square.Number[i + size1 + k] := Trest And 4294967295;
         rest := Trest shr 32;
         k := k + 1;
      end;
   End;
   Square.Sign := positive;
   While (Square.Number[size] = 0) And (size > 1) Do
      size := size - 1;
   If size <> (2 * size1) Then
   Begin
      SetLength(Square.Number, size + 1);
      Square.Number[0] := size;
   End;
End;


Procedure FGIntKaratsubaSquare(Const FGInt : TFGInt; Var Square : TFGInt);
// Procedure FGIntKaratsubaSquare(Const FGInt : TFGInt; Var Square : TFGInt; Const karatsubaThreshold : LongWord);
Var
   fa, fb, faa, fbb, fab, zero : TFGInt;
   halfLength, size, i : LongWord;
Begin
   size := FGInt.Number[0];
   if (size < karatsubaSquaringThreshold) Then 
   Begin
      FGIntPencilPaperSquare(FGInt, Square);
      Exit;
   End; 

   halfLength := (size Div 2) + (size mod 2);
   fa.Sign := positive;
   fb.Sign := positive;
   fb.Number := copy(FGInt.Number, 0, halfLength + 1);
   fb.Number[0] := halfLength;
   fa.Number := copy(FGInt.Number, halfLength, size - halfLength + 1);
   fa.Number[0] := size - halfLength;
   Base2StringToFGInt('0', zero);

   i := halfLength;
   while (fa.Number[i] = 0) and (i > 1) do i := i - 1;
   if i <> halfLength then
   begin
      setlength(fa.Number, i + 1);
      fa.Number[0] := i;
   end;



   if (FGIntCompareAbs(fa, zero) <> Eq) then
   begin
      FGIntKaratsubaSquare(fa, faa);
      // FGIntKaratsubaSquare(fa, faa, karatsubaThreshold);
   end 
   else
   begin
      FGIntCopy(zero, faa);
   end;

   if (FGIntCompareAbs(fb, zero) <> Eq) then
   begin
      FGIntKaratsubaSquare(fb, fbb);
      // FGIntKaratsubaSquare(fb, fbb, karatsubaThreshold);
   end 
   else
   begin
      FGIntCopy(zero, fbb);
   end;


   FGIntAddBis(fa, fb);
   if (FGIntCompareAbs(fa, zero) <> Eq) then
   begin
      FGIntKaratsubaSquare(fa, fab);
      // FGIntKaratsubaSquare(fa, fab, karatsubaThreshold);
   end 
   else
   begin
      FGIntCopy(zero, fab);
   end;


   FGIntSubBis(fab, faa);
   FGIntSubBis(fab, fbb);
   Square := faa;
   FGIntShiftLeftBy32Times(square, halfLength * 2);
   FGIntShiftLeftBy32Times(fab, halfLength);
   FGIntAddBis(square, fab);
   FGIntAddBis(square, fbb);

   FGIntDestroy(fa);   
   FGIntDestroy(fb);   
   FGIntDestroy(faa);   
   FGIntDestroy(fbb);   
   FGIntDestroy(zero);
   FGIntDestroy(fab);
End;



Procedure FGIntSquare(Const FGInt : TFGInt; Var Square : TFGInt);
Var
   size : LongWord;
Begin
   size := FGInt.Number[0];
   if (size > karatsubaSquaringThreshold) then
      FGIntKaratsubaSquare(FGInt, square)
   else
      FGIntPencilPaperSquare(FGInt, square);
End;

















// multiply a FGInt by an integer, FGInt * by = res, by < 2147483648

Procedure FGIntMulByInt(Const FGInt : TFGInt; Var res : TFGInt; by : LongWord);
Var
   i, size, rest : LongWord;
   Trest : uint64;
Begin
   size := FGInt.Number[0];
   setlength(res.Number, (size + 2));
   rest := 0;
   For i := 1 To size Do
   Begin
      Trest := FGInt.Number[i];
      TRest := Trest * by;
      TRest := Trest + rest;
      res.Number[i] := Trest And 4294967295;
      rest := Trest Shr 32;
   End;
   If rest <> 0 Then
   Begin
      size := size + 1;
      Res.Number[size] := rest;
   End
   Else
      SetLength(Res.Number, size + 1);
   Res.Number[0] := size;
   Res.Sign := FGInt.Sign;
End;


// multiply a FGInt by an integer, FGInt * by = res, by < 1000000000

Procedure FGIntMulByIntbis(Var FGInt : TFGInt; by : LongWord);
Var
   i, size, rest : LongWord;
   Trest : uint64;
Begin
   size := FGInt.Number[0];
   Setlength(FGInt.Number, size + 2);
   rest := 0;
   For i := 1 To size Do
   Begin
      Trest := FGInt.Number[i];
      TRest := Trest * by;
      TRest := Trest + rest;
      FGInt.Number[i] := Trest And 4294967295;
      rest := Trest Shr 32;
   End;
   If rest <> 0 Then
   Begin
      size := size + 1;
      FGInt.Number[size] := rest;
   End
   Else
      SetLength(FGInt.Number, size + 1);
   FGInt.Number[0] := size;
End;


// divide a FGInt by an integer, FGInt = res * by + modres

Procedure FGIntDivByInt(Const FGInt : TFGInt; Var res : TFGInt; by : LongWord; Var modres : LongWord);
Var
   i, size : LongWord;
   rest : uint64;
Begin
   size := FGInt.Number[0];
   setlength(res.Number, (size + 1));
   modres := 0;
   For i := size Downto 1 Do
   Begin
      rest := modres;
      rest := rest Shl 32;
      rest := rest Or FGInt.Number[i];
      res.Number[i] := rest Div by;
      modres := rest Mod by;
   End;
   While (res.Number[size] = 0) And (size > 1) Do
      size := size - 1;
   If size <> FGInt.Number[0] Then SetLength(res.Number, size + 1);
   res.Number[0] := size;
   Res.Sign := FGInt.Sign;
   If FGInt.sign = negative Then modres := by - modres;
End;
                                                         


// Reduce a FGInt modulo by (=an integer), FGInt mod by = modres

Procedure FGIntModByInt(Const FGInt : TFGInt; by : LongWord; Var modres : LongWord);
Var
   i, size : LongWord;
   temp, rest : uint64;
Begin
   size := FGInt.Number[0];
   temp := 0;
   For i := size Downto 1 Do
   Begin
      temp := temp Shl 32;
      rest := temp Or FGInt.Number[i];
      temp := rest Mod by;
   End;
   modres := temp;
   If FGInt.sign = negative Then modres := by - modres;
End;










// Exponentiate a FGInt, FGInt^exp = res

Procedure FGIntExp(Const FGInt, exp : TFGInt; Var res : TFGInt);
Var
   temp2, temp3 : TFGInt;
   S : String;
   i : LongWord;
Begin
   FGIntToBase2String(exp, S);
   If S[length(S)] = '0' Then Base10StringToFGInt('1', res) Else FGIntCopy(FGInt, res);
   FGIntCopy(FGInt, temp2);
   If length(S) > 1 Then
      For i := (length(S) - 1) Downto 1 Do
      Begin
         FGIntSquare(temp2, temp3);
         FGIntCopy(temp3, temp2);
         If S[i] = '1' Then
         Begin
            FGIntMul(res, temp2, temp3);
            FGIntCopy(temp3, res);
         End;
      End;
End;


// Compute FGInt! = FGInt * (FGInt - 1) * (FGInt - 2) * ... * 3 * 2 * 1

Procedure FGIntFac(Const FGInt : TFGInt; Var res : TFGInt);
Var
   one, temp, temp1 : TFGInt;
Begin
   FGIntCopy(FGInt, temp);
   Base10StringToFGInt('1', res);
   Base10StringToFGInt('1', one);

   While Not (FGIntCompareAbs(temp, one) = Eq) Do
   Begin
      FGIntMul(temp, res, temp1);
      FGIntCopy(temp1, res);
      FGIntSubBis(temp, one);
   End;

   FGIntDestroy(one);
   FGIntDestroy(temp);
End;



// Divide 2 FGInts, FGInt1 = FGInt2 * QFGInt + MFGInt, MFGInt is always positive

Procedure FGIntDivMod(Var FGInt1, FGInt2, QFGInt, MFGInt : TFGInt);
Var
   one, zero, temp1 : TFGInt;
   s1, s2 : TSign;
   j, s, t : LongWord;
   i, k : uint64;
Begin
   s1 := FGInt1.Sign;
   s2 := FGInt2.Sign;
   FGIntAbs(FGInt1);
   FGIntAbs(FGInt2);
   FGIntCopy(FGInt1, MFGInt);
   FGIntCopy(FGInt2, temp1);

   If FGIntCompareAbs(FGInt1, FGInt2) <> St Then
   Begin
      s := FGInt1.Number[0] - FGInt2.Number[0];
      SetLength(QFGInt.Number, (s + 2));
      QFGInt.Number[0] := s + 1;
      FGIntShiftLeftBy32Times(temp1, s);
      For t := 1 To s Do
      Begin
         QFGInt.Number[t] := 0;
      End;
      j := s + 1;
      QFGInt.Number[j] := 0;
      While FGIntCompareAbs(MFGInt, FGInt2) <> St Do
      Begin
         While FGIntCompareAbs(MFGInt, temp1) <> St Do
         Begin
            If MFGInt.Number[0] > temp1.Number[0] Then
            Begin
               i := MFGInt.Number[MFGInt.Number[0]];
               i := i Shl 32;
               i := i + MFGInt.Number[MFGInt.Number[0] - 1];
               i := i Div (temp1.Number[temp1.Number[0]] + 1);
            End
            Else
//               i := MFGInt.Number[MFGInt.Number[0]] Div (temp1.Number[temp1.Number[0]] + 1);
            Begin
                If (MFGInt.Number[0] > 1) And (FGInt2.Number[0] > 1) Then
                Begin
                   i := MFGInt.Number[MFGInt.Number[0]];
                   i := i Shl 32;
                   i := i + MFGInt.Number[MFGInt.Number[0] - 1];
                   k := temp1.Number[temp1.Number[0]];
                   k := k shl 32;
                   k := k + temp1.Number[temp1.Number[0] - 1] + 1;
                   i := i Div k;
                End
                Else
                   i := MFGInt.Number[MFGInt.Number[0]] Div (temp1.Number[temp1.Number[0]] + 1);
            End;
            If (i <> 0) Then
            Begin
               FGIntMulByIntSubBis(MFGInt, temp1, i);
               QFGInt.Number[j] := QFGInt.Number[j] + i;
            End
            Else
            Begin
               QFGInt.Number[j] := QFGInt.Number[j] + 1;
               FGIntSubBis(MFGInt, temp1);
            End;
         End;
         If MFGInt.Number[0] <= temp1.Number[0] Then
            If FGIntCompareAbs(temp1, FGInt2) <> Eq Then
            Begin
               FGIntShiftRightBy32(temp1);
               j := j - 1;
            End;
      End;
   End
   Else
      Base10StringToFGInt('0', QFGInt);
   s := QFGInt.Number[0];
   While (s > 1) And (QFGInt.Number[s] = 0) Do
      s := s - 1;
   If s < QFGInt.Number[0] Then
   Begin
      setlength(QFGInt.Number, s + 1);
      QFGInt.Number[0] := s;
   End;
   QFGInt.Sign := positive;

   FGIntDestroy(temp1);
   Base10StringToFGInt('0', zero);
   Base10StringToFGInt('1', one);
   If s1 = negative Then
   Begin
      If FGIntCompareAbs(MFGInt, zero) <> Eq Then
      Begin
         FGIntadd(QFGInt, one, temp1);
         FGIntDestroy(QFGInt);
         FGIntCopy(temp1, QFGInt);
         FGIntDestroy(temp1);
         FGIntsub(FGInt2, MFGInt, temp1);
         FGIntDestroy(MFGInt);
         FGIntCopy(temp1, MFGInt);
         FGIntDestroy(temp1);
      End;
      If s2 = positive Then QFGInt.Sign := negative;
   End
   Else
      QFGInt.Sign := s2;
   FGIntDestroy(one);
   FGIntDestroy(zero);

   FGInt1.Sign := s1;
   FGInt2.Sign := s2;
End;


// Same as above but doesn 't compute MFGInt

Procedure FGIntDiv(Var FGInt1, FGInt2, QFGInt : TFGInt);
Var
   one, zero, temp1, MFGInt : TFGInt;
   s1, s2 : TSign;
   j, s, t : LongWord;
   i, k : int64;
Begin
   s1 := FGInt1.Sign;
   s2 := FGInt2.Sign;
   FGIntAbs(FGInt1);
   FGIntAbs(FGInt2);
   FGIntCopy(FGInt1, MFGInt);
   FGIntCopy(FGInt2, temp1);

   If FGIntCompareAbs(FGInt1, FGInt2) <> St Then
   Begin
      s := FGInt1.Number[0] - FGInt2.Number[0];
      SetLength(QFGInt.Number, (s + 2));
      QFGInt.Number[0] := s + 1;
      FGIntShiftLeftBy32Times(temp1, s);
      For t := 1 To s Do
      Begin
         QFGInt.Number[t] := 0;
      End;
      j := s + 1;
      QFGInt.Number[j] := 0;
      While FGIntCompareAbs(MFGInt, FGInt2) <> St Do
      Begin
         While FGIntCompareAbs(MFGInt, temp1) <> St Do
         Begin
            If MFGInt.Number[0] > temp1.Number[0] Then
            Begin
               i := MFGInt.Number[MFGInt.Number[0]];
               i := i Shl 32;
               i := i + MFGInt.Number[MFGInt.Number[0] - 1];
               i := i Div (temp1.Number[temp1.Number[0]] + 1);
            End
            Else
//               i := MFGInt.Number[MFGInt.Number[0]] Div (temp1.Number[temp1.Number[0]] + 1);
            Begin
                If (MFGInt.Number[0] > 1) And (FGInt2.Number[0] > 1) Then
                Begin
                   i := MFGInt.Number[MFGInt.Number[0]];
                   i := i Shl 32;
                   i := i + MFGInt.Number[MFGInt.Number[0] - 1];
                   k := temp1.Number[temp1.Number[0]];
                   k := k shl 32;
                   k := k + temp1.Number[temp1.Number[0] - 1] + 1;
                   i := i Div k;
                End
                Else
                   i := MFGInt.Number[MFGInt.Number[0]] Div (temp1.Number[temp1.Number[0]] + 1);
            End;
            If (i <> 0) Then
            Begin
               FGIntMulByIntSubBis(MFGInt, temp1, i);
               QFGInt.Number[j] := QFGInt.Number[j] + i;
            End
            Else
            Begin
               QFGInt.Number[j] := QFGInt.Number[j] + 1;
               FGIntSubBis(MFGInt, temp1);
            End;
         End;
         If MFGInt.Number[0] <= temp1.Number[0] Then
            If FGIntCompareAbs(temp1, FGInt2) <> Eq Then
            Begin
               FGIntShiftRightBy32(temp1);
               j := j - 1;
            End;
      End;
   End
   Else
      Base10StringToFGInt('0', QFGInt);
   s := QFGInt.Number[0];
   While (s > 1) And (QFGInt.Number[s] = 0) Do
      s := s - 1;
   If s < QFGInt.Number[0] Then
   Begin
      setlength(QFGInt.Number, s + 1);
      QFGInt.Number[0] := s;
   End;
   QFGInt.Sign := positive;

   FGIntDestroy(temp1);
   Base10StringToFGInt('0', zero);
   Base10StringToFGInt('1', one);
   If s1 = negative Then
   Begin
      If FGIntCompareAbs(MFGInt, zero) <> Eq Then
      Begin
         FGIntadd(QFGInt, one, temp1);
         FGIntDestroy(QFGInt);
         FGIntCopy(temp1, QFGInt);
         FGIntDestroy(temp1);
         FGIntsub(FGInt2, MFGInt, temp1);
         FGIntDestroy(MFGInt);
         FGIntCopy(temp1, MFGInt);
         FGIntDestroy(temp1);
      End;
      If s2 = positive Then QFGInt.Sign := negative;
   End
   Else
      QFGInt.Sign := s2;
   FGIntDestroy(one);
   FGIntDestroy(zero);
   FGIntDestroy(MFGInt);

   FGInt1.Sign := s1;
   FGInt2.Sign := s2;
End;



// FGInt1 = FGInt1 - divInt * FGInt2, use only when 0 < FGInt2 < FGInt1

Procedure FGIntMulByIntSubBis(Var FGInt1 : TFGInt; Const FGInt2 : TFGInt; divInt : LongWord);
Var
   i, size1, size2, rest : LongWord;
   mTmpRest, Trest, mRest : uint64;
Begin
   size1 := FGInt1.Number[0];
   size2 := FGInt2.Number[0];
   rest := 0;
   mRest := 0;
   For i := 1 To size2 Do
   Begin
      mTmpRest := FGInt2.Number[i];
      mTmpRest := mTmpRest * divInt;
      mTmpRest := mTmpRest + mRest;
      Trest := (4294967296 Or FGInt1.Number[i]) - (mTmpRest And 4294967295) - rest;
      If (Trest > 4294967295) Then
         rest := 0
      Else
         rest := 1;
      mRest := mTmpRest shr 32;
      FGInt1.Number[i] := Trest And 4294967295;
   End;
   For i := size2 + 1 To size1 Do
   Begin
      Trest := (4294967296 Or FGInt1.Number[i]) - mRest - rest;
      If (Trest > 4294967295) Then
         rest := 0
      Else
         rest := 1;
      mRest := mRest shr 32;
      FGInt1.Number[i] := Trest And 4294967295;
   End;
   i := size1;
   While (FGInt1.Number[i] = 0) And (i > 1) Do
      i := i - 1;
   If i <> size1 Then
   Begin
      SetLength(FGInt1.Number, i + 1);
      FGInt1.Number[0] := i;
   End;
End;



Procedure FGIntMod(Var FGInt1, FGInt2, MFGInt : TFGInt);
Var
   zero, temp1 : TFGInt;
   s1, s2 : TSign;
   s : LongWord;
   i, j : uint64;
Begin
   s1 := FGInt1.Sign;
   s2 := FGInt2.Sign;
   FGIntAbs(FGInt1);
   FGIntAbs(FGInt2);
   FGIntCopy(FGInt1, MFGInt);
   FGIntCopy(FGInt2, temp1);

   If FGIntCompareAbs(FGInt1, FGInt2) <> St Then
   Begin
      s := FGInt1.Number[0] - FGInt2.Number[0];
//      For t := 1 To s Do
      FGIntShiftLeftBy32Times(temp1,s);
      While FGIntCompareAbs(MFGInt, FGInt2) <> St Do
      Begin
         While FGIntCompareAbs(MFGInt, temp1) <> St Do
         Begin
            If MFGInt.Number[0] > temp1.Number[0] Then
            Begin
               i := MFGInt.Number[MFGInt.Number[0]];
               i := i Shl 32;
               i := i + MFGInt.Number[MFGInt.Number[0] - 1];
               i := i Div (temp1.Number[temp1.Number[0]] + 1);
            End
            Else
//               i := MFGInt.Number[MFGInt.Number[0]] Div (temp1.Number[temp1.Number[0]] + 1);
            Begin
                If (MFGInt.Number[0] > 1) And (FGInt2.Number[0] > 1) Then
                Begin
                   i := MFGInt.Number[MFGInt.Number[0]];
                   i := i Shl 32;
                   i := i + MFGInt.Number[MFGInt.Number[0] - 1];
                   j := temp1.Number[temp1.Number[0]];
                   j := j shl 32;
                   j := j + temp1.Number[temp1.Number[0] - 1] + 1;
                   i := i Div j;
                End
                Else
                   i := MFGInt.Number[MFGInt.Number[0]] Div (temp1.Number[temp1.Number[0]] + 1);
            End;
            If (i <> 0) Then
            Begin
               FGIntMulByIntSubBis(MFGInt, temp1, i);
            End
            Else
               FGIntSubBis(MFGInt, temp1);
         End;
         If MFGInt.Number[0] <= temp1.Number[0] Then
            If FGIntCompareAbs(temp1, FGInt2) <> Eq Then FGIntShiftRightBy32(temp1);
      End;
   End;

   FGIntDestroy(temp1);
   Base10StringToFGInt('0', zero);
   If s1 = negative Then
   Begin
      If FGIntCompareAbs(MFGInt, zero) <> Eq Then
      Begin
         FGIntSub(FGInt2, MFGInt, temp1);
         FGIntDestroy(MFGInt);
         FGIntCopy(temp1, MFGInt);
         FGIntDestroy(temp1);
      End;
   End;
   FGIntDestroy(zero);

   FGInt1.Sign := s1;
   FGInt2.Sign := s2;
End;


// Square a FGInt modulo Modb, FGInt^2 mod Modb = FGIntSM

Procedure FGIntSquareMod(Var FGInt, Modb, FGIntSM : TFGInt);
Var
   temp : TFGInt;
Begin
   FGIntSquare(FGInt, temp);
   FGIntMod(temp, Modb, FGIntSM);
   FGIntDestroy(temp);
End;


// Add 2 FGInts modulo base, (FGInt1 + FGInt2) mod base = FGIntres

Procedure FGIntAddMod(Var FGInt1, FGInt2, base, FGIntres : TFGInt);
Var
   temp : TFGInt;
Begin
   FGIntadd(FGInt1, FGInt2, temp);
   FGIntMod(temp, base, FGIntres);
   FGIntDestroy(temp);
End;


// Multiply 2 FGInts modulo base, (FGInt1 * FGInt2) mod base = FGIntres

Procedure FGIntMulMod(Var FGInt1, FGInt2, base, FGIntres : TFGInt);
Var
   temp : TFGInt;
Begin
   FGIntMul(FGInt1, FGInt2, temp);
   FGIntMod(temp, base, FGIntres);
   FGIntDestroy(temp);
End;


// Procedures for Montgomery Exponentiation

Procedure FGIntModBis(Const FGInt : TFGInt; Var FGIntOut : TFGInt; b, head : LongWord);
Var
   i : LongWord;
Begin
   If b <= FGInt.Number[0] Then
   Begin
      SetLength(FGIntOut.Number, (b + 1));
      For i := 0 To b Do
         FGIntOut.Number[i] := FGInt.Number[i];
      FGIntOut.Number[b] := FGIntOut.Number[b] And head;
      i := b;
      While (FGIntOut.Number[i] = 0) And (i > 1) Do
         i := i - 1;
      If i < b Then SetLength(FGIntOut.Number, i + 1);
      FGIntOut.Number[0] := i;
      FGIntOut.Sign := positive;
   End
   Else
      FGIntCopy(FGInt, FGIntOut);
End;


Procedure FGIntMulModBis(Const FGInt1, FGInt2 : TFGInt; Var Prod : TFGInt; b, head : LongWord);
Var
   i, j, size, size1, size2, t, rest : LongWord;
   Trest : uint64;
Begin
   size1 := FGInt1.Number[0];
   size2 := FGInt2.Number[0];
   size := min(b, size1 + size2);
   SetLength(Prod.Number, (size + 1));
   For i := 1 To size Do
      Prod.Number[i] := 0;

   For i := 1 To size2 Do
   Begin
      rest := 0;
      t := min(size1, b - i + 1);
      For j := 1 To t Do
      Begin
         Trest := FGInt1.Number[j];
      Trest := Trest * FGInt2.Number[i];
      Trest := Trest + Prod.Number[j + i - 1];
      Trest := Trest + rest;
         Prod.Number[j + i - 1] := Trest And 4294967295;
         rest := Trest Shr 32;
      End;
      If (i + size1) <= b Then Prod.Number[i + size1] := rest;
   End;

   Prod.Number[0] := size;
   If size = b Then Prod.Number[b] := Prod.Number[b] And head;
   While (Prod.Number[size] = 0) And (size > 1) Do
      size := size - 1;
   If size < Prod.Number[0] Then
   Begin
      SetLength(Prod.Number, size + 1);
      Prod.Number[0] := size;
   End;
   If FGInt1.Sign = FGInt2.Sign Then
      Prod.Sign := Positive
   Else
      prod.Sign := negative;
End;


Procedure FGIntMontgomeryMod(Const GInt, base, baseInv : TFGInt; Var MGInt : TFGInt; b : Longword; head : LongWord);
Var
   m, temp, temp1 : TFGInt;
   r : LongWord;
Begin
   FGIntModBis(GInt, temp, b, head);
   FGIntMulModBis(temp, baseInv, m, b, head);
   FGIntMul(m, base, temp1);
   FGIntDestroy(temp);
   FGIntAdd(temp1, GInt, temp);
   FGIntDestroy(temp1);
   MGInt.Number := copy(temp.Number, b - 1, temp.Number[0] - b + 2);
   MGInt.Sign := positive;
   MGInt.Number[0] := temp.Number[0] - b + 1;
   FGIntDestroy(temp);
   If (head Shr 31) = 0 Then FGIntDivByIntBis(MGInt, head + 1, r)
   Else FGIntShiftRightBy32(MGInt);
   If FGIntCompareAbs(MGInt, base) <> St Then FGIntSubBis(MGInt, base);
   FGIntDestroy(temp);
   FGIntDestroy(m);
End;


Procedure FGIntMontgomeryModExp(Var FGInt, exp, modb, res : TFGInt);
Var
   temp2, temp3, baseInv, r, zero : TFGInt;
   i, j, t, b, head : LongWord;
   S: String;
Begin
   Base2StringToFGInt('0', zero);
   FGIntMod(FGInt, modb, res);
   If FGIntCompareAbs(res, zero)=Eq then
    Begin
      FGIntDestroy(zero);
      Exit;
    End else FGIntDestroy(res);
   FGIntDestroy(zero);

   FGIntToBase2String(exp, S);
   t := modb.Number[0];
   b := t;

   If (modb.Number[t] Shr 31) = 1 Then t := t + 1;
   SetLength(r.Number, (t + 1));
   r.Number[0] := t;
   r.Sign := positive;
   For i := 1 To t Do
      r.Number[i] := 0;
   If t = modb.Number[0] Then
   Begin
      head := 4294967295;
      For j := 30 Downto 0 Do
      Begin
         head := head Shr 1;
         If (modb.Number[t] Shr j) = 1 Then
         Begin
            r.Number[t] := 1 Shl (j + 1);
            break;
         End;
      End;
   End
   Else
   Begin
      r.Number[t] := 1;
      head := 4294967295;
   End;

   FGIntModInv(modb, r, temp2);
   If temp2.Sign = negative Then
      FGIntCopy(temp2, BaseInv)
   Else
   Begin
      FGIntCopy(r, BaseInv);
      FGIntSubBis(BaseInv, temp2);
   End;
//   FGIntBezoutBachet(r, modb, temp2, BaseInv);
   FGIntAbs(BaseInv);
   FGIntDestroy(temp2);
   FGIntMod(r, modb, res);
   FGIntMulMod(FGInt, res, modb, temp2);
   FGIntDestroy(r);

   For i := length(S) Downto 1 Do
   Begin
      If S[i] = '1' Then
      Begin
         FGIntmul(res, temp2, temp3);
         FGIntDestroy(res);
         FGIntMontgomeryMod(temp3, modb, baseinv, res, b, head);
         FGIntDestroy(temp3);
      End;
      FGIntSquare(temp2, temp3);
      FGIntDestroy(temp2);
      FGIntMontgomeryMod(temp3, modb, baseinv, temp2, b, head);
      FGIntDestroy(temp3);
   End;
   FGIntDestroy(temp2);
   FGIntMontgomeryMod(res, modb, baseinv, temp3, b, head);
   FGIntCopy(temp3, res);
   FGIntDestroy(temp3);
   FGIntDestroy(baseinv);
End;




// Exponentiate 2 FGInts modulo base, (FGInt1 ^ FGInt2) mod modb = res

Procedure FGIntModExp(Var FGInt, exp, modb, res : TFGInt);
Var
   temp2, temp3 : TFGInt;
   i : LongWord;
   S : String;
Begin
   If (Modb.Number[1] Mod 2) = 1 Then
   Begin
      FGIntMontgomeryModExp(FGInt, exp, modb, res);
      exit;
   End;
   FGIntToBase2String(exp, S);
   Base10StringToFGInt('1', res);
   FGIntcopy(FGInt, temp2);

   For i := length(S) Downto 1 Do
   Begin
      If S[i] = '1' Then
      Begin
         FGIntmulMod(res, temp2, modb, temp3);
         FGIntCopy(temp3, res);
      End;
      FGIntSquareMod(temp2, Modb, temp3);
      FGIntCopy(temp3, temp2);
   End;
   FGIntDestroy(temp2);
End;






// Compute the Greatest Common Divisor of 2 FGInts

Procedure FGIntGCD(Const FGInt1, FGInt2 : TFGInt; Var GCD : TFGInt);
Var
   k : TCompare;
   zero, temp1, temp2, temp3 : TFGInt;
Begin
   k := FGIntCompareAbs(FGInt1, FGInt2);
   If (k = Eq) Then FGIntCopy(FGInt1, GCD) Else
      If (k = St) Then FGIntGCD(FGInt2, FGInt1, GCD) Else
      Begin
         Base10StringToFGInt('0', zero);
         FGIntCopy(FGInt1, temp1);
         FGIntCopy(FGInt2, temp2);
         While (temp2.Number[0] <> 1) Or (temp2.Number[1] <> 0) Do
         Begin
            FGIntMod(temp1, temp2, temp3);
            FGIntCopy(temp2, temp1);
            FGIntCopy(temp3, temp2);
            FGIntDestroy(temp3);
         End;
         FGIntCopy(temp1, GCD);
         FGIntDestroy(temp2);
         FGIntDestroy(zero);
      End;
End;


// Compute the Least Common Multiple of 2 FGInts

Procedure FGIntLCM(Const FGInt1, FGInt2 : TFGInt; Var LCM : TFGInt);
Var
   temp1, temp2 : TFGInt;
Begin
   FGIntGCD(FGInt1, FGInt2, temp1);
   FGIntmul(FGInt1, FGInt2, temp2);
   FGIntdiv(temp2, temp1, LCM);
   FGIntDestroy(temp1);
   FGIntDestroy(temp2);
End;


// Trialdivision of a FGInt upto 9999 and stopping when a divisor is found, returning ok=false

Procedure FGIntTrialDiv9999(Const FGInt : TFGInt; Var ok : boolean);
Var
   j : LongWord;
   i : integer;
Begin
   If ((FGInt.Number[1] Mod 2) = 0) Then ok := false
   Else
   Begin
      i := 0;
      ok := true;
      While ok And (i < 1228) Do
      Begin
         i := i + 1;
         FGIntmodbyint(FGInt, primes[i], j);
         If j = 0 Then ok := false;
      End;
   End;
End;


// A prng

Procedure FGIntRandom1(Var Seed, RandomFGInt : TFGInt);
Var
   temp, base : TFGInt;
Begin
   Base10StringToFGInt('281474976710656', base);
   Base10StringToFGInt('44485709377909', temp);
   FGIntMulMod(seed, temp, base, RandomFGInt);
   FGIntDestroy(temp);
   FGIntDestroy(base);
End;


// Perform a Rabin Miller Primality Test nrtest times on FGIntp, returns ok=true when FGIntp passes the test

Procedure FGIntRabinMiller(Var FGIntp : TFGInt; nrtest : Longword; Var ok : boolean);
Var
   j, b, i : LongWord;
   m, z, temp1, temp2, temp3, zero, one, two, pmin1 : TFGInt;
   ok1, ok2 : boolean;
Begin
   randomize;
   Base10StringToFGInt('0', zero);
   Base10StringToFGInt('1', one);
   Base10StringToFGInt('2', two);
   FGIntsub(FGIntp, one, temp1);
   FGIntsub(FGIntp, one, pmin1);

   b := 0;
   While (temp1.Number[1] Mod 2) = 0 Do
   Begin
      b := b + 1;
      FGIntShiftRight(temp1);
   End;
   m := temp1;

   i := 0;
   ok := true;
   Randomize;
   While (i < nrtest) And ok Do
   Begin
      j := 0;
      i := i + 1;
      Base10StringToFGInt(inttostr(Primes[Random(1227) + 1]), temp2);
      FGIntMontGomeryModExp(temp2, m, FGIntp, z);
      FGIntDestroy(temp2);
      ok1 := (FGIntCompareAbs(z, one) = Eq);
      ok2 := (FGIntCompareAbs(z, pmin1) = Eq);
      If Not (ok1 Or ok2) Then
      Begin

         While (ok And (j < b)) Do
         Begin
            If (j > 0) And ok1 Then ok := false
            Else
            Begin
               j := j + 1;
               If (j < b) And (Not ok2) Then
               Begin
                  FGIntSquaremod(z, FGIntp, temp3);
                  FGIntCopy(temp3, z);
                  ok1 := (FGIntCompareAbs(z, one) = Eq);
                  ok2 := (FGIntCompareAbs(z, pmin1) = Eq);
                  If ok2 Then j := b;
               End
               Else If (Not ok2) And (j >= b) Then ok := false;
            End;
         End;

      End
   End;

   FGIntDestroy(zero);
   FGIntDestroy(one);
   FGIntDestroy(two);
   FGIntDestroy(m);
   FGIntDestroy(z);
   FGIntDestroy(pmin1);
End;


// Compute the coefficients from the Bezout Bachet theorem, FGInt1 * a + FGInt2 * b = GCD(FGInt1, FGInt2)

Procedure FGIntBezoutBachet(Var FGInt1, FGInt2, a, b : TFGInt);
Var
   zero, r1, r2, r3, ta, gcd, temp, temp1, temp2 : TFGInt;
Begin
   If FGIntCompareAbs(FGInt1, FGInt2) <> St Then
   Begin
      FGIntcopy(FGInt1, r1);
      FGIntcopy(FGInt2, r2);
      Base10StringToFGInt('0', zero);
      Base10StringToFGInt('1', a);
      Base10StringToFGInt('0', ta);

      Repeat
         FGIntdivmod(r1, r2, temp, r3);
         FGIntDestroy(r1);
         r1 := r2;
         r2 := r3;

         FGIntmul(ta, temp, temp1);
         FGIntsub(a, temp1, temp2);
         FGIntCopy(ta, a);
         FGIntCopy(temp2, ta);
         FGIntDestroy(temp1);

         FGIntDestroy(temp);
      Until FGIntCompareAbs(r3, zero) = Eq;

      FGIntGCD(FGInt1, FGInt2, gcd);
      FGIntmul(a, FGInt1, temp1);
      FGIntsub(gcd, temp1, temp2);
      FGIntDestroy(temp1);
      FGIntdiv(temp2, FGInt2, b);
      FGIntDestroy(temp2);

      FGIntDestroy(ta);
      FGIntDestroy(r1);
      FGIntDestroy(r2);
      FGIntDestroy(gcd);
   End
   Else FGIntBezoutBachet(FGInt2, FGInt1, b, a);
End;


// Find the (multiplicative) Modular inverse of a FGInt in a finite ring
// of additive order base

Procedure FGIntModInv(Const FGInt1, base : TFGInt; Var Inverse : TFGInt);
Var
   zero, one, r1, r2, r3, tb, gcd, temp, temp1, temp2 : TFGInt;
Begin
   Base10StringToFGInt('1', one);
   FGIntGCD(FGInt1, base, gcd);
   If FGIntCompareAbs(one, gcd) = Eq Then
   Begin
      FGIntcopy(base, r1);
      FGIntcopy(FGInt1, r2);
      Base10StringToFGInt('0', zero);
      Base10StringToFGInt('0', inverse);
      Base10StringToFGInt('1', tb);

      Repeat
         FGIntDestroy(r3);
         FGIntdivmod(r1, r2, temp, r3);
         FGIntCopy(r2, r1);
         FGIntCopy(r3, r2);

         FGIntmul(tb, temp, temp1);
         FGIntsub(inverse, temp1, temp2);
         FGIntDestroy(inverse);
         FGIntDestroy(temp1);
         FGIntCopy(tb, inverse);
         FGIntCopy(temp2, tb);

         FGIntDestroy(temp);
      Until FGIntCompareAbs(r3, zero) = Eq;

      If inverse.Sign = negative Then
      Begin
         FGIntadd(base, inverse, temp);
         FGIntCopy(temp, inverse);
      End;

      FGIntDestroy(tb);
      FGIntDestroy(r1);
      FGIntDestroy(r2);
   End;
   FGIntDestroy(gcd);
   FGIntDestroy(one);
End;


// Perform a (combined) primality test on FGIntp consisting of a trialdivision upto 8192,
// if the FGInt passes perform nrRMtests Rabin Miller primality tests, returns ok when a
// FGInt is probably prime

Procedure FGIntPrimetest(Var FGIntp : TFGInt; nrRMtests : integer; Var ok : boolean);
Begin
   FGIntTrialdiv9999(FGIntp, ok);
   If ok Then FGIntRabinMiller(FGIntp, nrRMtests, ok);
End;


// Computes the Legendre symbol for a any number and
// p a prime, returns 0 if p divides a, 1 if a is a
// quadratic residu mod p, -1 if a is a quadratic
// nonresidu mod p

Procedure FGIntLegendreSymbol(Var a, p : TFGInt; Var L : integer);
Var
   temp1, temp2, temp3, temp4, temp5, zero, one : TFGInt;
   i : LongWord;
   ok1, ok2 : boolean;
Begin
   Base10StringToFGInt('0', zero);
   Base10StringToFGInt('1', one);
   FGIntMod(a, p, temp1);
   If FGIntCompareAbs(zero, temp1) = Eq Then
   Begin
      FGIntDestroy(temp1);
      L := 0;
   End
   Else
   Begin
      FGIntDestroy(temp1);
      FGIntCopy(p, temp1);
      FGIntCopy(a, temp2);
      L := 1;
      While FGIntCompareAbs(temp2, one) <> Eq Do
      Begin
         If (temp2.Number[1] Mod 2) = 0 Then
         Begin
            FGIntSquare(temp1, temp3);
            FGIntSub(temp3, one, temp4);
            FGIntDestroy(temp3);
            FGIntDivByInt(temp4, temp3, 8, i);
            If (temp3.Number[1] Mod 2) = 0 Then ok1 := false Else ok1 := true;
            FGIntDestroy(temp3);
            FGIntDestroy(temp4);
            If ok1 = true Then L := L * (-1);
            FGIntDivByIntBis(temp2, 2, i);
         End
         Else
         Begin
            FGIntSub(temp1, one, temp3);
            FGIntSub(temp2, one, temp4);
            FGIntMul(temp3, temp4, temp5);
            FGIntDestroy(temp3);
            FGIntDestroy(temp4);
            FGIntDivByInt(temp5, temp3, 4, i);
            If (temp3.Number[1] Mod 2) = 0 Then ok2 := false Else ok2 := true;
            FGIntDestroy(temp5);
            FGIntDestroy(temp3);
            If ok2 = true Then L := L * (-1);
            FGIntMod(temp1, temp2, temp3);
            FGIntCopy(temp2, temp1);
            FGIntCopy(temp3, temp2);
         End;
      End;
      FGIntDestroy(temp1);
      FGIntDestroy(temp2);
   End;
   FGIntDestroy(zero);
   FGIntDestroy(one);
End;


// Compute a square root modulo a prime number
// SquareRoot^2 mod Prime = Square

Procedure FGIntSquareRootModP(Square, Prime : TFGInt; Var SquareRoot : TFGInt);
Var
   one, n, b, s, r, temp, temp1, temp2, temp3 : TFGInt;
   a, i, j : longint;
   L : Integer;
Begin
   Base2StringToFGInt('1', one);
   Base2StringToFGInt('10', n);
   a := 0;
   FGIntLegendreSymbol(n, Prime, L);
   While L <> -1 Do
   Begin
      FGIntAddBis(n, one);
      FGIntLegendreSymbol(n, Prime, L);
   End;
   FGIntCopy(Prime, s);
   s.Number[1] := s.Number[1] - 1;
   While (s.Number[1] Mod 2) = 0 Do
   Begin
      FGIntShiftRight(s);
      a := a + 1;
   End;
   FGIntMontgomeryModExp(n, s, Prime, b);
   FGIntAdd(s, one, temp);
   FGIntShiftRight(temp);
   FGIntMontgomeryModExp(Square, temp, Prime, r);
   FGIntDestroy(temp);
   FGIntModInv(Square, Prime, temp1);

   For i := 0 To (a - 2) Do
   Begin
      FGIntSquareMod(r, Prime, temp2);
      FGIntMulMod(temp1, temp2, Prime, temp);
      FGIntDestroy(temp2);
      For j := 1 To (a - i - 2) Do
      Begin
         FGIntSquareMod(temp, Prime, temp2);
         FGIntDestroy(temp);
         FGIntCopy(temp2, temp);
         FGIntDestroy(temp2);
      End;
      If FGIntCompareAbs(temp, one) <> Eq Then
      Begin
         FGIntMulMod(r, b, Prime, temp3);
         FGIntDestroy(r);
         FGIntCopy(temp3, r);
         FGIntDestroy(temp3);
      End;
      FGIntDestroy(temp);
      FGIntDestroy(temp2);
      If i = (a - 2) Then break;
      FGIntSquareMod(b, Prime, temp3);
      FGIntDestroy(b);
      FGIntCopy(temp3, b);
      FGIntDestroy(temp3);
   End;

   FGIntCopy(r, SquareRoot);
   FGIntDestroy(r);
   FGIntDestroy(s);
   FGIntDestroy(b);
   FGIntDestroy(temp1);
   FGIntDestroy(one);
   FGIntDestroy(n);
End;






// compute the initial bits for newton inversion with kZero fraction digits 

Procedure newtonInitialValue(Const FGInt : TFGInt; Const kZero: LongWord; Var resFGInt : TFGInt);
Var
    tmpFGInt, bFGInt : TFGInt;
    isTwo, i, j, l : LongWord;
    k, divisorLength, tmpFGIntHead1, tmpFGIntHead2, bFGIntLength, divInt : uint64;
Begin
   isTwo := 0;
   divisorLength := FGInt.Number[0];

   k := divisorLength;
   for i := 1 to divisorLength do
   begin
      if FGInt.Number[i] <> 0 then 
         for l := 0 to 31 do
            if (FGInt.Number[i] and (1 shl l)) <> 0 then isTwo := isTwo + 1;
   end;

   if (isTwo <> 1)  then
   Begin
      j := kZero div 32;
      if kZero mod 32 <> 0 then j := j + 1;
      k := divisorLength + j;

      bFGInt.sign := positive;
      setlength(bFGInt.Number, k + 2);
      For i := 1 to k do
         bFGInt.Number[i] := 0;
      bFGInt.Number[k+1] := 1;
      bFGInt.Number[0] := k + 1;

      if bFGInt.Number[0] + 1 > divisorLength then j := bFGInt.Number[0] - divisorLength + 1 else j := 0;
      FGIntCopy(fGInt, tmpFGInt);
      if (j > 0) then
         FGIntShiftLeftBy32Times(tmpFGInt, j - 1);

      resFGInt.sign := positive;
      setlength(resFGInt.Number, j + 1);
      For i := 1 to j do
         resFGInt.Number[i] := 0;
      resFGInt.Number[0] := j;

      tmpFGIntHead1 := tmpFGInt.Number[tmpFGInt.Number[0]];
      tmpFGIntHead1 := tmpFGIntHead1 + 1;
      if tmpFGInt.Number[0] > 1 then
      begin
         tmpFGIntHead2 := tmpFGInt.Number[tmpFGInt.Number[0]];
         tmpFGIntHead2 := (tmpFGIntHead2 shl 32) + tmpFGInt.Number[tmpFGInt.Number[0] - 1] + 1;
      end else
      begin
         tmpFGIntHead2 := 0;
      end;
      bFGIntLength := bFGInt.Number[0];

      while FGIntCompareAbs(bFGInt, fGInt) <> St do 
      begin
         while FGIntCompareAbs(bFGInt, tmpFGInt) <> St do 
         begin
            if bFGIntLength > tmpFGInt.Number[0] then
            begin
               divInt := bFGInt.Number[bFGInt.Number[0]];
               divInt := ((divInt shl 32) + bFGInt.Number[bFGInt.Number[0] - 1]) div tmpFGIntHead1;
            end else
            begin
               if (bFGIntLength > 1) and (tmpFGIntHead2 <> 0) then
               begin
                  divInt := bFGInt.Number[bFGInt.Number[0]];
                  divInt := ((divInt shl 32) + bFGInt.Number[bFGInt.Number[0] - 1] ) div tmpFGIntHead2;
               end else
               begin
                  divInt := bFGInt.Number[bFGInt.Number[0]];
                  divInt := divInt div tmpFGIntHead1;
               end
            end;
            if divInt <> 0 then
            begin
               FGIntMulByIntSubBis(bFGInt, tmpFGInt, divInt);
               resFGInt.Number[j] := resFGInt.Number[j] + divInt;
            end else
            begin
               FGIntSubBis(bFGInt, tmpFGInt);
               resFGInt.Number[j] := resFGInt.Number[j] + 1;
            end;
            bFGIntLength := bFGInt.Number[0];
         end;
         if (bFGIntLength <= tmpFGInt.Number[0]) and (tmpFGInt.Number[0] > divisorLength) then
         begin
            FGIntShiftRightBy32(tmpFGInt);
            j := j - 1;
         end;
      end;



      while (resFGInt.Number[0] > 1) and (resFGInt.Number[resFGInt.Number[0]] = 0) do
      begin
         setLength(resFGInt.Number, resFGInt.Number[0]);
         resFGInt.Number[0] := resFGInt.Number[0] - 1;
      end;
      j := kZero + 1; 
      i := 32 * (resFGInt.Number[0] - 1);
      while (resFGInt.Number[resFGInt.Number[0]] shr i) <> 0 do  
         i := i + 1;

// writeln(' - divInt - ' + inttostr(divInt));

      if (i > j) then
         FGIntShiftRightBy(resFGInt, i - j)
      else 
         FGIntShiftLeftBy(resFGInt, j - i);

         FGIntDestroy(bFGInt);
         FGIntDestroy(tmpFGInt);

   end else
   Begin
      Base2StringToFGInt('10', resFGInt);
      FGIntShiftLeftBy(resFGInt, kZero);
   End;
End;


//  newtonInversion returns the 1/fGInt with precision fraction digits 

Procedure newtonInversion(Const fGInt : TFGInt; Const precision : LongWord; Var resFGInt : TFGInt);
Var 
   z, zSquare, vFGInt, t_FGInt, uFGInt : TFGInt;
   h, j, k, baseCaseLength, vLength, uRadix,
           zRadix, zSquareRadix, tRadix, vIndex : uint64;
   kValues : Array of LongWord;    
   i : LongWord;  
Begin
   baseCaseLength := 128;
   k := precision;

   FGIntCopy(fGInt, vFGInt);
   vLength := vFGInt.Number[0];
   i := 0;
   while (vFGInt.Number[vLength] < (2147483648 shr i)) do i := i + 1;
   FGIntShiftLeftBy(vFGInt, i);
   
   j := k;
   i := 0;
   setlength(kValues, 0);
   while (k > baseCaseLength) do
   begin
      k := (j div 2) + (j mod 2);
      j := k;
      setlength(kValues, length(kValues) + 1);
      kValues[i] := k;
      i := i + 1;
   end;
   newtonInitialValue(vFGInt, k, z);
   zRadix := k;
   vIndex := vLength;
   tRadix := 0;
   setLength(t_FGInt.Number, 0);

   for i := length(kValues) - 1 Downto 0 do 
   begin
      k := kValues[i];
      FGIntSquare(z, zSquare);
      zSquareRadix := 2 * zRadix;

//////////////////// ToDo: optimize!!!!!!!!!!!!!!!!!!!!!!!!!
      // h := (2*k + 3 - tRadix) div 32;
      // if (2*k + 3 - tRadix) mod 32 <> 0 then h := h + 1;

      while tRadix < (2 * k + 3) do 
      begin
         if (vIndex > 0) then
         begin
            if length(t_FGInt.Number) = 0 then Base2StringToFGInt('0', t_FGInt) else FGIntShiftLeftBy32(t_FGInt);
            t_FGInt.Number[1] := vFGInt.Number[vIndex];
         end else
         begin
            FGIntShiftLeftBy32(t_FGInt);
         end;
         vIndex := vIndex - 1;
         tRadix := tRadix + 32;
      end;
      t_FGInt.Number[0] := tRadix div 32;
      h := tRadix - 2*k - 3;
      FGIntMul(t_FGInt, zSquare, uFGInt);
      FGIntDestroy(zSquare);
      uRadix := tRadix + zSquareRadix;
      if (uRadix > 2*k + 1 + h) then
      begin
         FGIntShiftRightBy(uFGInt, uRadix - (2*k + 1 + h));
         uRadix := 2*k + 1 + h;
      end;
      FGIntShiftLeft(z);


      if (uRadix > zRadix) then
      begin
         FGIntShiftLeftBy(z, uRadix - zRadix);
         zRadix := uRadix;
      end;
      FGIntSubBis(z, uFGInt);
      FGIntDestroy(uFGInt);
   end;

    if (zRadix > precision) then FGIntShiftRightBy(z, zRadix - precision);
    FGIntAbs(z);

    kValues := nil;
    FGIntDestroy(t_FGInt);
    FGIntDestroy(vFGInt);
    resFGInt := z;
End;



Procedure FGIntBarretDivMod(Var FGInt1, FGInt2, QFGInt, MFGInt : TFGInt);
Var
   fGInt1Copy, divisorCopy, tmpFGInt, one, invertedDivisor : TFGInt;
   i, m, n : Longword;
   mnCorrect : boolean;
   fGIntSign, divisorSign : TSign;
begin
   m := (fGInt1.Number[0] - 1) * 32;
   n := (fGInt2.Number[0] - 1) * 32;
   mnCorrect := false;
   fGIntSign := fGInt1.sign;
   divisorSign := fGInt2.sign;

   if FGIntCompareAbs(fGInt1, fGInt2) <> St then
   begin
      FGIntAbs(fGInt1);
      FGIntAbs(fGInt2);
      for i := 0 to 31 do
         if (fGInt1.Number[fGInt1.Number[0]] shr i) = 0 then break else m := m + 1;
      for i := 0 to 31 do
         if (fGInt2.Number[fGInt2.Number[0]] shr i) = 0 then break else n := n + 1;

      if (m > 2 * n) then
      begin
         mnCorrect := True;
         FGIntCopy(fGInt1, fGInt1Copy);
         FGIntCopy(fGInt2, divisorCopy);
      end;

      while (m > 2*n) do
      begin
         if (m >= 2*n + 32) then 
         begin
            FGIntShiftLeftBy32(fGInt1);
            FGIntShiftLeftBy32(fGInt2);
            m := m + 32;
            n := n + 32;
         end else
         begin
            FGIntShiftLeft(fGInt1);
            FGIntShiftLeft(fGInt2);
            m := m + 1;
            n := n + 1;
         end;
      end;
      newtonInversion(fGInt2, m - n, invertedDivisor);
      FGIntCopy(fGInt1, tmpFGInt);
      
      i := n - 1;
      if i > 0 then FGIntShiftRightBy(tmpFGInt, i);

      FGIntMul(tmpFGInt, invertedDivisor, QFGInt);
      FGIntDestroy(tmpFGInt);

      i := m - n + 1;
      if (i > 0) then FGIntShiftRightBy(QFGInt, i);

      if (mnCorrect) then
      begin
         fGInt1 := fGInt1Copy;
         fGInt2 := divisorCopy;
      end;

      FGIntMul(fGInt2, QFGInt, tmpFGInt);
      FGIntSub(fGInt1, tmpFGInt, MFGInt);
      FGIntDestroy(tmpFGInt);

      Base2StringToFGInt('1', one);

      while not ((MFGInt.sign = positive) and (FGIntCompareAbs(MFGInt, fGInt2) = St)) do
      begin
         if (MFGInt.sign = negative) then
         begin
            FGIntAdd(MFGInt, fGInt2, tmpFGInt);
            FGIntDestroy(MFGInt);
            MFGInt := tmpFGInt;
            FGIntSubBis(QFGInt, one);
         end else 
         begin
            FGIntSubBis(MFGInt, fGInt2);
            FGIntAddBis(QFGInt, one);
         end;
      end;

      if (fGInt1.Sign = negative) then
      begin
         FGIntSub(fGInt2, MFGInt, tmpFGInt);
         FGIntDestroy(MFGInt);
         MFGInt := tmpFGInt;
         FGIntAddBis(QFGInt, one);
      end;
      if fGIntSign = divisorSign then QFGInt.sign := positive else QFGInt.sign := negative;

      FGIntDestroy(invertedDivisor);
      FGIntDestroy(one);
   end else
   begin
      if (fGInt1.sign = positive) then
      begin
         Base2StringToFGInt('0', QFGInt);
         FGIntCopy(fGInt1, MFGInt);
      end else 
      begin
         if (fGInt2.sign = positive) then
         begin
            Base2StringToFGInt('1', QFGInt);
            QFGInt.sign := negative;
         end else
            Base2StringToFGInt('1', QFGInt);

         FGIntCopy(fGInt2, MFGInt);
         FGIntAbs(MFGInt);
         FGIntSubBis(MFGInt, fGInt1);
      end;
   end;
end;




Procedure FGIntBarretMod(Var FGInt1, FGInt2, MFGInt : TFGInt);
Var
   fGInt1Copy, divisorCopy, tmpFGInt, one, invertedDivisor, QFGInt : TFGInt;
   i, m, n : Longword;
   mnCorrect : boolean;
begin
   m := (fGInt1.Number[0] - 1) * 32;
   n := (fGInt2.Number[0] - 1) * 32;
   mnCorrect := false;

   if FGIntCompareAbs(fGInt1, fGInt2) <> St then
   begin
      FGIntAbs(fGInt1);
      FGIntAbs(fGInt2);
      for i := 0 to 31 do
         if (fGInt1.Number[fGInt1.Number[0]] shr i) = 0 then break else m := m + 1;
      for i := 0 to 31 do
         if (fGInt2.Number[fGInt2.Number[0]] shr i) = 0 then break else n := n + 1;

      if (m > 2 * n) then
      begin
         mnCorrect := True;
         FGIntCopy(fGInt1, fGInt1Copy);
         FGIntCopy(fGInt2, divisorCopy);
      end;

      while (m > 2*n) do
      begin
         if (m >= 2*n + 32) then 
         begin
            FGIntShiftLeftBy32(fGInt1);
            FGIntShiftLeftBy32(fGInt2);
            m := m + 32;
            n := n + 32;
         end else
         begin
            FGIntShiftLeft(fGInt1);
            FGIntShiftLeft(fGInt2);
            m := m + 1;
            n := n + 1;
         end;
      end;
      newtonInversion(fGInt2, m - n, invertedDivisor);
      FGIntCopy(fGInt1, tmpFGInt);
      
      i := n - 1;
      if i > 0 then FGIntShiftRightBy(tmpFGInt, i);

      FGIntMul(tmpFGInt, invertedDivisor, QFGInt);
      FGIntDestroy(tmpFGInt);

      i := m - n + 1;
      if (i > 0) then FGIntShiftRightBy(QFGInt, i);

      if (mnCorrect) then
      begin
         fGInt1 := fGInt1Copy;
         fGInt2 := divisorCopy;
      end;

      FGIntMul(fGInt2, QFGInt, tmpFGInt);
      FGIntSub(fGInt1, tmpFGInt, MFGInt);
      FGIntDestroy(tmpFGInt);

      Base2StringToFGInt('1', one);

      while not ((MFGInt.sign = positive) and (FGIntCompareAbs(MFGInt, fGInt2) = St)) do
      begin
         if (MFGInt.sign = negative) then
         begin
            FGIntAdd(MFGInt, fGInt2, tmpFGInt);
            FGIntDestroy(MFGInt);
            MFGInt := tmpFGInt;
         end else 
         begin
            FGIntSubBis(MFGInt, fGInt2);
         end;
      end;

      if (fGInt1.Sign = negative) then
      begin
         FGIntSub(fGInt2, MFGInt, tmpFGInt);
         FGIntDestroy(MFGInt);
         MFGInt := tmpFGInt;
      end;

      FGIntDestroy(QFGInt);
      FGIntDestroy(invertedDivisor);
      FGIntDestroy(one);
   end else
   begin
      if (fGInt1.sign = positive) then
      begin
         FGIntCopy(fGInt1, MFGInt);
      end else 
      begin
         FGIntCopy(fGInt2, MFGInt);
         FGIntAbs(MFGInt);
         FGIntSubBis(MFGInt, fGInt1);
      end;
   end;
end;







  // barrettMod expects fGInt to contain not more than double the amount of significant bits of divisorFGInt,
  //   invertedDivisor has double the amount of significant bits of divisorFGInt as fraction bits.
  //   barrettMod expects all arguments to be positive.


Procedure FGIntBarrettModWithInvertedDivisorAndPrecision(Const GInt, divisorFGInt, invertedDivisor : TFGInt; precision : LongWord; Var modFGInt : TFGInt);
Var
   QFGInt, tmpFGInt : TFGInt;
   i, j : LongWord;
   // str : string;
begin
   if FGIntCompareAbs(GInt, divisorFGInt) <> St then
   begin
      i := precision - 1;
      j := (i div 32);
      tmpFGInt.sign := GInt.sign;
      if (j > 0) and (j < GInt.Number[0]) then tmpFGInt.Number := copy(GInt.Number, j, GInt.Number[0] - j + 1);
      tmpFGInt.Number[0] := GInt.Number[0] - j;
      j := i mod 32;
      if (j > 0) then FGIntShiftRightBy(tmpFGInt, j);
      FGIntMul(tmpFGInt, invertedDivisor, QFGInt);
      FGIntDestroy(tmpFGInt);
      i := precision + 1;
      if (i > 0) then FGIntShiftRightBy(QFGInt, i);

      FGIntMul(divisorFGInt, QFGInt, tmpFGInt);
      FGIntDestroy(QFGInt);
      FGIntSub(GInt, tmpFGInt, modFGInt);
      FGIntDestroy(tmpFGInt);

      while not ((modFGInt.sign = positive) and (FGIntCompareAbs(modFGInt, divisorFGInt) = St)) do
      begin
         if (modFGInt.sign = negative) then
         begin
            FGIntAdd(modFGInt, divisorFGInt, tmpFGInt);
            FGIntDestroy(modFGInt);
            modFGInt := tmpFGInt;
         end else 
         begin
            FGIntSubBis(modFGInt, divisorFGInt);
         end;
      end;
   end else
      FGIntCopy(GInt, modFGInt);
end;





// raise fGInt to the power fGIntN mod modFGInt, and return (fGInt ^ fGIntN) % modFGInt 

Procedure FGIntBarretModExp(Var FGInt, exp, modFGInt, res : TFGInt);
Var
   tmpFGInt1, invertedDivisor, tmpFGInt : TFGInt;
   i, j, precision, tmp : Longword;
   // str : string;
Begin
   precision := (modFGInt.Number[0] - 1) * 32;
   for i := 0 to 31 do
      if (modFGInt.Number[modFGInt.Number[0]] shr i) = 0 then break else precision := precision + 1;

   newtonInversion(modFGInt, precision, invertedDivisor);
   FGIntCopy(FGInt, tmpFGInt1);

   Base2StringToFGInt('1', res);

   For i := 1 to exp.Number[0] - 1 do 
   begin
      tmp := exp.Number[i];
      for j := 0 to 31 do
      begin
         if ((tmp shr j) and 1) = 1 then
         begin
            FGIntMul(res, tmpFGInt1, tmpFGInt);
            FGIntDestroy(res);
            FGIntBarrettModWithInvertedDivisorAndPrecision(tmpFGInt, modFGInt, invertedDivisor, precision, res);
            FGIntDestroy(tmpFGInt);
         end;
         FGIntSquare(tmpFGInt1, tmpFGInt);
         FGIntDestroy(tmpFGInt1);
         FGIntBarrettModWithInvertedDivisorAndPrecision(tmpFGInt, modFGInt, invertedDivisor, precision, tmpFGInt1);
         FGIntDestroy(tmpFGInt);
      end;
   end;
   tmp := exp.Number[exp.Number[0]];
   for j := 0 to 31 do
   begin
      if ((tmp shr j) and 1) = 1 then
      begin
         FGIntMul(res, tmpFGInt1, tmpFGInt);
         FGIntDestroy(res);
         FGIntBarrettModWithInvertedDivisorAndPrecision(tmpFGInt, modFGInt, invertedDivisor, precision, res);
         FGIntDestroy(tmpFGInt)
      end;
      FGIntSquare(tmpFGInt1, tmpFGInt);
      FGIntDestroy(tmpFGInt1);
      FGIntBarrettModWithInvertedDivisorAndPrecision(tmpFGInt, modFGInt, invertedDivisor, precision, tmpFGInt1);
      FGIntDestroy(tmpFGInt);
   end;

   FGIntDestroy(invertedDivisor);
   FGIntDestroy(tmpFGInt1);

End;


End.
