module keygen(	input [1:64] key,
				output [1:48] subKey1, subKey2, subKey3, subKey4,
							  subKey5, subKey6, subKey7, subKey8,
							  subKey9, subKey10, subKey11, subKey12,
							  subKey13, subKey14, subKey15, subKey16);
	
	wire [1:56] permKey;
	wire [1:56]	permKey1, permKey2, permKey3, permKey4,
				permKey5, permKey6, permKey7, permKey8,
				permKey9, permKey10, permKey11, permKey12,
				permKey13, permKey14, permKey15, permKey16;
				
	wire [1:28] permKeyLeft;
	wire [1:28]	permKeyLeft1, permKeyLeft2, permKeyLeft3, permKeyLeft4,
				permKeyLeft5, permKeyLeft6, permKeyLeft7, permKeyLeft8,
				permKeyLeft9, permKeyLeft10, permKeyLeft11, permKeyLeft12,
				permKeyLeft13, permKeyLeft14, permKeyLeft15, permKeyLeft16;
	
	wire [1:28] permKeyRight;
	wire [1:28]	permKeyRight1, permKeyRight2, permKeyRight3, permKeyRight4,
				permKeyRight5, permKeyRight6, permKeyRight7, permKeyRight8,
				permKeyRight9, permKeyRight10, permKeyRight11, permKeyRight12,
				permKeyRight13, permKeyRight14, permKeyRight15, permKeyRight16;
	
	// PC-1 for original permKey
	assign permKey[1] = key[57];
	assign permKey[2] = key[49];
	assign permKey[3] = key[41];
	assign permKey[4] = key[33];
	assign permKey[5] = key[25];
	assign permKey[6] = key[17];
	assign permKey[7] = key[9];
	assign permKey[8] = key[1];
	assign permKey[9] = key[58];
	assign permKey[10] = key[50];
	assign permKey[11] = key[42];
	assign permKey[12] = key[34];
	assign permKey[13] = key[26];
	assign permKey[14] = key[18];
	assign permKey[15] = key[10];
	assign permKey[16] = key[2];
	assign permKey[17] = key[59];
	assign permKey[18] = key[51];
	assign permKey[19] = key[43];
	assign permKey[20] = key[35];
	assign permKey[21] = key[27];
	assign permKey[22] = key[19];
	assign permKey[23] = key[11];
	assign permKey[24] = key[3];
	assign permKey[25] = key[60];
	assign permKey[26] = key[52];
	assign permKey[27] = key[44];
	assign permKey[28] = key[36];
	assign permKey[29] = key[63];
	assign permKey[30] = key[55];
	assign permKey[31] = key[47];
	assign permKey[32] = key[39];
	assign permKey[33] = key[31];
	assign permKey[34] = key[23];
	assign permKey[35] = key[15];
	assign permKey[36] = key[7];
	assign permKey[37] = key[62];
	assign permKey[38] = key[54];
	assign permKey[39] = key[46];
	assign permKey[40] = key[38];
	assign permKey[41] = key[30];
	assign permKey[42] = key[22];
	assign permKey[43] = key[14];
	assign permKey[44] = key[6];
	assign permKey[45] = key[61];
	assign permKey[46] = key[53];
	assign permKey[47] = key[45];
	assign permKey[48] = key[37];
	assign permKey[49] = key[29];
	assign permKey[50] = key[21];
	assign permKey[51] = key[13];
	assign permKey[52] = key[5];
	assign permKey[53] = key[28];
	assign permKey[54] = key[20];
	assign permKey[55] = key[12];
	assign permKey[56] = key[4];
	
	// Split permKey into two halves
	assign permKeyLeft = permKey[1:28];
	assign permKeyRight = permKey[29:56];
	
	// Shift left half based on iteration number
	assign permKeyLeft1 = {permKeyLeft[2:28], permKeyLeft[1]};
	assign permKeyLeft2 = {permKeyLeft1[2:28], permKeyLeft1[1]};
	assign permKeyLeft3 = {permKeyLeft2[3:28], permKeyLeft2[1:2]};
	assign permKeyLeft4 = {permKeyLeft3[3:28], permKeyLeft3[1:2]};
	assign permKeyLeft5 = {permKeyLeft4[3:28], permKeyLeft4[1:2]};
	assign permKeyLeft6 = {permKeyLeft5[3:28], permKeyLeft5[1:2]};
	assign permKeyLeft7 = {permKeyLeft6[3:28], permKeyLeft6[1:2]};
	assign permKeyLeft8 = {permKeyLeft7[3:28], permKeyLeft7[1:2]};
	assign permKeyLeft9 = {permKeyLeft8[2:28], permKeyLeft8[1]};
	assign permKeyLeft10 = {permKeyLeft9[3:28], permKeyLeft9[1:2]};
	assign permKeyLeft11 = {permKeyLeft10[3:28], permKeyLeft10[1:2]};
	assign permKeyLeft12 = {permKeyLeft11[3:28], permKeyLeft11[1:2]};
	assign permKeyLeft13 = {permKeyLeft12[3:28], permKeyLeft12[1:2]};
	assign permKeyLeft14 = {permKeyLeft13[3:28], permKeyLeft13[1:2]};
	assign permKeyLeft15 = {permKeyLeft14[3:28], permKeyLeft14[1:2]};
	assign permKeyLeft16 = {permKeyLeft15[2:28], permKeyLeft15[1]};
	
	// Shift right half based on iteration number
	assign permKeyRight1 = {permKeyRight[2:28], permKeyRight[1]};
	assign permKeyRight2 = {permKeyRight1[2:28], permKeyRight1[1]};
	assign permKeyRight3 = {permKeyRight2[3:28], permKeyRight2[1:2]};
	assign permKeyRight4 = {permKeyRight3[3:28], permKeyRight3[1:2]};
	assign permKeyRight5 = {permKeyRight4[3:28], permKeyRight4[1:2]};
	assign permKeyRight6 = {permKeyRight5[3:28], permKeyRight5[1:2]};
	assign permKeyRight7 = {permKeyRight6[3:28], permKeyRight6[1:2]};
	assign permKeyRight8 = {permKeyRight7[3:28], permKeyRight7[1:2]};
	assign permKeyRight9 = {permKeyRight8[2:28], permKeyRight8[1]};
	assign permKeyRight10 = {permKeyRight9[3:28], permKeyRight9[1:2]};
	assign permKeyRight11 = {permKeyRight10[3:28], permKeyRight10[1:2]};
	assign permKeyRight12 = {permKeyRight11[3:28], permKeyRight11[1:2]};
	assign permKeyRight13 = {permKeyRight12[3:28], permKeyRight12[1:2]};
	assign permKeyRight14 = {permKeyRight13[3:28], permKeyRight13[1:2]};
	assign permKeyRight15 = {permKeyRight14[3:28], permKeyRight14[1:2]};
	assign permKeyRight16 = {permKeyRight15[2:28], permKeyRight15[1]};
	
	// Merge permKey halves
	assign permKey1 = {permKeyLeft1, permKeyRight1};
	assign permKey2 = {permKeyLeft2, permKeyRight2};
	assign permKey3 = {permKeyLeft3, permKeyRight3};
	assign permKey4 = {permKeyLeft4, permKeyRight4};
	assign permKey5 = {permKeyLeft5, permKeyRight5};
	assign permKey6 = {permKeyLeft6, permKeyRight6};
	assign permKey7 = {permKeyLeft7, permKeyRight7};
	assign permKey8 = {permKeyLeft8, permKeyRight8};
	assign permKey9 = {permKeyLeft9, permKeyRight9};
	assign permKey10 = {permKeyLeft10, permKeyRight10};
	assign permKey11 = {permKeyLeft11, permKeyRight11};
	assign permKey12 = {permKeyLeft12, permKeyRight12};
	assign permKey13 = {permKeyLeft13, permKeyRight13};
	assign permKey14 = {permKeyLeft14, permKeyRight14};
	assign permKey15 = {permKeyLeft15, permKeyRight15};
	assign permKey16 = {permKeyLeft16, permKeyRight16};
	
	// PC-2 for subKey1
	assign subKey1[1] = permKey1[14];
	assign subKey1[2] = permKey1[17];
	assign subKey1[3] = permKey1[11];
	assign subKey1[4] = permKey1[24];
	assign subKey1[5] = permKey1[1];
	assign subKey1[6] = permKey1[5];
	assign subKey1[7] = permKey1[3];
	assign subKey1[8] = permKey1[28];
	assign subKey1[9] = permKey1[15];
	assign subKey1[10] = permKey1[6];
	assign subKey1[11] = permKey1[21];
	assign subKey1[12] = permKey1[10];
	assign subKey1[13] = permKey1[23];
	assign subKey1[14] = permKey1[19];
	assign subKey1[15] = permKey1[12];
	assign subKey1[16] = permKey1[4];
	assign subKey1[17] = permKey1[26];
	assign subKey1[18] = permKey1[8];
	assign subKey1[19] = permKey1[16];
	assign subKey1[20] = permKey1[7];
	assign subKey1[21] = permKey1[27];
	assign subKey1[22] = permKey1[20];
	assign subKey1[23] = permKey1[13];
	assign subKey1[24] = permKey1[2];
	assign subKey1[25] = permKey1[41];
	assign subKey1[26] = permKey1[52];
	assign subKey1[27] = permKey1[31];
	assign subKey1[28] = permKey1[37];
	assign subKey1[29] = permKey1[47];
	assign subKey1[30] = permKey1[55];
	assign subKey1[31] = permKey1[30];
	assign subKey1[32] = permKey1[40];
	assign subKey1[33] = permKey1[51];
	assign subKey1[34] = permKey1[45];
	assign subKey1[35] = permKey1[33];
	assign subKey1[36] = permKey1[48];
	assign subKey1[37] = permKey1[44];
	assign subKey1[38] = permKey1[49];
	assign subKey1[39] = permKey1[39];
	assign subKey1[40] = permKey1[56];
	assign subKey1[41] = permKey1[34];
	assign subKey1[42] = permKey1[53];
	assign subKey1[43] = permKey1[46];
	assign subKey1[44] = permKey1[42];
	assign subKey1[45] = permKey1[50];
	assign subKey1[46] = permKey1[36];
	assign subKey1[47] = permKey1[29];
	assign subKey1[48] = permKey1[32];
	
	// PC-2 for subKey2
	assign subKey2[1] = permKey2[14];
	assign subKey2[2] = permKey2[17];
	assign subKey2[3] = permKey2[11];
	assign subKey2[4] = permKey2[24];
	assign subKey2[5] = permKey2[1];
	assign subKey2[6] = permKey2[5];
	assign subKey2[7] = permKey2[3];
	assign subKey2[8] = permKey2[28];
	assign subKey2[9] = permKey2[15];
	assign subKey2[10] = permKey2[6];
	assign subKey2[11] = permKey2[21];
	assign subKey2[12] = permKey2[10];
	assign subKey2[13] = permKey2[23];
	assign subKey2[14] = permKey2[19];
	assign subKey2[15] = permKey2[12];
	assign subKey2[16] = permKey2[4];
	assign subKey2[17] = permKey2[26];
	assign subKey2[18] = permKey2[8];
	assign subKey2[19] = permKey2[16];
	assign subKey2[20] = permKey2[7];
	assign subKey2[21] = permKey2[27];
	assign subKey2[22] = permKey2[20];
	assign subKey2[23] = permKey2[13];
	assign subKey2[24] = permKey2[2];
	assign subKey2[25] = permKey2[41];
	assign subKey2[26] = permKey2[52];
	assign subKey2[27] = permKey2[31];
	assign subKey2[28] = permKey2[37];
	assign subKey2[29] = permKey2[47];
	assign subKey2[30] = permKey2[55];
	assign subKey2[31] = permKey2[30];
	assign subKey2[32] = permKey2[40];
	assign subKey2[33] = permKey2[51];
	assign subKey2[34] = permKey2[45];
	assign subKey2[35] = permKey2[33];
	assign subKey2[36] = permKey2[48];
	assign subKey2[37] = permKey2[44];
	assign subKey2[38] = permKey2[49];
	assign subKey2[39] = permKey2[39];
	assign subKey2[40] = permKey2[56];
	assign subKey2[41] = permKey2[34];
	assign subKey2[42] = permKey2[53];
	assign subKey2[43] = permKey2[46];
	assign subKey2[44] = permKey2[42];
	assign subKey2[45] = permKey2[50];
	assign subKey2[46] = permKey2[36];
	assign subKey2[47] = permKey2[29];
	assign subKey2[48] = permKey2[32];

	// PC-2 for subKey3
	assign subKey3[1] = permKey3[14];
	assign subKey3[2] = permKey3[17];
	assign subKey3[3] = permKey3[11];
	assign subKey3[4] = permKey3[24];
	assign subKey3[5] = permKey3[1];
	assign subKey3[6] = permKey3[5];
	assign subKey3[7] = permKey3[3];
	assign subKey3[8] = permKey3[28];
	assign subKey3[9] = permKey3[15];
	assign subKey3[10] = permKey3[6];
	assign subKey3[11] = permKey3[21];
	assign subKey3[12] = permKey3[10];
	assign subKey3[13] = permKey3[23];
	assign subKey3[14] = permKey3[19];
	assign subKey3[15] = permKey3[12];
	assign subKey3[16] = permKey3[4];
	assign subKey3[17] = permKey3[26];
	assign subKey3[18] = permKey3[8];
	assign subKey3[19] = permKey3[16];
	assign subKey3[20] = permKey3[7];
	assign subKey3[21] = permKey3[27];
	assign subKey3[22] = permKey3[20];
	assign subKey3[23] = permKey3[13];
	assign subKey3[24] = permKey3[2];
	assign subKey3[25] = permKey3[41];
	assign subKey3[26] = permKey3[52];
	assign subKey3[27] = permKey3[31];
	assign subKey3[28] = permKey3[37];
	assign subKey3[29] = permKey3[47];
	assign subKey3[30] = permKey3[55];
	assign subKey3[31] = permKey3[30];
	assign subKey3[32] = permKey3[40];
	assign subKey3[33] = permKey3[51];
	assign subKey3[34] = permKey3[45];
	assign subKey3[35] = permKey3[33];
	assign subKey3[36] = permKey3[48];
	assign subKey3[37] = permKey3[44];
	assign subKey3[38] = permKey3[49];
	assign subKey3[39] = permKey3[39];
	assign subKey3[40] = permKey3[56];
	assign subKey3[41] = permKey3[34];
	assign subKey3[42] = permKey3[53];
	assign subKey3[43] = permKey3[46];
	assign subKey3[44] = permKey3[42];
	assign subKey3[45] = permKey3[50];
	assign subKey3[46] = permKey3[36];
	assign subKey3[47] = permKey3[29];
	assign subKey3[48] = permKey3[32];

	// PC-2 for subKey4
	assign subKey4[1] = permKey4[14];
	assign subKey4[2] = permKey4[17];
	assign subKey4[3] = permKey4[11];
	assign subKey4[4] = permKey4[24];
	assign subKey4[5] = permKey4[1];
	assign subKey4[6] = permKey4[5];
	assign subKey4[7] = permKey4[3];
	assign subKey4[8] = permKey4[28];
	assign subKey4[9] = permKey4[15];
	assign subKey4[10] = permKey4[6];
	assign subKey4[11] = permKey4[21];
	assign subKey4[12] = permKey4[10];
	assign subKey4[13] = permKey4[23];
	assign subKey4[14] = permKey4[19];
	assign subKey4[15] = permKey4[12];
	assign subKey4[16] = permKey4[4];
	assign subKey4[17] = permKey4[26];
	assign subKey4[18] = permKey4[8];
	assign subKey4[19] = permKey4[16];
	assign subKey4[20] = permKey4[7];
	assign subKey4[21] = permKey4[27];
	assign subKey4[22] = permKey4[20];
	assign subKey4[23] = permKey4[13];
	assign subKey4[24] = permKey4[2];
	assign subKey4[25] = permKey4[41];
	assign subKey4[26] = permKey4[52];
	assign subKey4[27] = permKey4[31];
	assign subKey4[28] = permKey4[37];
	assign subKey4[29] = permKey4[47];
	assign subKey4[30] = permKey4[55];
	assign subKey4[31] = permKey4[30];
	assign subKey4[32] = permKey4[40];
	assign subKey4[33] = permKey4[51];
	assign subKey4[34] = permKey4[45];
	assign subKey4[35] = permKey4[33];
	assign subKey4[36] = permKey4[48];
	assign subKey4[37] = permKey4[44];
	assign subKey4[38] = permKey4[49];
	assign subKey4[39] = permKey4[39];
	assign subKey4[40] = permKey4[56];
	assign subKey4[41] = permKey4[34];
	assign subKey4[42] = permKey4[53];
	assign subKey4[43] = permKey4[46];
	assign subKey4[44] = permKey4[42];
	assign subKey4[45] = permKey4[50];
	assign subKey4[46] = permKey4[36];
	assign subKey4[47] = permKey4[29];
	assign subKey4[48] = permKey4[32];
	
	// PC-2 for subKey5
	assign subKey5[1] = permKey5[14];
	assign subKey5[2] = permKey5[17];
	assign subKey5[3] = permKey5[11];
	assign subKey5[4] = permKey5[24];
	assign subKey5[5] = permKey5[1];
	assign subKey5[6] = permKey5[5];
	assign subKey5[7] = permKey5[3];
	assign subKey5[8] = permKey5[28];
	assign subKey5[9] = permKey5[15];
	assign subKey5[10] = permKey5[6];
	assign subKey5[11] = permKey5[21];
	assign subKey5[12] = permKey5[10];
	assign subKey5[13] = permKey5[23];
	assign subKey5[14] = permKey5[19];
	assign subKey5[15] = permKey5[12];
	assign subKey5[16] = permKey5[4];
	assign subKey5[17] = permKey5[26];
	assign subKey5[18] = permKey5[8];
	assign subKey5[19] = permKey5[16];
	assign subKey5[20] = permKey5[7];
	assign subKey5[21] = permKey5[27];
	assign subKey5[22] = permKey5[20];
	assign subKey5[23] = permKey5[13];
	assign subKey5[24] = permKey5[2];
	assign subKey5[25] = permKey5[41];
	assign subKey5[26] = permKey5[52];
	assign subKey5[27] = permKey5[31];
	assign subKey5[28] = permKey5[37];
	assign subKey5[29] = permKey5[47];
	assign subKey5[30] = permKey5[55];
	assign subKey5[31] = permKey5[30];
	assign subKey5[32] = permKey5[40];
	assign subKey5[33] = permKey5[51];
	assign subKey5[34] = permKey5[45];
	assign subKey5[35] = permKey5[33];
	assign subKey5[36] = permKey5[48];
	assign subKey5[37] = permKey5[44];
	assign subKey5[38] = permKey5[49];
	assign subKey5[39] = permKey5[39];
	assign subKey5[40] = permKey5[56];
	assign subKey5[41] = permKey5[34];
	assign subKey5[42] = permKey5[53];
	assign subKey5[43] = permKey5[46];
	assign subKey5[44] = permKey5[42];
	assign subKey5[45] = permKey5[50];
	assign subKey5[46] = permKey5[36];
	assign subKey5[47] = permKey5[29];
	assign subKey5[48] = permKey5[32];
	
	// PC-2 for subKey6
	assign subKey6[1] = permKey6[14];
	assign subKey6[2] = permKey6[17];
	assign subKey6[3] = permKey6[11];
	assign subKey6[4] = permKey6[24];
	assign subKey6[5] = permKey6[1];
	assign subKey6[6] = permKey6[5];
	assign subKey6[7] = permKey6[3];
	assign subKey6[8] = permKey6[28];
	assign subKey6[9] = permKey6[15];
	assign subKey6[10] = permKey6[6];
	assign subKey6[11] = permKey6[21];
	assign subKey6[12] = permKey6[10];
	assign subKey6[13] = permKey6[23];
	assign subKey6[14] = permKey6[19];
	assign subKey6[15] = permKey6[12];
	assign subKey6[16] = permKey6[4];
	assign subKey6[17] = permKey6[26];
	assign subKey6[18] = permKey6[8];
	assign subKey6[19] = permKey6[16];
	assign subKey6[20] = permKey6[7];
	assign subKey6[21] = permKey6[27];
	assign subKey6[22] = permKey6[20];
	assign subKey6[23] = permKey6[13];
	assign subKey6[24] = permKey6[2];
	assign subKey6[25] = permKey6[41];
	assign subKey6[26] = permKey6[52];
	assign subKey6[27] = permKey6[31];
	assign subKey6[28] = permKey6[37];
	assign subKey6[29] = permKey6[47];
	assign subKey6[30] = permKey6[55];
	assign subKey6[31] = permKey6[30];
	assign subKey6[32] = permKey6[40];
	assign subKey6[33] = permKey6[51];
	assign subKey6[34] = permKey6[45];
	assign subKey6[35] = permKey6[33];
	assign subKey6[36] = permKey6[48];
	assign subKey6[37] = permKey6[44];
	assign subKey6[38] = permKey6[49];
	assign subKey6[39] = permKey6[39];
	assign subKey6[40] = permKey6[56];
	assign subKey6[41] = permKey6[34];
	assign subKey6[42] = permKey6[53];
	assign subKey6[43] = permKey6[46];
	assign subKey6[44] = permKey6[42];
	assign subKey6[45] = permKey6[50];
	assign subKey6[46] = permKey6[36];
	assign subKey6[47] = permKey6[29];
	assign subKey6[48] = permKey6[32];
	
	// PC-2 for subKey7
	assign subKey7[1] = permKey7[14];
	assign subKey7[2] = permKey7[17];
	assign subKey7[3] = permKey7[11];
	assign subKey7[4] = permKey7[24];
	assign subKey7[5] = permKey7[1];
	assign subKey7[6] = permKey7[5];
	assign subKey7[7] = permKey7[3];
	assign subKey7[8] = permKey7[28];
	assign subKey7[9] = permKey7[15];
	assign subKey7[10] = permKey7[6];
	assign subKey7[11] = permKey7[21];
	assign subKey7[12] = permKey7[10];
	assign subKey7[13] = permKey7[23];
	assign subKey7[14] = permKey7[19];
	assign subKey7[15] = permKey7[12];
	assign subKey7[16] = permKey7[4];
	assign subKey7[17] = permKey7[26];
	assign subKey7[18] = permKey7[8];
	assign subKey7[19] = permKey7[16];
	assign subKey7[20] = permKey7[7];
	assign subKey7[21] = permKey7[27];
	assign subKey7[22] = permKey7[20];
	assign subKey7[23] = permKey7[13];
	assign subKey7[24] = permKey7[2];
	assign subKey7[25] = permKey7[41];
	assign subKey7[26] = permKey7[52];
	assign subKey7[27] = permKey7[31];
	assign subKey7[28] = permKey7[37];
	assign subKey7[29] = permKey7[47];
	assign subKey7[30] = permKey7[55];
	assign subKey7[31] = permKey7[30];
	assign subKey7[32] = permKey7[40];
	assign subKey7[33] = permKey7[51];
	assign subKey7[34] = permKey7[45];
	assign subKey7[35] = permKey7[33];
	assign subKey7[36] = permKey7[48];
	assign subKey7[37] = permKey7[44];
	assign subKey7[38] = permKey7[49];
	assign subKey7[39] = permKey7[39];
	assign subKey7[40] = permKey7[56];
	assign subKey7[41] = permKey7[34];
	assign subKey7[42] = permKey7[53];
	assign subKey7[43] = permKey7[46];
	assign subKey7[44] = permKey7[42];
	assign subKey7[45] = permKey7[50];
	assign subKey7[46] = permKey7[36];
	assign subKey7[47] = permKey7[29];
	assign subKey7[48] = permKey7[32];
	
	// PC-2 for subKey8
	assign subKey8[1] = permKey8[14];
	assign subKey8[2] = permKey8[17];
	assign subKey8[3] = permKey8[11];
	assign subKey8[4] = permKey8[24];
	assign subKey8[5] = permKey8[1];
	assign subKey8[6] = permKey8[5];
	assign subKey8[7] = permKey8[3];
	assign subKey8[8] = permKey8[28];
	assign subKey8[9] = permKey8[15];
	assign subKey8[10] = permKey8[6];
	assign subKey8[11] = permKey8[21];
	assign subKey8[12] = permKey8[10];
	assign subKey8[13] = permKey8[23];
	assign subKey8[14] = permKey8[19];
	assign subKey8[15] = permKey8[12];
	assign subKey8[16] = permKey8[4];
	assign subKey8[17] = permKey8[26];
	assign subKey8[18] = permKey8[8];
	assign subKey8[19] = permKey8[16];
	assign subKey8[20] = permKey8[7];
	assign subKey8[21] = permKey8[27];
	assign subKey8[22] = permKey8[20];
	assign subKey8[23] = permKey8[13];
	assign subKey8[24] = permKey8[2];
	assign subKey8[25] = permKey8[41];
	assign subKey8[26] = permKey8[52];
	assign subKey8[27] = permKey8[31];
	assign subKey8[28] = permKey8[37];
	assign subKey8[29] = permKey8[47];
	assign subKey8[30] = permKey8[55];
	assign subKey8[31] = permKey8[30];
	assign subKey8[32] = permKey8[40];
	assign subKey8[33] = permKey8[51];
	assign subKey8[34] = permKey8[45];
	assign subKey8[35] = permKey8[33];
	assign subKey8[36] = permKey8[48];
	assign subKey8[37] = permKey8[44];
	assign subKey8[38] = permKey8[49];
	assign subKey8[39] = permKey8[39];
	assign subKey8[40] = permKey8[56];
	assign subKey8[41] = permKey8[34];
	assign subKey8[42] = permKey8[53];
	assign subKey8[43] = permKey8[46];
	assign subKey8[44] = permKey8[42];
	assign subKey8[45] = permKey8[50];
	assign subKey8[46] = permKey8[36];
	assign subKey8[47] = permKey8[29];
	assign subKey8[48] = permKey8[32];
	
	// PC-2 for subKey9
	assign subKey9[1] = permKey9[14];
	assign subKey9[2] = permKey9[17];
	assign subKey9[3] = permKey9[11];
	assign subKey9[4] = permKey9[24];
	assign subKey9[5] = permKey9[1];
	assign subKey9[6] = permKey9[5];
	assign subKey9[7] = permKey9[3];
	assign subKey9[8] = permKey9[28];
	assign subKey9[9] = permKey9[15];
	assign subKey9[10] = permKey9[6];
	assign subKey9[11] = permKey9[21];
	assign subKey9[12] = permKey9[10];
	assign subKey9[13] = permKey9[23];
	assign subKey9[14] = permKey9[19];
	assign subKey9[15] = permKey9[12];
	assign subKey9[16] = permKey9[4];
	assign subKey9[17] = permKey9[26];
	assign subKey9[18] = permKey9[8];
	assign subKey9[19] = permKey9[16];
	assign subKey9[20] = permKey9[7];
	assign subKey9[21] = permKey9[27];
	assign subKey9[22] = permKey9[20];
	assign subKey9[23] = permKey9[13];
	assign subKey9[24] = permKey9[2];
	assign subKey9[25] = permKey9[41];
	assign subKey9[26] = permKey9[52];
	assign subKey9[27] = permKey9[31];
	assign subKey9[28] = permKey9[37];
	assign subKey9[29] = permKey9[47];
	assign subKey9[30] = permKey9[55];
	assign subKey9[31] = permKey9[30];
	assign subKey9[32] = permKey9[40];
	assign subKey9[33] = permKey9[51];
	assign subKey9[34] = permKey9[45];
	assign subKey9[35] = permKey9[33];
	assign subKey9[36] = permKey9[48];
	assign subKey9[37] = permKey9[44];
	assign subKey9[38] = permKey9[49];
	assign subKey9[39] = permKey9[39];
	assign subKey9[40] = permKey9[56];
	assign subKey9[41] = permKey9[34];
	assign subKey9[42] = permKey9[53];
	assign subKey9[43] = permKey9[46];
	assign subKey9[44] = permKey9[42];
	assign subKey9[45] = permKey9[50];
	assign subKey9[46] = permKey9[36];
	assign subKey9[47] = permKey9[29];
	assign subKey9[48] = permKey9[32];
	
	// PC-2 for subKey10
	assign subKey10[1] = permKey10[14];
	assign subKey10[2] = permKey10[17];
	assign subKey10[3] = permKey10[11];
	assign subKey10[4] = permKey10[24];
	assign subKey10[5] = permKey10[1];
	assign subKey10[6] = permKey10[5];
	assign subKey10[7] = permKey10[3];
	assign subKey10[8] = permKey10[28];
	assign subKey10[9] = permKey10[15];
	assign subKey10[10] = permKey10[6];
	assign subKey10[11] = permKey10[21];
	assign subKey10[12] = permKey10[10];
	assign subKey10[13] = permKey10[23];
	assign subKey10[14] = permKey10[19];
	assign subKey10[15] = permKey10[12];
	assign subKey10[16] = permKey10[4];
	assign subKey10[17] = permKey10[26];
	assign subKey10[18] = permKey10[8];
	assign subKey10[19] = permKey10[16];
	assign subKey10[20] = permKey10[7];
	assign subKey10[21] = permKey10[27];
	assign subKey10[22] = permKey10[20];
	assign subKey10[23] = permKey10[13];
	assign subKey10[24] = permKey10[2];
	assign subKey10[25] = permKey10[41];
	assign subKey10[26] = permKey10[52];
	assign subKey10[27] = permKey10[31];
	assign subKey10[28] = permKey10[37];
	assign subKey10[29] = permKey10[47];
	assign subKey10[30] = permKey10[55];
	assign subKey10[31] = permKey10[30];
	assign subKey10[32] = permKey10[40];
	assign subKey10[33] = permKey10[51];
	assign subKey10[34] = permKey10[45];
	assign subKey10[35] = permKey10[33];
	assign subKey10[36] = permKey10[48];
	assign subKey10[37] = permKey10[44];
	assign subKey10[38] = permKey10[49];
	assign subKey10[39] = permKey10[39];
	assign subKey10[40] = permKey10[56];
	assign subKey10[41] = permKey10[34];
	assign subKey10[42] = permKey10[53];
	assign subKey10[43] = permKey10[46];
	assign subKey10[44] = permKey10[42];
	assign subKey10[45] = permKey10[50];
	assign subKey10[46] = permKey10[36];
	assign subKey10[47] = permKey10[29];
	assign subKey10[48] = permKey10[32];
	
	// PC-2 for subKey11
	assign subKey11[1] = permKey11[14];
	assign subKey11[2] = permKey11[17];
	assign subKey11[3] = permKey11[11];
	assign subKey11[4] = permKey11[24];
	assign subKey11[5] = permKey11[1];
	assign subKey11[6] = permKey11[5];
	assign subKey11[7] = permKey11[3];
	assign subKey11[8] = permKey11[28];
	assign subKey11[9] = permKey11[15];
	assign subKey11[10] = permKey11[6];
	assign subKey11[11] = permKey11[21];
	assign subKey11[12] = permKey11[10];
	assign subKey11[13] = permKey11[23];
	assign subKey11[14] = permKey11[19];
	assign subKey11[15] = permKey11[12];
	assign subKey11[16] = permKey11[4];
	assign subKey11[17] = permKey11[26];
	assign subKey11[18] = permKey11[8];
	assign subKey11[19] = permKey11[16];
	assign subKey11[20] = permKey11[7];
	assign subKey11[21] = permKey11[27];
	assign subKey11[22] = permKey11[20];
	assign subKey11[23] = permKey11[13];
	assign subKey11[24] = permKey11[2];
	assign subKey11[25] = permKey11[41];
	assign subKey11[26] = permKey11[52];
	assign subKey11[27] = permKey11[31];
	assign subKey11[28] = permKey11[37];
	assign subKey11[29] = permKey11[47];
	assign subKey11[30] = permKey11[55];
	assign subKey11[31] = permKey11[30];
	assign subKey11[32] = permKey11[40];
	assign subKey11[33] = permKey11[51];
	assign subKey11[34] = permKey11[45];
	assign subKey11[35] = permKey11[33];
	assign subKey11[36] = permKey11[48];
	assign subKey11[37] = permKey11[44];
	assign subKey11[38] = permKey11[49];
	assign subKey11[39] = permKey11[39];
	assign subKey11[40] = permKey11[56];
	assign subKey11[41] = permKey11[34];
	assign subKey11[42] = permKey11[53];
	assign subKey11[43] = permKey11[46];
	assign subKey11[44] = permKey11[42];
	assign subKey11[45] = permKey11[50];
	assign subKey11[46] = permKey11[36];
	assign subKey11[47] = permKey11[29];
	assign subKey11[48] = permKey11[32];
	
	// PC-2 for subKey12
	assign subKey12[1] = permKey12[14];
	assign subKey12[2] = permKey12[17];
	assign subKey12[3] = permKey12[11];
	assign subKey12[4] = permKey12[24];
	assign subKey12[5] = permKey12[1];
	assign subKey12[6] = permKey12[5];
	assign subKey12[7] = permKey12[3];
	assign subKey12[8] = permKey12[28];
	assign subKey12[9] = permKey12[15];
	assign subKey12[10] = permKey12[6];
	assign subKey12[11] = permKey12[21];
	assign subKey12[12] = permKey12[10];
	assign subKey12[13] = permKey12[23];
	assign subKey12[14] = permKey12[19];
	assign subKey12[15] = permKey12[12];
	assign subKey12[16] = permKey12[4];
	assign subKey12[17] = permKey12[26];
	assign subKey12[18] = permKey12[8];
	assign subKey12[19] = permKey12[16];
	assign subKey12[20] = permKey12[7];
	assign subKey12[21] = permKey12[27];
	assign subKey12[22] = permKey12[20];
	assign subKey12[23] = permKey12[13];
	assign subKey12[24] = permKey12[2];
	assign subKey12[25] = permKey12[41];
	assign subKey12[26] = permKey12[52];
	assign subKey12[27] = permKey12[31];
	assign subKey12[28] = permKey12[37];
	assign subKey12[29] = permKey12[47];
	assign subKey12[30] = permKey12[55];
	assign subKey12[31] = permKey12[30];
	assign subKey12[32] = permKey12[40];
	assign subKey12[33] = permKey12[51];
	assign subKey12[34] = permKey12[45];
	assign subKey12[35] = permKey12[33];
	assign subKey12[36] = permKey12[48];
	assign subKey12[37] = permKey12[44];
	assign subKey12[38] = permKey12[49];
	assign subKey12[39] = permKey12[39];
	assign subKey12[40] = permKey12[56];
	assign subKey12[41] = permKey12[34];
	assign subKey12[42] = permKey12[53];
	assign subKey12[43] = permKey12[46];
	assign subKey12[44] = permKey12[42];
	assign subKey12[45] = permKey12[50];
	assign subKey12[46] = permKey12[36];
	assign subKey12[47] = permKey12[29];
	assign subKey12[48] = permKey12[32];
	
	// PC-2 for subKey13
	assign subKey13[1] = permKey13[14];
	assign subKey13[2] = permKey13[17];
	assign subKey13[3] = permKey13[11];
	assign subKey13[4] = permKey13[24];
	assign subKey13[5] = permKey13[1];
	assign subKey13[6] = permKey13[5];
	assign subKey13[7] = permKey13[3];
	assign subKey13[8] = permKey13[28];
	assign subKey13[9] = permKey13[15];
	assign subKey13[10] = permKey13[6];
	assign subKey13[11] = permKey13[21];
	assign subKey13[12] = permKey13[10];
	assign subKey13[13] = permKey13[23];
	assign subKey13[14] = permKey13[19];
	assign subKey13[15] = permKey13[12];
	assign subKey13[16] = permKey13[4];
	assign subKey13[17] = permKey13[26];
	assign subKey13[18] = permKey13[8];
	assign subKey13[19] = permKey13[16];
	assign subKey13[20] = permKey13[7];
	assign subKey13[21] = permKey13[27];
	assign subKey13[22] = permKey13[20];
	assign subKey13[23] = permKey13[13];
	assign subKey13[24] = permKey13[2];
	assign subKey13[25] = permKey13[41];
	assign subKey13[26] = permKey13[52];
	assign subKey13[27] = permKey13[31];
	assign subKey13[28] = permKey13[37];
	assign subKey13[29] = permKey13[47];
	assign subKey13[30] = permKey13[55];
	assign subKey13[31] = permKey13[30];
	assign subKey13[32] = permKey13[40];
	assign subKey13[33] = permKey13[51];
	assign subKey13[34] = permKey13[45];
	assign subKey13[35] = permKey13[33];
	assign subKey13[36] = permKey13[48];
	assign subKey13[37] = permKey13[44];
	assign subKey13[38] = permKey13[49];
	assign subKey13[39] = permKey13[39];
	assign subKey13[40] = permKey13[56];
	assign subKey13[41] = permKey13[34];
	assign subKey13[42] = permKey13[53];
	assign subKey13[43] = permKey13[46];
	assign subKey13[44] = permKey13[42];
	assign subKey13[45] = permKey13[50];
	assign subKey13[46] = permKey13[36];
	assign subKey13[47] = permKey13[29];
	assign subKey13[48] = permKey13[32];
	
	// PC-2 for subKey14
	assign subKey14[1] = permKey14[14];
	assign subKey14[2] = permKey14[17];
	assign subKey14[3] = permKey14[11];
	assign subKey14[4] = permKey14[24];
	assign subKey14[5] = permKey14[1];
	assign subKey14[6] = permKey14[5];
	assign subKey14[7] = permKey14[3];
	assign subKey14[8] = permKey14[28];
	assign subKey14[9] = permKey14[15];
	assign subKey14[10] = permKey14[6];
	assign subKey14[11] = permKey14[21];
	assign subKey14[12] = permKey14[10];
	assign subKey14[13] = permKey14[23];
	assign subKey14[14] = permKey14[19];
	assign subKey14[15] = permKey14[12];
	assign subKey14[16] = permKey14[4];
	assign subKey14[17] = permKey14[26];
	assign subKey14[18] = permKey14[8];
	assign subKey14[19] = permKey14[16];
	assign subKey14[20] = permKey14[7];
	assign subKey14[21] = permKey14[27];
	assign subKey14[22] = permKey14[20];
	assign subKey14[23] = permKey14[13];
	assign subKey14[24] = permKey14[2];
	assign subKey14[25] = permKey14[41];
	assign subKey14[26] = permKey14[52];
	assign subKey14[27] = permKey14[31];
	assign subKey14[28] = permKey14[37];
	assign subKey14[29] = permKey14[47];
	assign subKey14[30] = permKey14[55];
	assign subKey14[31] = permKey14[30];
	assign subKey14[32] = permKey14[40];
	assign subKey14[33] = permKey14[51];
	assign subKey14[34] = permKey14[45];
	assign subKey14[35] = permKey14[33];
	assign subKey14[36] = permKey14[48];
	assign subKey14[37] = permKey14[44];
	assign subKey14[38] = permKey14[49];
	assign subKey14[39] = permKey14[39];
	assign subKey14[40] = permKey14[56];
	assign subKey14[41] = permKey14[34];
	assign subKey14[42] = permKey14[53];
	assign subKey14[43] = permKey14[46];
	assign subKey14[44] = permKey14[42];
	assign subKey14[45] = permKey14[50];
	assign subKey14[46] = permKey14[36];
	assign subKey14[47] = permKey14[29];
	assign subKey14[48] = permKey14[32];
	
	// PC-2 for subKey15
	assign subKey15[1] = permKey15[14];
	assign subKey15[2] = permKey15[17];
	assign subKey15[3] = permKey15[11];
	assign subKey15[4] = permKey15[24];
	assign subKey15[5] = permKey15[1];
	assign subKey15[6] = permKey15[5];
	assign subKey15[7] = permKey15[3];
	assign subKey15[8] = permKey15[28];
	assign subKey15[9] = permKey15[15];
	assign subKey15[10] = permKey15[6];
	assign subKey15[11] = permKey15[21];
	assign subKey15[12] = permKey15[10];
	assign subKey15[13] = permKey15[23];
	assign subKey15[14] = permKey15[19];
	assign subKey15[15] = permKey15[12];
	assign subKey15[16] = permKey15[4];
	assign subKey15[17] = permKey15[26];
	assign subKey15[18] = permKey15[8];
	assign subKey15[19] = permKey15[16];
	assign subKey15[20] = permKey15[7];
	assign subKey15[21] = permKey15[27];
	assign subKey15[22] = permKey15[20];
	assign subKey15[23] = permKey15[13];
	assign subKey15[24] = permKey15[2];
	assign subKey15[25] = permKey15[41];
	assign subKey15[26] = permKey15[52];
	assign subKey15[27] = permKey15[31];
	assign subKey15[28] = permKey15[37];
	assign subKey15[29] = permKey15[47];
	assign subKey15[30] = permKey15[55];
	assign subKey15[31] = permKey15[30];
	assign subKey15[32] = permKey15[40];
	assign subKey15[33] = permKey15[51];
	assign subKey15[34] = permKey15[45];
	assign subKey15[35] = permKey15[33];
	assign subKey15[36] = permKey15[48];
	assign subKey15[37] = permKey15[44];
	assign subKey15[38] = permKey15[49];
	assign subKey15[39] = permKey15[39];
	assign subKey15[40] = permKey15[56];
	assign subKey15[41] = permKey15[34];
	assign subKey15[42] = permKey15[53];
	assign subKey15[43] = permKey15[46];
	assign subKey15[44] = permKey15[42];
	assign subKey15[45] = permKey15[50];
	assign subKey15[46] = permKey15[36];
	assign subKey15[47] = permKey15[29];
	assign subKey15[48] = permKey15[32];
	
	// PC-2 for subKey16
	assign subKey16[1] = permKey16[14];
	assign subKey16[2] = permKey16[17];
	assign subKey16[3] = permKey16[11];
	assign subKey16[4] = permKey16[24];
	assign subKey16[5] = permKey16[1];
	assign subKey16[6] = permKey16[5];
	assign subKey16[7] = permKey16[3];
	assign subKey16[8] = permKey16[28];
	assign subKey16[9] = permKey16[15];
	assign subKey16[10] = permKey16[6];
	assign subKey16[11] = permKey16[21];
	assign subKey16[12] = permKey16[10];
	assign subKey16[13] = permKey16[23];
	assign subKey16[14] = permKey16[19];
	assign subKey16[15] = permKey16[12];
	assign subKey16[16] = permKey16[4];
	assign subKey16[17] = permKey16[26];
	assign subKey16[18] = permKey16[8];
	assign subKey16[19] = permKey16[16];
	assign subKey16[20] = permKey16[7];
	assign subKey16[21] = permKey16[27];
	assign subKey16[22] = permKey16[20];
	assign subKey16[23] = permKey16[13];
	assign subKey16[24] = permKey16[2];
	assign subKey16[25] = permKey16[41];
	assign subKey16[26] = permKey16[52];
	assign subKey16[27] = permKey16[31];
	assign subKey16[28] = permKey16[37];
	assign subKey16[29] = permKey16[47];
	assign subKey16[30] = permKey16[55];
	assign subKey16[31] = permKey16[30];
	assign subKey16[32] = permKey16[40];
	assign subKey16[33] = permKey16[51];
	assign subKey16[34] = permKey16[45];
	assign subKey16[35] = permKey16[33];
	assign subKey16[36] = permKey16[48];
	assign subKey16[37] = permKey16[44];
	assign subKey16[38] = permKey16[49];
	assign subKey16[39] = permKey16[39];
	assign subKey16[40] = permKey16[56];
	assign subKey16[41] = permKey16[34];
	assign subKey16[42] = permKey16[53];
	assign subKey16[43] = permKey16[46];
	assign subKey16[44] = permKey16[42];
	assign subKey16[45] = permKey16[50];
	assign subKey16[46] = permKey16[36];
	assign subKey16[47] = permKey16[29];
	assign subKey16[48] = permKey16[32];
	
