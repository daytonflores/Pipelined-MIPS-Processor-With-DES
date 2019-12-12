// mipspipeline
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module mipspipeline(	input        	clk, 			// input clk
						input			reset,			// input reset
						input  [31:0]	instr_F,		// instr retrieved from imem in F
						input  [31:0]	readdata_M,		// 32-bit data read from dmem in M
						output [31:0] 	pc_F,			// program counter in F
						output        	memwrite_M,		// 1 if SW in M
						output [31:0]	aluout_M,		// 32-bit address to access in dmem in M
						output [31:0] 	writedata_M,	// 32-bit data to be written to dmem in M
						output [31:0] 	result_W 		// result of ALU/dmem in W
						);

	wire        memtoreg_D;							// 1 if LW in D
	wire 		memwrite_D;							// 1 if SW in D
	wire 		alusrc_D;  							// 1 if instr is I-type in D
	wire		regwrite_D;							// 0 if SW/BEQ/J in D
	wire		regdst_D;							// 1 if instr is R-type in D
	wire     	branch_D;							// 1 if BEQ in D
	wire		jump_D;								// 1 if J in D
	wire [3:0]  alucontrol_D;						// ALU control bits for instr in D
	wire		pcsrc_D;							// 1 if BEQ && BEQ is true in D
	wire [31:0]	instr_D;							// instr in D

	controller c(	instr_D[31:26],					// op of instr in D
					instr_D[5:0],					// funct of instr in D
					memtoreg_D,						// 1 if LW in D
					memwrite_D,						// 1 if SW in D
					alusrc_D, 						// 1 if instr is I-type in D
					regwrite_D, 					// 0 if SW/BEQ/J in D
					regdst_D,						// 1 if instr is R-type in D
					branch_D,						// 1 if BEQ in D
					jump_D,							// 1 if J in D
					alucontrol_D					// ALU control bits for instr in D
					);
					
	datapath dp(	clk, 							// input clk
					reset, 							// input reset
					instr_F,						// instr retrieved from imem
					memtoreg_D, 					// memtoreg for instr in D
					memwrite_D,						// memwrite for instr in D
					alusrc_D, 						// alusrc for instr in D
					regwrite_D, 					// regwrite for instr in D
					regdst_D,						// 1 if instr is R-type in D
					branch_D,						// 1 if BEQ in D
					jump_D,							// jump for instr in D
					alucontrol_D,					// ALU control bits for instr in D
					readdata_M,						// data read from dmem for instr in M
					pc_F, 							// pc in F
					pcsrc_D,						// pcsrc for instr in D
					instr_D,						// instr in D
					memwrite_M,						// 1 if SW in M
					aluout_M, 						// 32-bit address to access in dmem
					writedata_M, 					// 32-bit data to be written to dmem
					result_W	  					// result of ALU/dmem in W
					);  
				  
endmodule


// controller
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module controller(	input  [5:0] 	op,				// op of instr in D
					input  [5:0]	funct,			// funct of instr in D
					output       	memtoreg_D,		// 1 if LW in D
					output			memwrite_D,		// 1 if SW in D
					output 		 	alusrc_D,     	// 1 if instr in D is I-type
					output       	regwrite_D,		// 0 if SW/BEQ/J in D
					output			regdst_D,		// 1 if instr in D is R-type
					output      	branch_D,		// 1 if BEQ in D
					output       	jump_D,			// 1 if J in D
					output [3:0] 	alucontrol_D  	// ALU control bits for instr in D
					);
						
	wire [1:0] aluop_D;							// selects between add/sub/R-type for instr in D

	maindec md(	op, 							// op of instr in D
				memtoreg_D, 					// 1 if LW in D
				memwrite_D, 					// 1 if SW in D
				alusrc_D,  						// 1 if instr in D is I-type
				regwrite_D, 					// 0 if SW/BEQ/J in D
				regdst_D,						// 1 if instr in D is R-type
				branch_D,						// 1 if BEQ in D
				jump_D,							// 1 if J in D
				aluop_D 						// selects between add/sub/R-type for instr in D
				);
				
	aludec  ad(	funct,							// funct of instr in D
				aluop_D, 						// selects between add/sub/R-type for instr in D
				alucontrol_D					// ALU control bits for instr in D
				);
	
