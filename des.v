module des(	input 			encOrDec,		// set for DES encoding, clear for DES decoding
			input [31:0]	upperKey,		// upper 32-bits of key
			input [31:0]	lowerKey,		// lower 32-bits of key
			input [31:0]	upperData,		// upper 32-bits of data
			input [31:0]	lowerData,		// lower 32-bits of data
			output [1:64]	DESout,			// 64-bit output of DES
			output [0:6]	HEX0,
			output [0:6]	HEX1,
			output [0:6]	HEX2,
			output [0:6]	HEX3,
			output [0:6]	HEX4,
			output [0:6]	HEX5,
			output [0:6]	HEX6,
			output [0:6]	HEX7
			);
	
	// key: 0001001100110100010101110111100110011011101111001101111111110001
	// data: 0000000100100011010001010110011110001001101010111100110111101111
	
	wire [1:64] key;
	wire [1:64] data;
	wire [1:48]	subKey1, subKey2, subKey3, subKey4,
				subKey5, subKey6, subKey7, subKey8,
				subKey9, subKey10, subKey11, subKey12,
				subKey13, subKey14, subKey15, subKey16;
				
	wire [1:64] initPerm;
	wire [1:32] initPermLeft, initPermRight;
	wire [1:32] eLeft1, eLeft2, eLeft3, eLeft4,
				eLeft5, eLeft6, eLeft7, eLeft8,
				eLeft9, eLeft10, eLeft11, eLeft12,
				eLeft13, eLeft14, eLeft15, eLeft16;
	wire [1:32] eRight1, eRight2, eRight3, eRight4,
				eRight5, eRight6, eRight7, eRight8,
				eRight9, eRight10, eRight11, eRight12,
				eRight13, eRight14, eRight15, eRight16;
	wire [1:32] dLeft1, dLeft2, dLeft3, dLeft4,
				dLeft5, dLeft6, dLeft7, dLeft8,
				dLeft9, dLeft10, dLeft11, dLeft12,
				dLeft13, dLeft14, dLeft15, dLeft16;
	wire [1:32] dRight1, dRight2, dRight3, dRight4,
				dRight5, dRight6, dRight7, dRight8,
				dRight9, dRight10, dRight11, dRight12,
				dRight13, dRight14, dRight15, dRight16;
	
	wire [1:64] finalPermE;
	wire [1:64] finalPermD;
	
	wire [1:64] encData;
	wire [1:64] decData;
	
	assign key = {upperKey, lowerKey};
	assign data = {upperData, lowerData};
	
	// Generate 16 48-bit sub-keys from original 64-bit key
	keygen keygen(	key, 
					subKey1, subKey2, subKey3, subKey4,
					subKey5, subKey6, subKey7, subKey8,
					subKey9, subKey10, subKey11, subKey12,
					subKey13, subKey14, subKey15, subKey16);
	
	// Initial permutation
	assign initPerm[1] = data[58];
	assign initPerm[2] = data[50];
	assign initPerm[3] = data[42];
	assign initPerm[4] = data[34];
	assign initPerm[5] = data[26];
	assign initPerm[6] = data[18];
	assign initPerm[7] = data[10];
	assign initPerm[8] = data[2];
	assign initPerm[9] = data[60];
	assign initPerm[10] = data[52];
	assign initPerm[11] = data[44];
	assign initPerm[12] = data[36];
	assign initPerm[13] = data[28];
	assign initPerm[14] = data[20];
	assign initPerm[15] = data[12];
	assign initPerm[16] = data[4];
	assign initPerm[17] = data[62];
	assign initPerm[18] = data[54];
	assign initPerm[19] = data[46];
	assign initPerm[20] = data[38];
	assign initPerm[21] = data[30];
	assign initPerm[22] = data[22];
	assign initPerm[23] = data[14];
	assign initPerm[24] = data[6];
	assign initPerm[25] = data[64];
	assign initPerm[26] = data[56];
	assign initPerm[27] = data[48];
	assign initPerm[28] = data[40];
	assign initPerm[29] = data[32];
	assign initPerm[30] = data[24];
	assign initPerm[31] = data[16];
	assign initPerm[32] = data[8];
	assign initPerm[33] = data[57];
	assign initPerm[34] = data[49];
	assign initPerm[35] = data[41];
	assign initPerm[36] = data[33];
	assign initPerm[37] = data[25];
	assign initPerm[38] = data[17];
	assign initPerm[39] = data[9];
	assign initPerm[40] = data[1];
	assign initPerm[41] = data[59];
	assign initPerm[42] = data[51];
	assign initPerm[43] = data[43];
	assign initPerm[44] = data[35];
	assign initPerm[45] = data[27];
	assign initPerm[46] = data[19];
	assign initPerm[47] = data[11];
	assign initPerm[48] = data[3];
	assign initPerm[49] = data[61];
	assign initPerm[50] = data[53];
	assign initPerm[51] = data[45];
	assign initPerm[52] = data[37];
	assign initPerm[53] = data[29];
	assign initPerm[54] = data[21];
	assign initPerm[55] = data[13];
	assign initPerm[56] = data[5];
	assign initPerm[57] = data[63];
	assign initPerm[58] = data[55];
	assign initPerm[59] = data[47];
	assign initPerm[60] = data[39];
	assign initPerm[61] = data[31];
	assign initPerm[62] = data[23];
	assign initPerm[63] = data[15];
	assign initPerm[64] = data[7];
	
	// Split initial permutation into two halves
	assign initPermLeft = initPerm[1:32];
	assign initPermRight = initPerm[33:64];
	
	// 16 rounds of encoding data
	round er1(initPermLeft, initPermRight, subKey1, eLeft1, eRight1);
	round er2(eLeft1, eRight1, subKey2, eLeft2, eRight2);
	round er3(eLeft2, eRight2, subKey3, eLeft3, eRight3);
	round er4(eLeft3, eRight3, subKey4, eLeft4, eRight4);
	round er5(eLeft4, eRight4, subKey5, eLeft5, eRight5);
	round er6(eLeft5, eRight5, subKey6, eLeft6, eRight6);
	round er7(eLeft6, eRight6, subKey7, eLeft7, eRight7);
	round er8(eLeft7, eRight7, subKey8, eLeft8, eRight8);
	round er9(eLeft8, eRight8, subKey9, eLeft9, eRight9);
	round er10(eLeft9, eRight9, subKey10, eLeft10, eRight10);
	round er11(eLeft10, eRight10, subKey11, eLeft11, eRight11);
	round eer12(eLeft11, eRight11, subKey12, eLeft12, eRight12);
	round er13(eLeft12, eRight12, subKey13, eLeft13, eRight13);
	round er14(eLeft13, eRight13, subKey14, eLeft14, eRight14);
	round er15(eLeft14, eRight14, subKey15, eLeft15, eRight15);
	round er16(eLeft15, eRight15, subKey16, eLeft16, eRight16);
	
	// 16 rounds of decoding data
	round dr1(initPermLeft, initPermRight, subKey16, dLeft1, dRight1);
	round dr2(dLeft1, dRight1, subKey15, dLeft2, dRight2);
	round dr3(dLeft2, dRight2, subKey14, dLeft3, dRight3);
	round dr4(dLeft3, dRight3, subKey13, dLeft4, dRight4);
	round dr5(dLeft4, dRight4, subKey12, dLeft5, dRight5);
	round dr6(dLeft5, dRight5, subKey11, dLeft6, dRight6);
	round dr7(dLeft6, dRight6, subKey10, dLeft7, dRight7);
	round dr8(dLeft7, dRight7, subKey9, dLeft8, dRight8);
	round dr9(dLeft8, dRight8, subKey8, dLeft9, dRight9);
	round dr10(dLeft9, dRight9, subKey7, dLeft10, dRight10);
	round dr11(dLeft10, dRight10, subKey6, dLeft11, dRight11);
	round dr12(dLeft11, dRight11, subKey5, dLeft12, dRight12);
	round dr13(dLeft12, dRight12, subKey4, dLeft13, dRight13);
	round dr14(dLeft13, dRight13, subKey3, dLeft14, dRight14);
	round dr15(dLeft14, dRight14, subKey2, dLeft15, dRight15);
	round dr16(dLeft15, dRight15, subKey1, dLeft16, dRight16);
	
	// Split final permutations into two halves
	assign finalPermE = {eRight16, eLeft16};
	assign finalPermD = {dRight16, dLeft16};
	
	// Perform final permutation to complete encoding
	assign encData[1] = finalPermE[40];
	assign encData[2] = finalPermE[8];
	assign encData[3] = finalPermE[48];
	assign encData[4] = finalPermE[16];
	assign encData[5] = finalPermE[56];
	assign encData[6] = finalPermE[24];
	assign encData[7] = finalPermE[64];
	assign encData[8] = finalPermE[32];
	assign encData[9] = finalPermE[39];
	assign encData[10] = finalPermE[7];
	assign encData[11] = finalPermE[47];
	assign encData[12] = finalPermE[15];
	assign encData[13] = finalPermE[55];
	assign encData[14] = finalPermE[23];
	assign encData[15] = finalPermE[63];
	assign encData[16] = finalPermE[31];
	assign encData[17] = finalPermE[38];
	assign encData[18] = finalPermE[6];
	assign encData[19] = finalPermE[46];
	assign encData[20] = finalPermE[14];
	assign encData[21] = finalPermE[54];
	assign encData[22] = finalPermE[22];
	assign encData[23] = finalPermE[62];
	assign encData[24] = finalPermE[30];
	assign encData[25] = finalPermE[37];
	assign encData[26] = finalPermE[5];
	assign encData[27] = finalPermE[45];
	assign encData[28] = finalPermE[13];
	assign encData[29] = finalPermE[53];
	assign encData[30] = finalPermE[21];
	assign encData[31] = finalPermE[61];
	assign encData[32] = finalPermE[29];
	assign encData[33] = finalPermE[36];
	assign encData[34] = finalPermE[4];
	assign encData[35] = finalPermE[44];
	assign encData[36] = finalPermE[12];
	assign encData[37] = finalPermE[52];
	assign encData[38] = finalPermE[20];
	assign encData[39] = finalPermE[60];
	assign encData[40] = finalPermE[28];
	assign encData[41] = finalPermE[35];
	assign encData[42] = finalPermE[3];
	assign encData[43] = finalPermE[43];
	assign encData[44] = finalPermE[11];
	assign encData[45] = finalPermE[51];
	assign encData[46] = finalPermE[19];
	assign encData[47] = finalPermE[59];
	assign encData[48] = finalPermE[27];
	assign encData[49] = finalPermE[34];
	assign encData[50] = finalPermE[2];
	assign encData[51] = finalPermE[42];
	assign encData[52] = finalPermE[10];
	assign encData[53] = finalPermE[50];
	assign encData[54] = finalPermE[18];
	assign encData[55] = finalPermE[58];
	assign encData[56] = finalPermE[26];
	assign encData[57] = finalPermE[33];
	assign encData[58] = finalPermE[1];
	assign encData[59] = finalPermE[41];
	assign encData[60] = finalPermE[9];
	assign encData[61] = finalPermE[49];
	assign encData[62] = finalPermE[17];
	assign encData[63] = finalPermE[57];
	assign encData[64] = finalPermE[25];
	
	// Perform final permutation to complete decoding
	assign decData[1] = finalPermD[40];
	assign decData[2] = finalPermD[8];
	assign decData[3] = finalPermD[48];
	assign decData[4] = finalPermD[16];
	assign decData[5] = finalPermD[56];
	assign decData[6] = finalPermD[24];
	assign decData[7] = finalPermD[64];
	assign decData[8] = finalPermD[32];
	assign decData[9] = finalPermD[39];
	assign decData[10] = finalPermD[7];
	assign decData[11] = finalPermD[47];
	assign decData[12] = finalPermD[15];
	assign decData[13] = finalPermD[55];
	assign decData[14] = finalPermD[23];
	assign decData[15] = finalPermD[63];
	assign decData[16] = finalPermD[31];
	assign decData[17] = finalPermD[38];
	assign decData[18] = finalPermD[6];
	assign decData[19] = finalPermD[46];
	assign decData[20] = finalPermD[14];
	assign decData[21] = finalPermD[54];
	assign decData[22] = finalPermD[22];
	assign decData[23] = finalPermD[62];
	assign decData[24] = finalPermD[30];
	assign decData[25] = finalPermD[37];
	assign decData[26] = finalPermD[5];
	assign decData[27] = finalPermD[45];
	assign decData[28] = finalPermD[13];
	assign decData[29] = finalPermD[53];
	assign decData[30] = finalPermD[21];
	assign decData[31] = finalPermD[61];
	assign decData[32] = finalPermD[29];
	assign decData[33] = finalPermD[36];
	assign decData[34] = finalPermD[4];
	assign decData[35] = finalPermD[44];
	assign decData[36] = finalPermD[12];
	assign decData[37] = finalPermD[52];
	assign decData[38] = finalPermD[20];
	assign decData[39] = finalPermD[60];
	assign decData[40] = finalPermD[28];
	assign decData[41] = finalPermD[35];
	assign decData[42] = finalPermD[3];
	assign decData[43] = finalPermD[43];
	assign decData[44] = finalPermD[11];
	assign decData[45] = finalPermD[51];
	assign decData[46] = finalPermD[19];
	assign decData[47] = finalPermD[59];
	assign decData[48] = finalPermD[27];
	assign decData[49] = finalPermD[34];
	assign decData[50] = finalPermD[2];
	assign decData[51] = finalPermD[42];
	assign decData[52] = finalPermD[10];
	assign decData[53] = finalPermD[50];
	assign decData[54] = finalPermD[18];
	assign decData[55] = finalPermD[58];
	assign decData[56] = finalPermD[26];
	assign decData[57] = finalPermD[33];
	assign decData[58] = finalPermD[1];
	assign decData[59] = finalPermD[41];
	assign decData[60] = finalPermD[9];
	assign decData[61] = finalPermD[49];
	assign decData[62] = finalPermD[17];
	assign decData[63] = finalPermD[57];
	assign decData[64] = finalPermD[25];
	
	// Select encoded data or decoded data as output
	assign DESout = encOrDec ? encData : decData;
	
	hex7seg hex0(DESout[29:32], HEX0);
	hex7seg hex1(DESout[25:28], HEX1);
	hex7seg hex2(DESout[21:24], HEX2);
	hex7seg hex3(DESout[17:20], HEX3);
	hex7seg hex4(DESout[13:16], HEX4);
	hex7seg hex5(DESout[9:12], HEX5);
	hex7seg hex6(DESout[5:8], HEX6);
	hex7seg hex7(DESout[1:4], HEX7);
	
endmodule