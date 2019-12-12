module dmem(	input       	clk,		// input clk
				input			we_M,		// write enable to dmem in M
				input	[31:0]	a,			// address in dmem to be accessed
				input	[31:0]	wd,			// data to be written into dmem
				output	[31:0] 	rd			// data retrieved from dmem
				);			

	reg  [31:0] RAM[63:0];				// can hold up to 64 32-bit data

	assign rd = RAM[a[31:2]]; 			// data retrieved from dmem (word aligned)

	always @ (posedge clk)
	begin
		if (we_M)						// if write enable in M
			begin						// then
				RAM[a[31:2]] <= wd;		// wd is stored at address a
			end
	end
	  
endmodule