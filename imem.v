module imem(	input  [5:0] 	a,				// upper 6 bits of 8-bit PC (word aligned)
				output [31:0] 	rd_F			// instr retrieved from imem in F
				);		

	reg  [31:0] RAM[63:0];					// can hold up to 64 32-bit instr

	initial
		begin
			$readmemh("memfile.dat", RAM);	// read program instr into RAM
		end

	assign rd_F = RAM[a]; 					// instr retrieved from imem in F
  
endmodule