endmodule

module round(	input [1:32] dataLeft, dataRight,
				input [1:48] subKey,
				output [1:32] newDataLeft, newDataRight);

	wire [1:32] fOut;			
				
	feistel feistel(dataRight, subKey, fOut);			
				
	assign newDataLeft = dataRight;
	assign newDataRight = dataLeft ^ fOut;

endmodule

module feistel(	input [1:32] dataRight,
				input [1:48] subKey,
				output [1:32] fOut);
	
	wire [1:48] dataRightExp;
	wire [1:48] dataXorSubKey;
	wire [1:32] sOut;
	
	assign dataRightExp[1] = dataRight[32];
	assign dataRightExp[2] = dataRight[1];
	assign dataRightExp[3] = dataRight[2];
	assign dataRightExp[4] = dataRight[3];
	assign dataRightExp[5] = dataRight[4];
	assign dataRightExp[6] = dataRight[5];
	assign dataRightExp[7] = dataRight[4];
	assign dataRightExp[8] = dataRight[5];
	assign dataRightExp[9] = dataRight[6];
	assign dataRightExp[10] = dataRight[7];
	assign dataRightExp[11] = dataRight[8];
	assign dataRightExp[12] = dataRight[9];
	assign dataRightExp[13] = dataRight[8];
	assign dataRightExp[14] = dataRight[9];
	assign dataRightExp[15] = dataRight[10];
	assign dataRightExp[16] = dataRight[11];
	assign dataRightExp[17] = dataRight[12];
	assign dataRightExp[18] = dataRight[13];
	assign dataRightExp[19] = dataRight[12];
	assign dataRightExp[20] = dataRight[13];
	assign dataRightExp[21] = dataRight[14];
	assign dataRightExp[22] = dataRight[15];
	assign dataRightExp[23] = dataRight[16];
	assign dataRightExp[24] = dataRight[17];
	assign dataRightExp[25] = dataRight[16];
	assign dataRightExp[26] = dataRight[17];
	assign dataRightExp[27] = dataRight[18];
	assign dataRightExp[28] = dataRight[19];
	assign dataRightExp[29] = dataRight[20];
	assign dataRightExp[30] = dataRight[21];
	assign dataRightExp[31] = dataRight[20];
	assign dataRightExp[32] = dataRight[21];
	assign dataRightExp[33] = dataRight[22];
	assign dataRightExp[34] = dataRight[23];
	assign dataRightExp[35] = dataRight[24];
	assign dataRightExp[36] = dataRight[25];
	assign dataRightExp[37] = dataRight[24];
	assign dataRightExp[38] = dataRight[25];
	assign dataRightExp[39] = dataRight[26];
	assign dataRightExp[40] = dataRight[27];
	assign dataRightExp[41] = dataRight[28];
	assign dataRightExp[42] = dataRight[29];
	assign dataRightExp[43] = dataRight[28];
	assign dataRightExp[44] = dataRight[29];
	assign dataRightExp[45] = dataRight[30];
	assign dataRightExp[46] = dataRight[31];
	assign dataRightExp[47] = dataRight[32];
	assign dataRightExp[48] = dataRight[1];			
	
	assign dataXorSubKey = dataRightExp ^ subKey;
	
	sbox1 sbox1(dataXorSubKey[1:6], sOut[1:4]);
	sbox2 sbox2(dataXorSubKey[7:12], sOut[5:8]);
	sbox3 sbox3(dataXorSubKey[13:18], sOut[9:12]);
	sbox4 sbox4(dataXorSubKey[19:24], sOut[13:16]);
	sbox5 sbox5(dataXorSubKey[25:30], sOut[17:20]);
	sbox6 sbox6(dataXorSubKey[31:36], sOut[21:24]);
	sbox7 sbox7(dataXorSubKey[37:42], sOut[25:28]);
	sbox8 sbox8(dataXorSubKey[43:48], sOut[29:32]);
	
	assign fOut[1] = sOut[16];
	assign fOut[2] = sOut[7];
	assign fOut[3] = sOut[20];
	assign fOut[4] = sOut[21];
	assign fOut[5] = sOut[29];
	assign fOut[6] = sOut[12];
	assign fOut[7] = sOut[28];
	assign fOut[8] = sOut[17];
	assign fOut[9] = sOut[1];
	assign fOut[10] = sOut[15];
	assign fOut[11] = sOut[23];
	assign fOut[12] = sOut[26];
	assign fOut[13] = sOut[5];
	assign fOut[14] = sOut[18];
	assign fOut[15] = sOut[31];
	assign fOut[16] = sOut[10];
	assign fOut[17] = sOut[2];
	assign fOut[18] = sOut[8];
	assign fOut[19] = sOut[24];
	assign fOut[20] = sOut[14];
	assign fOut[21] = sOut[32];
	assign fOut[22] = sOut[27];
	assign fOut[23] = sOut[3];
	assign fOut[24] = sOut[9];
	assign fOut[25] = sOut[19];
	assign fOut[26] = sOut[13];
	assign fOut[27] = sOut[30];
	assign fOut[28] = sOut[6];
	assign fOut[29] = sOut[22];
	assign fOut[30] = sOut[11];
	assign fOut[31] = sOut[4];
	assign fOut[32] = sOut[25];
				