endmodule

// maindec
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module maindec(	input  [5:0]	op,			// op of instr in D
				output       	memtoreg_D, // 1 if LW in D
				output			memwrite_D,	// 1 if SW in D
				output 		 	alusrc_D,	// 1 if instr in D is I-type
				output       	regwrite_D,	// 0 if SW/BEQ/J in D
				output			regdst_D,	// 1 if instr in D is R-type
				output       	branch_D, 	// 1 if BEQ in D
				output       	jump_D,		// 1 if J in D
				output [1:0] 	aluop_D		// selects between add/sub/R-type for instr D
				);

	reg [8:0] controls;  				// concatenate outputs into 1 8-bit control signal
			
	assign {	memtoreg_D, 			// 1 if LW in D
				memwrite_D,				// 1 if SW in D
				alusrc_D,				// 1 if instr in D is I-type
				regwrite_D, 			// 0 if SW/BEQ/J in D
				regdst_D,				// 1 if instr in D is R-type
				branch_D, 				// 1 if BEQ in D
				jump_D, 				// 1 if J in D
				aluop_D					// selects between add/sub/R-type
				}
				= controls;

	always @ (*)
		case(op)
			6'b000000: controls <= 9'b0_0_0_1_1_0_0_10;		// R-type
			6'b100011: controls <= 9'b1_0_1_1_0_0_0_00; 	// LW
			6'b101011: controls <= 9'b0_1_1_0_0_0_0_00; 	// SW
			6'b001000: controls <= 9'b0_0_1_1_0_0_0_00; 	// ADDI
			6'b000100: controls <= 9'b0_0_0_0_0_1_0_00; 	// BEQ
			6'b000010: controls <= 9'b0_0_0_0_0_0_1_00; 	// J
			default:   controls <= 9'bx_x_x_x_x_x_x_xx; 	// ???
		endcase
		
endmodule

// aludec
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module aludec(	input      [5:0] 	funct,			// funct for instr in D
				input      [1:0] 	aluop_D,		// selects between add/sub/R-type for instr in D
				output reg [3:0] 	alucontrol_D	// ALU control bits for instr in D
				); 

	always @ (*)
		case(aluop_D)
			2'b00: alucontrol_D <= 4'b0010;  	// LW/SW/ADDI/BEQ/J (add)
			2'b01: alucontrol_D <= 4'b1010;  	// (sub)
			default: 							//
				case(funct)          			// R-type
					6'b100100: alucontrol_D <= 4'b0000; // AND
					6'b100101: alucontrol_D <= 4'b0001; // OR
					6'b100000: alucontrol_D <= 4'b0010; // ADD
					6'b100010: alucontrol_D <= 4'b1010; // SUB
					6'b101010: alucontrol_D <= 4'b1011; // SLT
					default:   alucontrol_D <= 4'bxxxx; // ???
				endcase
		endcase
		
endmodule

