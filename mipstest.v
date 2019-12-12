module mipstest();

	reg clk, reset;				// input clk, reset

	wire memwrite_M;			// memwrite for instr in M
	wire [31:0] aluout_M;		// ALU result for instr in M
	wire [31:0]	writedata_M;	// writedata for instr in M
	wire [31:0]	result_W;		// result of ALU/dmem in W
						
	top dut(	clk, 			// input clk
				reset, 			// input reset
				memwrite_M,		// memwrite for instr in M
				aluout_M,		// ALU result for instr in M
				writedata_M,	// writedata for instr in M
				result_W		// result of ALU/dmem in W
				);
  
	initial
		begin
			reset <= 1;			// reset all registers initially
			# 100;				// wait 100 time units
			reset <= 0;			// ~reset
		end

	always
		begin
			clk <= 1;			// input clk
			# 10;				// wait 10 time units
			clk <= 0;			// input ~clk
			# 10;				// wait 10 time units
		end

	always @ (negedge clk)									// write on negedge to read reg in same cycle
		begin
			if(memwrite_M & aluout_M == 84) 				// if expected output
				begin
					if(writedata_M == 7)						
						$display("Simulation succeeded");	// success
				end
		end
	
endmodule