endmodule

module sbox1(	input [1:6] in1,
				output [1:4] out1);
	
	wire [0:255] sbox1 = {	4'd14, 4'd4, 4'd13, 4'd1, 4'd2, 4'd15, 4'd11, 4'd8, 4'd3, 4'd10, 4'd6, 4'd12, 4'd5, 4'd9, 4'd0, 4'd7,
							4'd0, 4'd15, 4'd7, 4'd4, 4'd14, 4'd2, 4'd13, 4'd1, 4'd10, 4'd6, 4'd12, 4'd11, 4'd9, 4'd5, 4'd3, 4'd8,
							4'd4, 4'd1, 4'd14, 4'd8, 4'd13, 4'd6, 4'd2, 4'd11, 4'd15, 4'd12, 4'd9, 4'd7, 4'd3, 4'd10, 4'd5, 4'd0,
							4'd15, 4'd12, 4'd8, 4'd2, 4'd4, 4'd9, 4'd1, 4'd7, 4'd5, 4'd11, 4'd3, 4'd14, 4'd10, 4'd0, 4'd6, 4'd13};
	
	wire [0:1] row;
	wire [0:3] column;
	
	assign row = {in1[1], in1[6]};
	assign column = in1[2:5];
	
	assign out1 = sbox1[column * 4 + row * 64 +: 4];
	