// datapath
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module datapath(	input    		clk,			// input clk
					input			reset,			// input reset
					input	[31:0]	instr_F,		// instr retrieved from imem in F
					input         	memtoreg_D, 	// memtoreg from instr in D
					input			memwrite_D,		// memwrite from instr in D
					input 		   	alusrc_D,    	// alusrc from instr in D
					input         	regwrite_D, 	// regwrite from instr in D
					input			regdst_D,		// regdst from instr in D
					input			branch_D,		// branch control from instr in D
					input			jump_D,			// jump control from instr in D
					input  	[3:0]  	alucontrol_D, 	// alucontrol from instr in D
					input	[31:0]	readdata_M,		// data read from dmem for instr in M
					output 	[31:0] 	pc_F,			// pc in F
					output			pcsrc_D,		// pcsrc from instr in D
					output  [31:0]	instr_D,		// instr in D
					output			memwrite_M,		// 1 if SW in M
					output 	[31:0]	aluout_M,		// 32-bit address to access in dmem in M
					output 	[31:0] 	writedata_M,	// 32-bit data to be written to dmem in M
					output 	[31:0] 	result_W		// result of ALU/dmem in W
					);  
	
	wire stall_F;								// hold instr in PC reg
	wire stall_D;								// hold instr in D reg
	wire forwardA_D;							// select bits for srcA_D
	wire forwardB_D;							// select bits for srcB_D
	wire flush_E;								// clear instr in E reg
	wire [1:0] forwardA_E;						// select bits for srcA_E
	wire [1:0] forwardB_E;						// select bits for srcB_E
	
	wire notstall_F;							// ~stall_F
	wire [31:0] pcprime_F;						// pcprime in F
	wire [31:0] pcplus4_F;						// pcplus4 in F
	wire [31:0] brtoj_F;						// connects brpcmux_F to jpcmux_F
	wire [31:0] pcj_F;							// pc for J in F
	
	wire reset_FD;								// pcsrc_D | reset
	wire notstall_D;							// ~stall_D
	wire equal_D;								// 1 when Eq1_D = Eq2_D
	wire [4:0] rs_D;							// source reg for instr in D
	wire [4:0] rt_D;							// target reg for instr in D
	wire [4:0] rd_D;							// dest reg for instr in D
	wire [31:0] pcplus4_D;						// pcplus4 in D
	wire [31:0] signimm_D;						// sign ext imm in D
	wire [31:0] shimm_D;						// sign ext imm in D shifted by 2 bits
	wire [31:0] pcbranch_D;						// pcbranch in D
	wire [31:0] pcj_D;							// pc for J in D
	wire [31:0] rd1_D;							// contents of rs for instr in D
	wire [31:0] rd2_D;							// contents of rt for instr in D
	wire [31:0] Eq1_D;							// first input in D out of mux going into comparator for pcsrc_D
	wire [31:0] Eq2_D;							// second input in D out of mux going into comparator for pcsrc_D
	
	wire reset_DE;								// flush_E | reset
	wire memtoreg_E;							// memtoreg for instr in E
	wire memwrite_E;							// memwrite for instr in E
	wire alusrc_E;								// alusrc for instr in E
	wire regwrite_E;							// regwrite for instr in E
	wire regdst_E;								// regdst for instr in E
	wire [3:0] alucontrol_E;					// alucontrol for instr in E
	wire [4:0] rs_E;							// source reg for instr in E
	wire [4:0] rt_E;							// target reg for instr in E
	wire [4:0] rd_E;							// dest reg for instr in E
	wire [4:0] writereg_E;						// reg to write to for instr in E
	wire [31:0] rd1_E;							// contents of rs for instr in E
	wire [31:0] rd2_E;							// contents of rt for instr in E
	wire [31:0] srcA_E;							// srcA into ALU in E
	wire [31:0] srcB_E;							// srcB into ALU in E
	wire [31:0] writedata_E;					// data to write at address ALU Result for instr in E
	wire [31:0] signimm_E;						// sign ext imm in E
	wire [31:0] aluout_E;						// ALU result in E
	
	wire reset_EM;								// input reset
	wire memtoreg_M;							// memtoreg for instr in M
	wire regwrite_M;							// regwrite for instr in M
	wire [4:0] writereg_M;						// reg to write to for instr in M
	
	wire reset_MW;								// input reset
	wire memtoreg_W;							// memtoreg for instr in W
	wire regwrite_W;							// regwrite for instr in W
	wire [4:0] writereg_W;						// reg to write to for instr in W
	wire [31:0] aluout_W;						// ALU result in W
	wire [31:0] readdata_W;						// data read from dmem for instr in W
	
	// hazard
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	hazardunit hu(	branch_D,					// branch control for instr in D
					rs_D,						// source reg for instr in D
					rt_D,						// target reg for instr in D
					rs_E,						// source reg for instr in E
					rt_E,						// target reg for instr in E
					writereg_E,					// reg to write to for instr in E
					memtoreg_E,					// memtoreg for instr in E
					regwrite_E,					// regwrite for instr in E
					writereg_M,					// reg to write to for instr in M
					memtoreg_M,					// memtoreg for instr in M
					regwrite_M,					// regwrite for instr in M
					writereg_W,					// reg to write to for instr in W
					regwrite_W,					// regwrite for instr in W
					stall_F,					// hold instr in PC reg
					stall_D,					// hold instr in D reg
					forwardA_D,					// select bits for srcA_D
					forwardB_D,					// select bits for srcB_D
					flush_E,					// clear instr in E reg
					forwardA_E,					// select bits for srcA_E
					forwardB_E					// select bits for srcB_E
					);	
	
	// fetch
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	assign notstall_F = (~stall_F);				// ~stall_F
	assign pcj_F = {	pcplus4_F[31:28], 		// concatenate pc for J in F
						pcj_D[27:0]				// concatenate pc for J in F 
						};
	
	mux2 #(32) branchpcmux_F(	pcplus4_F,		// pcplus4 in F
								pcbranch_D,		// pcbranch in D
								pcsrc_D,		// pcsrc from instr in D
								brtoj_F			// connects brpcmux_F to jpcmux_F
								);	
	mux2 #(32) jumppcmux_F(		brtoj_F,		// connects brpcmux_F to jpcmux_F
								pcj_D,			// pc for J in D
								jump_D,			// jump control for instr in D
								pcprime_F		// pcprime in F
								);							
	flopenr #(32) pcreg_F(	clk,				// input clk
							reset,				// input reset
							notstall_F,			// ~stall_F
							pcprime_F,			// pcprime in F
							pc_F				// pc in F
							);						
	adder pcadd1(	pc_F,						// pc in F
					32'b100,					// 32-bit 4
					pcplus4_F					// pcplus4 in F
					);					
							
	// decode
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	flopenr #(64) FD(	clk,					// input clk
						reset_FD,				// reset: pcsrc_D | jump_D | reset
						notstall_D,				// enable: ~stall_D
						{	instr_F,			// instr retrieved from imem in F
							pcplus4_F			// pcplus4 in F
							},
						{	instr_D,			// instr in D
							pcplus4_D			// pcplus4 in D
							}
						);
	
	assign notstall_D = (~stall_D);				// ~stall_D
	assign pcsrc_D = (branch_D & equal_D);		// pcsrc from instr in D
	assign reset_FD = pcsrc_D | jump_D | reset;	// pcsrc_D | jump_D | reset
	assign rs_D = instr_D[25:21];				// source reg for instr in D
	assign rt_D = instr_D[20:16];				// target reg for instr in D
	assign rd_D = instr_D[15:11];				// dest reg for instr in D
	
	signext16 signext_D(	instr_D[15:0],		// immediate value for instr in D
							signimm_D			// sign ext imm in D
							);							
	sl2 immsl2_D(	signimm_D,					// sign ext imm in D
					shimm_D						// sign ext imm in D shifted by 2 bits
					);		
	adder pcbradd_D(	shimm_D,				// sign ext imm in D
						pcplus4_D,				// pcplus4 in D
						pcbranch_D				// pcbranch in D
						);						
	sl2 jsl2_D(		{	6'b0, 					// shift J address by 2 bits
						instr_D[25:0]			// shift J address by 2 bits
						},						
					pcj_D						// pc for J in D
					);
	regfile rf(	clk,							// input clk
				regwrite_W, 					// regwrite for instr in W
				rs_D,							// source reg for instr in D
				rt_D, 							// target reg for instr in D
				writereg_W,						// reg to write to for instr in W
				result_W,   					// result of ALU/dmem in W
				rd1_D, 							// contents of rs for instr in D
				rd2_D							// contents of rt for instr in D
				);				
	mux2 #(32) rd1mux_D(	rd1_D,				// contents of rs for instr in D
							aluout_M,			// ALU result in M
							forwardA_D,			// select bits for srcA_D
							Eq1_D				// first input in D out of mux going into comparator for pcsrc_D
							);							
	mux2 #(32) rd2mux_D(	rd2_D,				// contents of rt in D
							aluout_M,			// ALU result in M
							forwardB_D,			// select bits for srcB_D
							Eq2_D				// second input in D out of mux going into comparator for pcsrc_D
							);							
	comparator checkbeq(	Eq1_D,				// first input in D out of mux going into comparator for pcsrc_D
							Eq2_D,				// second input in D out of mux going into comparator for pcsrc_D
							equal_D				// 1 when Eq1_D = Eq2_D
							);
	
	// execute
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	flopr #(120) DE(	clk,					// input clk
						reset_DE,				// reset: flush_E
						{	regwrite_D,			// regwrite for instr in D
							memtoreg_D,			// memtoreg for instr in D
							memwrite_D,			// memwrite for instr in D
							alucontrol_D,		// alucontrol for instr in D
							alusrc_D,			// alusrc for instr in D
							regdst_D,			// regdst for instr in D
							rd1_D,				// contents of source reg for instr in D
							rd2_D,				// contents of target reg for instr in D
							rs_D,				// source reg for instr in D
							rt_D,				// target reg for instr in D
							rd_D,				// dest reg for instr in D
							signimm_D			// sign ext imm in D
							},					// 
						{	regwrite_E,			// regwrite for instr in E
							memtoreg_E,			// memtoreg for instr in E
							memwrite_E,			// memwrite for instr in E
							alucontrol_E,		// alucontrol for instr in 
							alusrc_E,			// alusrc for instr in E
							regdst_E,			// regdst for instr in E
							rd1_E,				// contents of source reg for instr in E
							rd2_E,				// contents of target reg for instr in E
							rs_E,				// source reg for instr in E
							rt_E,				// target reg for instr in E
							rd_E,				// dest reg for instr in E
							signimm_E			// sign ext imm in E
							}
						);
	
