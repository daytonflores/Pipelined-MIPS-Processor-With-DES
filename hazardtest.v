module hazardtest();

	reg clk, reset;
	
	reg 			branch_D;					// branch control for instr in D
	reg		[4:0]	rs_D, rt_D;					// source/target reg of instr in D
	reg		[4:0]	rs_E, rt_E;					// source/target reg of instr in D
	reg		[4:0]	writereg_E;					// reg that data will be written to for instr in E
	reg 			memtoreg_E;					// low when non-LW for instr in E
	reg				regwrite_E;					// low when SW/BEQ/J for instr in E
	reg		[4:0]	writereg_M;					// reg that data will be written to for instr in M
	reg				memtoreg_M;					// low when non-LW for instr in M
	reg				regwrite_M;					// low when SW/BEQ/J for instr in M
	reg		[4:0]	writereg_W;					// reg that data will be written to for instr in W
	reg				regwrite_W;					// low when SW/BEQ/J for instr in W
	
	reg				stall_F_expected;			// hold instr in PC reg
	reg				stall_D_expected;			// hold instr in D reg
	reg 			forwardA_D_expected;		// select bits for srcA_D
	reg				forwardB_D_expected;		// select bits for srcB_D
	reg				flush_E_expected;			// clear instr in E reg
	reg		[1:0]	forwardA_E_expected;		// select bits for srcA_E
	reg		[1:0]	forwardB_E_expected;		// select bits for srcB_E 
	
	wire			stall_F;					// hold instr in PC reg
	wire			stall_D;					// hold instr in D reg
	wire 			forwardA_D;					// select bits for srcA_D
	wire			forwardB_D;					// select bits for srcB_D
	wire			flush_E;					// clear instr in E reg
	wire	[1:0]	forwardA_E;					// select bits for srcA_E
	wire	[1:0]	forwardB_E;					// select bits for srcB_E 
	
	reg 	[31:0]	vectornum, errors;
	reg		[49:0]	testvectors[10000:0];
	
	hazardunit example(	branch_D,				// input to be tested
						rs_D, rt_D,				// input to be tested
						rs_E, rt_E,				// input to be tested
						writereg_E,				// input to be tested
						memtoreg_E,				// input to be tested
						regwrite_E,				// input to be tested
						writereg_M,				// input to be tested
						memtoreg_M,				// input to be tested
						regwrite_M,				// input to be tested
						writereg_W,				// input to be tested
						regwrite_W,				// input to be tested
						stall_F,				// output to be compared
						stall_D,				// output to be compared
						forwardA_D, forwardB_D,	// output to be compared
						flush_E,				// output to be compared
						forwardA_E, forwardB_E	// output to be compared
						);

	always
		begin
			clk = 1; 
			#5;
			clk = 0; 
			#5;
		end
	
	initial
		begin
			$readmemb("example.tv", testvectors);
			vectornum = 0;
			errors = 0;
			reset = 1;
			#50;
			reset = 0;
		end
	
	always @ (posedge clk)
		begin
			#1;
			{	branch_D,				// input to be tested
				rs_D, rt_D,				// input to be tested
				rs_E, rt_E,				// input to be tested
				writereg_E,				// input to be tested
				memtoreg_E,				// input to be tested
				regwrite_E,				// input to be tested
				writereg_M,				// input to be tested
				memtoreg_M,				// input to be tested
				regwrite_M,				// input to be tested
				writereg_W,				// input to be tested
				regwrite_W,				// input to be tested
				stall_F_expected,		// output to be compared to
				stall_D_expected,		// output to be compared to
				forwardA_D_expected, 	// output to be compared to
				forwardB_D_expected,	// output to be compared to
				flush_E_expected,		// output to be compared to
				forwardA_E_expected, 	// output to be compared to
				forwardB_E_expected		// output to be compared to
			} = testvectors[vectornum];
		end
		
	always @ (negedge clk)
    if (~reset)
		begin 									// skip cycles during reset
			if	(	
					{	stall_F,				// output to be compared
						stall_D,				// output to be compared
						forwardA_D, forwardB_D,	// output to be compared
						flush_E,				// output to be compared
						forwardA_E, forwardB_E	// output to be compared
						} !==
					{	stall_F_expected,		// output to be compared to
						stall_D_expected,		// output to be compared to
						forwardA_D_expected, 	// output to be compared to
						forwardB_D_expected,	// output to be compared to
						flush_E_expected,		// output to be compared to
						forwardA_E_expected, 	// output to be compared to
						forwardB_E_expected		// output to be compared to
						}
					)
				begin  							// check result
					$display(	"Error in Test %d:	Inputs = %b",
								vectornum,
								{	branch_D,				// input to be tested
									rs_D, rt_D,				// input to be tested
									rs_E, rt_E,				// input to be tested
									writereg_E,				// input to be tested
									memtoreg_E,				// input to be tested
									regwrite_E,				// input to be tested
									writereg_M,				// input to be tested
									memtoreg_M,				// input to be tested
									regwrite_M,				// input to be tested
									writereg_W,				// input to be tested
									regwrite_W				// input to be tested
									});
					$display(	"				Outputs = %b (%b expected)",
								{	stall_F,				// output to be compared
									stall_D,				// output to be compared
									forwardA_D, forwardB_D,	// output to be compared
									flush_E,				// output to be compared
									forwardA_E, forwardB_E	// output to be compared
									},
								{	stall_F_expected,		// output to be compared to
									stall_D_expected,		// output to be compared to
									forwardA_D_expected, 	// output to be compared to
									forwardB_D_expected,	// output to be compared to
									flush_E_expected,		// output to be compared to
									forwardA_E_expected, 	// output to be compared to
									forwardB_E_expected		// output to be compared to
									});
					errors = errors + 1;
				end
			else
				begin
					$display(	"CORRECT: Test %d",
								vectornum);
				end
			vectornum = vectornum + 1;
			if (testvectors[vectornum] === 50'bx)
				begin 
					$display(	"%d tests completed with %d errors", 
								vectornum, errors);
					$finish;
				end
		end
	
endmodule						

/*
example.tv

0_11111_00000_00000_11111_00000_1_0_00000_0_0_00000_0___1_1_0_0_1_00_00		// rs_D = rs_E, memtoreg_E = 1: expect load hazard (STALL)
0_00000_11111_00000_11111_00000_1_0_00000_0_0_00000_0___1_1_0_0_1_00_00		// rt_D = rs_E, memtoreg_E = 1: expect load hazard (STALL)
1_11111_00000_00000_00000_11111_0_1_00000_0_0_00000_0___1_1_0_0_1_00_00		// branchD = 1, rs_D = writereg_E, regwrite_E = 1: expect branch data hazard (STALL)
1_00000_11111_00000_00000_11111_0_1_00000_0_0_00000_0___1_1_0_0_1_00_00		// branchD = 1, rt_D = writereg_E, regwrite_E = 1: expect branch data hazard (STALL)
1_11111_00000_00000_00000_00000_0_0_11111_1_0_00000_0___1_1_0_0_1_00_00		// branchD = 1, rs_D = writereg_M, memtoreg_M = 1: expect branch control hazard (STALL)
1_00000_11111_00000_00000_00000_0_0_11111_1_0_00000_0___1_1_0_0_1_00_00		// branchD = 1, rt_D = writereg_M, memtoreg_M = 1: expect branch control hazard (STALL)
0_11111_00000_00000_00000_00000_0_0_11111_0_1_00000_0___0_0_1_0_0_00_00		// rs_D != 0, rs_D = writereg_M, regwrite_M = 1: expect srcA_D RAW hazard (FORWARD A_D)
0_00000_11111_00000_00000_00000_0_0_11111_0_1_00000_0___0_0_0_1_0_00_00		// rt_D != 0, rt_D = writereg_M, regwrite_M = 1: expect srcB_D RAW hazard (FORWARD B_D)
0_00000_00000_11111_00000_00000_0_0_11111_0_1_00000_0___0_0_0_0_0_10_00		// rs_E != 0, rs_E = writereg_M, regwrite_M = 1: expect srcA_E RAW hazard (FORWARD A_E)
0_00000_00000_11111_00000_00000_0_0_00000_0_0_11111_1___0_0_0_0_0_01_00		// rs_E != 0, rs_E = writereg_W, regwrite_W = 1: expect srcA_E RAW hazard (FORWARD A_E)
0_00000_00000_00000_11111_00000_0_0_11111_0_1_00000_0___0_0_0_0_0_00_10		// rt_E != 0, rt_E = writereg_M, regwrite_M = 1: expect srcB_E RAW hazard (FORWARD B_E)
0_00000_00000_00000_11111_00000_0_0_00000_0_0_11111_1___0_0_0_0_0_00_01		// rt_E != 0, rt_E = writereg_W, regwrite_W = 1: expect srcB_E RAW hazard (FORWARD B_E)
0_10101_00000_00000_01010_00000_1_0_00000_0_0_00000_0___0_0_0_0_0_00_00		// rs_D != rs_E, memtoreg_E = 1: NO HAZARD
0_11111_00000_00000_11111_00000_0_0_00000_0_0_00000_0___0_0_0_0_0_00_00		// rs_D = rs_E, memtoreg_E != 1: NO HAZARD
0_11111_00000_00000_00000_11111_0_1_00000_0_0_00000_0___0_0_0_0_0_00_00		// branchD != 1, rs_D = writereg_E, regwrite_E = 1: NO HAZARD
1_10101_00000_00000_00000_01010_0_1_00000_0_0_00000_0___0_0_0_0_0_00_00		// branchD = 1, rs_D != writereg_E, regwrite_E = 1: NO HAZARD
1_11111_00000_00000_00000_11111_0_0_00000_0_0_00000_0___0_0_0_0_0_00_00		// branchD = 1, rs_D = writereg_E, regwrite_E != 1: NO HAZARD
0_00000_11111_00000_00000_11111_0_1_00000_0_0_00000_0___0_0_0_0_0_00_00		// branchD != 1, rt_D = writereg_E, regwrite_E = 1: NO HAZARD
1_00000_10101_00000_00000_01010_0_1_00000_0_0_00000_0___0_0_0_0_0_00_00		// branchD = 1, rt_D != writereg_E, regwrite_E = 1: NO HAZARD
1_00000_11111_00000_00000_11111_0_0_00000_0_0_00000_0___0_0_0_0_0_00_00		// branchD = 1, rt_D = writereg_E, regwrite_E != 1: NO HAZARD
0_11111_00000_00000_00000_00000_0_0_11111_1_0_00000_0___0_0_0_0_0_00_00		// branchD != 1, rs_D = writereg_M, memtoreg_M = 1: NO HAZARD
1_10101_00000_00000_00000_00000_0_0_01010_1_0_00000_0___0_0_0_0_0_00_00		// branchD = 1, rs_D != writereg_M, memtoreg_M = 1: NO HAZARD
1_11111_00000_00000_00000_00000_0_0_11111_0_0_00000_0___0_0_0_0_0_00_00		// branchD = 1, rs_D = writereg_M, memtoreg_M != 1: NO HAZARD
0_00000_11111_00000_00000_00000_0_0_11111_1_0_00000_0___0_0_0_0_0_00_00		// branchD != 1, rt_D = writereg_M, memtoreg_M = 1: NO HAZARD
1_00000_10101_00000_00000_00000_0_0_01010_1_0_00000_0___0_0_0_0_0_00_00		// branchD = 1, rt_D != writereg_M, memtoreg_M = 1: NO HAZARD
1_00000_11111_00000_00000_00000_0_0_11111_0_0_00000_0___0_0_0_0_0_00_00		// branchD = 1, rt_D = writereg_M, memtoreg_M != 1: NO HAZARD
0_00000_00000_00000_00000_00000_0_0_11111_0_1_00000_0___0_0_0_0_0_00_00		// rs_D = 0, rs_D = writereg_M, regwrite_M = 1: NO HAZARD
0_10101_00000_00000_00000_00000_0_0_01010_0_1_00000_0___0_0_0_0_0_00_00		// rs_D != 0, rs_D != writereg_M, regwrite_M = 1: NO HAZARD
0_11111_00000_00000_00000_00000_0_0_11111_0_0_00000_0___0_0_0_0_0_00_00		// rs_D != 0, rs_D = writereg_M, regwrite_M != 1: NO HAZARD
0_00000_00000_00000_00000_00000_0_0_11111_0_1_00000_0___0_0_0_0_0_00_00		// rt_D = 0, rt_D = writereg_M, regwrite_M = 1: NO HAZARD
0_00000_10101_00000_00000_00000_0_0_01010_0_1_00000_0___0_0_0_0_0_00_00		// rt_D != 0, rt_D != writereg_M, regwrite_M = 1: NO HAZARD
0_00000_11111_00000_00000_00000_0_0_11111_0_0_00000_0___0_0_0_0_0_00_00		// rt_D != 0, rt_D = writereg_M, regwrite_M != 1: NO HAZARD
0_00000_00000_00000_00000_00000_0_0_11111_0_1_00000_0___0_0_0_0_0_00_00		// rs_E = 0, rs_E = writereg_M, regwrite_M = 1: NO HAZARD
0_00000_00000_10101_00000_00000_0_0_01010_0_1_00000_0___0_0_0_0_0_00_00		// rs_E != 0, rs_E != writereg_M, regwrite_M = 1: NO HAZARD
0_00000_00000_11111_00000_00000_0_0_11111_0_0_00000_0___0_0_0_0_0_00_00		// rs_E != 0, rs_E = writereg_M, regwrite_M != 1: NO HAZARD
0_00000_00000_00000_00000_00000_0_0_00000_0_0_11111_1___0_0_0_0_0_00_00		// rs_E = 0, rs_E = writereg_W, regwrite_W = 1: NO HAZARD
0_00000_00000_10101_00000_00000_0_0_00000_0_0_01010_1___0_0_0_0_0_00_00		// rs_E != 0, rs_E != writereg_W, regwrite_W = 1: NO HAZARD
0_00000_00000_11111_00000_00000_0_0_00000_0_0_11111_0___0_0_0_0_0_00_00		// rs_E != 0, rs_E = writereg_W, regwrite_W != 1: NO HAZARD
0_00000_00000_00000_00000_00000_0_0_11111_0_1_00000_0___0_0_0_0_0_00_00		// rt_E = 0, rt_E = writereg_M, regwrite_M = 1: NO HAZARD
0_00000_00000_00000_10101_00000_0_0_01010_0_1_00000_0___0_0_0_0_0_00_00		// rt_E != 0, rt_E != writereg_M, regwrite_M = 1: NO HAZARD
0_00000_00000_00000_11111_00000_0_0_11111_0_0_00000_0___0_0_0_0_0_00_00		// rt_E != 0, rt_E = writereg_M, regwrite_M != 1: NO HAZARD
0_00000_00000_00000_00000_00000_0_0_00000_0_0_11111_1___0_0_0_0_0_00_00		// rt_E = 0, rt_E = writereg_W, regwrite_W = 1: NO HAZARD
0_00000_00000_00000_10101_00000_0_0_00000_0_0_01010_1___0_0_0_0_0_00_00		// rt_E != 0, rt_E != writereg_W, regwrite_W = 1: NO HAZARD
0_00000_00000_00000_11111_00000_0_0_00000_0_0_11111_0___0_0_0_0_0_00_00		// rt_E != 0, rt_E = writereg_W, regwrite_W != 1: NO HAZARD
*/