endmodule

module sbox2(	input [1:6] in2,
				output [1:4] out2);
				
	wire [0:255] sbox2 = {	4'd15, 4'd1, 4'd8, 4'd14, 4'd6, 4'd11, 4'd3, 4'd4, 4'd9, 4'd7, 4'd2, 4'd13, 4'd12, 4'd0, 4'd5, 4'd10,
							4'd3, 4'd13, 4'd4, 4'd7, 4'd15, 4'd2, 4'd8, 4'd14, 4'd12, 4'd0, 4'd1, 4'd10, 4'd6, 4'd9, 4'd11, 4'd5,
							4'd0, 4'd14, 4'd7, 4'd11, 4'd10, 4'd4, 4'd13, 4'd1, 4'd5, 4'd8, 4'd12, 4'd6, 4'd9, 4'd3, 4'd2, 4'd15,
							4'd13, 4'd8, 4'd10, 4'd1, 4'd3, 4'd15, 4'd4, 4'd2, 4'd11, 4'd6, 4'd7, 4'd12, 4'd0, 4'd5, 4'd14, 4'd9};
	
	wire [0:1] row;
	wire [0:3] column;
	
	assign row = {in2[1], in2[6]};
	assign column = in2[2:5];
	
	assign out2 = sbox2[column * 4 + row * 64 +: 4];
	
