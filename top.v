module top(	input         	CLOCK_50,				// on-board 50 MHz clk from DE2-115
			input [3:0]		KEY,					// push-buttons on DE2-115
			input [17:0]	SW,
			output			memwrite_M,				// write enable to dmem in M or red LEDs on DE2-115
			output [31:0]	aluout_M,				// 32-bit address to access in dmem in M or memory-mapped I/Os
			output [31:0] 	writedata_M,			// 32-bit data to be written to dmem in M or memory-mapped I/Os
			output [31:0] 	result_W, 				// 32-bit result in W
			output [17:0] 	LEDR,					// red LEDs on DE2-115
			output [6:0]	HEX0,
			output [6:0]	HEX1,
			output [6:0]	HEX2,
			output [6:0]	HEX3,
			output [6:0]	HEX4,
			output [6:0]	HEX5,
			output [6:0]	HEX6,
			output [6:0]	HEX7
			);
					
	wire WEDM;									// write enable to dmem
	wire WEUK;									// write enable to upper DES key
	wire WELK;									// write enable to lower DES key
	wire WEUD;									// write enable to upper DES data
	wire WELD;									// write enable to lower DES data
	wire encOrDec;								// set for DES encoding, clear for DES decoding
	wire [1:0] RDsel;							// select bits for readdata_M
	wire [31:0] pc_F;							// 32-bit pc in F
	wire [31:0] instr_F;						// 32-bit instr in F
	wire [31:0] dmem_M;							// 32-bit data read from dmem in M
	wire [31:0]	readdata_M;						// 32-bit output data from mux in M
	wire [31:0] UKout;							// 32-bit output from upper DES key register
	wire [31:0] LKout;							// 32-bit output from lower DES key register
	wire [31:0] UDout;							// 32-bit output from upper DES data register
	wire [31:0] LDout;							// 32-bit output from lower DES data register
	wire [63:0] DESout;							// 64-bit output from DES
  
	mipspipeline mipspipeline(	CLOCK_50, 		// on-board 50 MHz clk from DE2-115
								~KEY[0], 		// input reset (push-button[0] on DE2-115)
								instr_F, 		// 32-bit instr in F
								readdata_M,		// 32-bit output data from memory mux
								pc_F,			// 32-bit pc in F
								memwrite_M,  	// 1 if SW in M
								aluout_M, 		// 32-bit address to access in dmem in M or memory-mapped I/Os
								writedata_M, 	// 32-bit data to be written to dmem in M or memory-mapped I/Os
								result_W		// 32-bit result in W
								);
	
	imem imem(	pc_F[7:2],						// upper 6 bits of 8-bit pc_F (word aligned) 	
				instr_F							// read 32-bit instr from imem
				);
	
	addrdec addrdec(	memwrite_M,				// 1 if SW in M
						aluout_M,				// 32-bit address to access in dmem in M or memory-mapped I/Os
						WEDM,					// write enable to dmem
						WEUK,					// write enable to upper DES key
						WELK,					// write enable to lower DES key
						WEUD,					// write enable to upper DES data
						WELD,					// write enable to lower DES data
						RDsel					// select bits for readdata_M
						);
	
	dmem dmem(	CLOCK_50, 						// on-board 50 MHz clk from DE2-115
				WEDM, 							// write enable to dmem
				aluout_M, 						// 32-bit address to access in dmem
				writedata_M, 					// 32-bit data to be written to dmem
				dmem_M							// 32-bit data read from dmem
				);
	
	flopenr #(32) UK(	CLOCK_50,				// on-board 50 MHz clk from DE2-115
						~KEY[0],				// input reset (push-button[0] on DE2-115)
						WEUK,					// write enable to upper DES key
						writedata_M,			// 32-bit key to be written to upper DES key register
						UKout					// 32-bit output from upper DES key register
						);
	
	flopenr #(32) LK(	CLOCK_50,				// on-board 50 MHz clk from DE2-115
						~KEY[0],				// input reset (push-button[0] on DE2-115)
						WELK,					// write enable to lower DES key
						writedata_M,			// 32-bit key to be written to lower DES key register
						LKout					// 32-bit output from lower DES key register
						);
						
	flopenr #(32) UD(	CLOCK_50,				// on-board 50 MHz clk from DE2-115
						~KEY[0],				// input reset (push-button[0] on DE2-115)
						WEUD,					// write enable to upper DES data
						writedata_M,			// 32-bit key to be written to upper DES data register
						UDout					// 32-bit output from upper DES data register
						);
						
	flopenr #(32) LD(	CLOCK_50,				// on-board 50 MHz clk from DE2-115
						~KEY[0],				// input reset (push-button[0] on DE2-115)
						WELD,					// write enable to lower DES data
						writedata_M,			// 32-bit key to be written to lower DES data register
						LDout					// 32-bit output from lower DES data register
						);
	
	des des(	SW[17],							// set for DES encoding, clear for DES decoding
				UKout,							// 32-bit output from upper DES key register
				LKout,							// 32-bit output from lower DES key register
				UDout,							// 32-bit output from upper DES data register
				LDout,							// 32-bit output from lower DES data register
				DESout,							// 64-bit output from DES
				HEX0,
				HEX1,
				HEX2,
				HEX3,
				HEX4,
				HEX5,
				HEX6,
				HEX7
				);
	
	mux3 #(32) readsel(	dmem_M,					// 00: 32-bit data read from dmem
						DESout[63:32],			// 01: lower 32-bits of output from DES
						DESout[31:0],			// 10: upper 32-bits of output from DES
						RDsel,					// select bits for readdata_M
						readdata_M				// 32-bit output data from memory mux
						);
	
endmodule