assign reset_DE = flush_E | reset;				// flush_E | reset
	
	mux2 #(5) writeregmux_E(	rt_E,			// target reg for instr in E
								rd_E,			// dest reg for instr in E
								regdst_E,		// regdst for instr in E
								writereg_E		// reg to write to for instr in E
								);
	mux3 #(32) srcAmux_E(	rd1_E,				// contents of rs for instr in E
							result_W,			// result of ALU/dmem in W
							aluout_M,			// ALU result in M
							forwardA_E,			// select bits for srcA_E
							srcA_E				// srcA into ALU in E
							);
	mux3 #(32) srcBmux_E(	rd2_E,				// contents of rt for instr in E
							result_W,			// result of ALU/dmem in W
							aluout_M,			// ALU result in M
							forwardB_E,			// select bits for srcB_E
							writedata_E			// data to write at address ALU Result for instr in E
							);
	mux2 #(32) srcBmux2_E(	writedata_E,		// data to write at address ALU Result for instr in E
							signimm_E,			// sign ext imm in E
							alusrc_E,			// alusrc for instr in E
							srcB_E				// srcB into ALU in E
							);
	alu32 alu32(	srcA_E,						// srcA into ALU in E
					srcB_E,						// srcB into ALU in E
					alucontrol_E,				// alucontrol for instr in E
					aluout_E					// ALU result in E
					);
	
	// memory
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	flopr #(72) EM(		clk,					// input clk
						reset_EM,				// input reset
						{	regwrite_E,			// regwrite for instr in E
							memtoreg_E,			// memtoreg for instr in E
							memwrite_E,			// memwrite for instr in E
							aluout_E,			// ALU result in E
							writedata_E,		// data to write at address ALU Result for instr in E
							writereg_E			// reg to write to for instr in E
							},
						{	regwrite_M,			// regwrite for instr in M
							memtoreg_M,			// memtoreg for instr in M
							memwrite_M,			// memwrite for instr in M
							aluout_M,			// ALU result in M
							writedata_M,		// data to write at address ALU Result for instr in E
							writereg_M			// reg to write to for instr in E
							}
						);
						
	assign reset_EM = reset;					// input reset
	
	// write
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	flopr #(71) MW(		clk,					// input clk
						reset_MW,				// input reset
						{	regwrite_M,			// regwrite for instr in E
							memtoreg_M,			// memwrite for instr in E
							readdata_M,			// data read from dmem for instr in M
							aluout_M,			// ALU result in M
							writereg_M			// reg to write to for instr in E
							},
						{	regwrite_W,			// regwrite for instr in E
							memtoreg_W,			// memwrite for instr in E
							readdata_W,			// data read from dmem for instr in W
							aluout_W,			// ALU result in W
							writereg_W			// reg to write to for instr in E
							}
						);
						
	assign reset_MW = reset;					// input reset
	
	mux2 #(32) memtoregmux_W(	aluout_W,		// ALU result in W
								readdata_W,		// data read from dmem for instr in W
								memtoreg_W,		// memwrite for instr in E
								result_W		// result of ALU/dmem in W
								);
	
endmodule