endmodule

module sbox3(	input [1:6] in3,
				output [1:4] out3);
				
	wire [0:255] sbox3 = {	4'd10, 4'd0, 4'd9, 4'd14, 4'd6, 4'd3, 4'd15, 4'd5, 4'd1, 4'd13, 4'd12, 4'd7, 4'd11, 4'd4, 4'd2, 4'd8,
							4'd13, 4'd7, 4'd0, 4'd9, 4'd3, 4'd4, 4'd6, 4'd10, 4'd2, 4'd8, 4'd5, 4'd14, 4'd12, 4'd11, 4'd15, 4'd1,
							4'd13, 4'd6, 4'd4, 4'd9, 4'd8, 4'd15, 4'd3, 4'd0, 4'd11, 4'd1, 4'd2, 4'd12, 4'd5, 4'd10, 4'd14, 4'd7,
							4'd1, 4'd10, 4'd13, 4'd0, 4'd6, 4'd9, 4'd8, 4'd7, 4'd4, 4'd15, 4'd14, 4'd3, 4'd11, 4'd5, 4'd2, 4'd12};
	
	wire [0:1] row;
	wire [0:3] column;
	
	assign row = {in3[1], in3[6]};
	assign column = in3[2:5];
	
	assign out3 = sbox3[column * 4 + row * 64 +: 4];
	
endmodule

module sbox4(	input [1:6] in4,
				output [1:4] out4);
				
	wire [0:255] sbox4 = {	4'd7, 4'd13, 4'd14, 4'd3, 4'd0, 4'd6, 4'd9, 4'd10, 4'd1, 4'd2, 4'd8, 4'd5, 4'd11, 4'd12, 4'd4, 4'd15,
							4'd13, 4'd8, 4'd11, 4'd5, 4'd6, 4'd15, 4'd0, 4'd3, 4'd4, 4'd7, 4'd2, 4'd12, 4'd1, 4'd10, 4'd14, 4'd9,
							4'd10, 4'd6, 4'd9, 4'd0, 4'd12, 4'd11, 4'd7, 4'd13, 4'd15, 4'd1, 4'd3, 4'd14, 4'd5, 4'd2, 4'd8, 4'd4,
							4'd3, 4'd15, 4'd0, 4'd6, 4'd10, 4'd1, 4'd13, 4'd8, 4'd9, 4'd4, 4'd5, 4'd11, 4'd12, 4'd7, 4'd2, 4'd14};
	
	wire [0:1] row;
	wire [0:3] column;
	
	assign row = {in4[1], in4[6]};
	assign column = in4[2:5];
	
	assign out4 = sbox4[column * 4 + row * 64 +: 4];
	
endmodule

module sbox5(	input [1:6] in5,
				output [1:4] out5);
				
	wire [0:255] sbox5 = {	4'd2, 4'd12, 4'd4, 4'd1, 4'd7, 4'd10, 4'd11, 4'd6, 4'd8, 4'd5, 4'd3, 4'd15, 4'd13, 4'd0, 4'd14, 4'd9,
							4'd14, 4'd11, 4'd2, 4'd12, 4'd4, 4'd7, 4'd13, 4'd1, 4'd5, 4'd0, 4'd15, 4'd10, 4'd3, 4'd9, 4'd8, 4'd6,
							4'd4, 4'd2, 4'd1, 4'd11, 4'd10, 4'd13, 4'd7, 4'd8, 4'd15, 4'd9, 4'd12, 4'd5, 4'd6, 4'd3, 4'd0, 4'd14,
							4'd11, 4'd8, 4'd12, 4'd7, 4'd1, 4'd14, 4'd2, 4'd13, 4'd6, 4'd15, 4'd0, 4'd9, 4'd10, 4'd4, 4'd5, 4'd3};
	
	wire [0:1] row;
	wire [0:3] column;
	
	assign row = {in5[1], in5[6]};
	assign column = in5[2:5];
	
	assign out5 = sbox5[column * 4 + row * 64 +: 4];
	
endmodule

module sbox6(	input [1:6] in6,
				output [1:4] out6);
				
	wire [0:255] sbox6 = {	4'd12, 4'd1, 4'd10, 4'd15, 4'd9, 4'd2, 4'd6, 4'd8, 4'd0, 4'd13, 4'd3, 4'd4, 4'd14, 4'd7, 4'd5, 4'd11,
							4'd10, 4'd15, 4'd4, 4'd2, 4'd7, 4'd12, 4'd9, 4'd5, 4'd6, 4'd1, 4'd13, 4'd14, 4'd0, 4'd11, 4'd3, 4'd8,
							4'd9, 4'd14, 4'd15, 4'd5, 4'd2, 4'd8, 4'd12, 4'd3, 4'd7, 4'd0, 4'd4, 4'd10, 4'd1, 4'd13, 4'd11, 4'd6,
							4'd4, 4'd3, 4'd2, 4'd12, 4'd9, 4'd5, 4'd15, 4'd10, 4'd11, 4'd14, 4'd1, 4'd7, 4'd6, 4'd0, 4'd8, 4'd13};
	
	wire [0:1] row;
	wire [0:3] column;
	
	assign row = {in6[1], in6[6]};
	assign column = in6[2:5];
	
	assign out6 = sbox6[column * 4 + row * 64 +: 4];
		
endmodule

module sbox7(	input [1:6] in7,
				output [1:4] out7);
				
	wire [0:255] sbox7 = {	4'd4, 4'd11, 4'd2, 4'd14, 4'd15, 4'd0, 4'd8, 4'd13, 4'd3, 4'd12, 4'd9, 4'd7, 4'd5, 4'd10, 4'd6, 4'd1,
							4'd13, 4'd0, 4'd11, 4'd7, 4'd4, 4'd9, 4'd1, 4'd10, 4'd14, 4'd3, 4'd5, 4'd12, 4'd2, 4'd15, 4'd8, 4'd6,
							4'd1, 4'd4, 4'd11, 4'd13, 4'd12, 4'd3, 4'd7, 4'd14, 4'd10, 4'd15, 4'd6, 4'd8, 4'd0, 4'd5, 4'd9, 4'd2,
							4'd6, 4'd11, 4'd13, 4'd8, 4'd1, 4'd4, 4'd10, 4'd7, 4'd9, 4'd5, 4'd0, 4'd15, 4'd14, 4'd2, 4'd3, 4'd12};
		
	wire [0:1] row;
	wire [0:3] column;
	
	assign row = {in7[1], in7[6]};
	assign column = in7[2:5];
	
	assign out7 = sbox7[column * 4 + row * 64 +: 4];
		
endmodule

module sbox8(	input [1:6] in8,
				output [1:4] out8);
				
	wire [0:255] sbox8 = {	4'd13, 4'd2, 4'd8, 4'd4, 4'd6, 4'd15, 4'd11, 4'd1, 4'd10, 4'd9, 4'd3, 4'd14, 4'd5, 4'd0, 4'd12, 4'd7,
							4'd1, 4'd15, 4'd13, 4'd8, 4'd10, 4'd3, 4'd7, 4'd4, 4'd12, 4'd5, 4'd6, 4'd11, 4'd0, 4'd14, 4'd9, 4'd2,
							4'd7, 4'd11, 4'd4, 4'd1, 4'd9, 4'd12, 4'd14, 4'd2, 4'd0, 4'd6, 4'd10, 4'd13, 4'd15, 4'd3, 4'd5, 4'd8,
							4'd2, 4'd1, 4'd14, 4'd7, 4'd4, 4'd10, 4'd8, 4'd13, 4'd15, 4'd12, 4'd9, 4'd0, 4'd3, 4'd5, 4'd6, 4'd11};
			
	wire [0:1] row;
	wire [0:3] column;
	
	assign row = {in8[1], in8[6]};
	assign column = in8[2:5];
	
	assign out8 = sbox8[column * 4 + row * 64 +: 4];
			
endmodule

module hex7seg(	input [0:3]			hex,
				output reg [6:0]	seg7);
				
	always @ (*)
		case(hex)
			4'h0:	seg7 <= 7'b1000000;
			4'h1:	seg7 <= 7'b1111001;
			4'h2:	seg7 <= 7'b0100100;
			4'h3:	seg7 <= 7'b0110000;
			4'h4:	seg7 <= 7'b0011001;
			4'h5:	seg7 <= 7'b0010010;
			4'h6:	seg7 <= 7'b0000010;
			4'h7:	seg7 <= 7'b1111000;
			4'h8:	seg7 <= 7'b0000000;
			4'h9:	seg7 <= 7'b0011000;
			4'ha:	seg7 <= 7'b0001000;
			4'hb:	seg7 <= 7'b0000011;
			4'hc:	seg7 <= 7'b0100111;
			4'hd:	seg7 <= 7'b0100001;
			4'he:	seg7 <= 7'b0000110;
			4'hf:	seg7 <= 7'b0001110;
		endcase
				
endmodule