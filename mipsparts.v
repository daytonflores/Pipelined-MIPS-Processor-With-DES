// regfile
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module regfile(	input    			clk,			// input clk
				input         		we3, 			// write enable to rt/rd
				input  		[4:0] 	ra1, ra2,		// rs, rt
				input  		[4:0]	wa3, 			// rt/rd
				input  		[31:0] 	wd3, 			// data to be written to rt/rd
				output  	[31:0] 	rd1, rd2		// rs, rt values retrieved from reg file
				);

	reg [31:0] rf[31:0];						// can hold up to 32 32-bit reg values

	initial
		begin
			rf[0] <= 32'b0;
			rf[1] <= 32'b0;
			rf[2] <= 32'b0;
			rf[3] <= 32'b0;
			rf[4] <= 32'b0;
			rf[5] <= 32'b0;
			rf[6] <= 32'b0;
			rf[7] <= 32'b0;
			rf[8] <= 32'b0;
			rf[9] <= 32'b0;
			rf[10] <= 32'b0;
			rf[11] <= 32'b0;
			rf[12] <= 32'b0;
			rf[13] <= 32'b0;
			rf[14] <= 32'b0;
			rf[15] <= 32'b0;
			rf[16] <= 32'b0;
			rf[17] <= 32'b0;
			rf[18] <= 32'b0;
			rf[19] <= 32'b0;
			rf[20] <= 32'b0;
			rf[21] <= 32'b0;
			rf[22] <= 32'b0;
			rf[23] <= 32'b0;
			rf[24] <= 32'b0;
			rf[25] <= 32'b0;
			rf[26] <= 32'b0;
			rf[27] <= 32'b0;
			rf[28] <= 32'b0;
			rf[29] <= 32'b0;
			rf[30] <= 32'b0;
			rf[31] <= 32'b0;
		end
	
	always @(negedge clk)
		begin
			if (we3) 								// if write enable to rt/rd
				begin								// then
					rf[wa3] <= wd3;					// rt/rd = wd3
				end
		end

	assign rd1 = (ra1 != 0) ? rf[ra1] : 0;			// if rs = $0, then ra1 = 32'b0
	assign rd2 = (ra2 != 0) ? rf[ra2] : 0;			// if rt = $0, then ra2 = 32'b0
	
endmodule

// adder
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module adder(	input [31:0] 	a, b,	// sources A, B
				output [31:0] 	y		// result Y
				);	

	assign y = a + b;			// Y = A + B
	
endmodule

// comparator
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module comparator(	input  [31:0] 	a, b,	// inputs A, B
					output 		 	y		// result Y
					);
			
	assign y = (a == b);	// 1 if a = b
  
endmodule

// sl2
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module sl2(	input  [31:0] 	a,			// input A
			output [31:0] 	y			// result Y
			);
			
	assign y = {a[29:0], 2'b00};	// shift left by 2 bits
  
endmodule

// signext8
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module signext8(	input  [7:0] 	a,	// 8-bit input A											
					output [31:0] 	y	// 32-bit result Y
					);										
																		
  assign y = {{24{a[7]}}, a};		// sign extend 8-bit input to 32-bit result
  
endmodule     

// signext16
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module signext16(	input  [15:0] 	a,	// 16-bit input A
					output [31:0] 	y	// 32-bit result Y
					);
              
	assign y = {{16{a[15]}}, a};	// sign extend 16-bit input to 32-bit result
	
endmodule

// zeroext
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module zeroext16(	input  [15:0] 	a,  // 16-bit input A                                      
					output [31:0]	y	// 32-bit result Y
					);                                        
                                                                        
	assign y = {16'b0, a}; 			// zero extend 16-bit input to 32-bit result
	
endmodule    															

// flop
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module flop #(parameter WIDTH = 8)				// default 8-bit
			 (	input           		clk,	// input clk, reset
				input      [WIDTH-1:0] 	d, 		// WIDTH-bit input
				output reg [WIDTH-1:0] 	q		// WIDTH-bit output
				);			

	always @(posedge clk)
		begin
			q <= d;							// q gets d
		end
	
endmodule

// flopen
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module flopen #(parameter WIDTH = 8)				// default 8-bit
			 (	input           		clk,		// input clk, reset
				input					en,			// enable
				input      [WIDTH-1:0] 	d, 			// WIDTH-bit input
				output reg [WIDTH-1:0] 	q			// WIDTH-bit output
				);			

	always @(posedge clk)
		begin
			if (en)								// if enable
				begin							// then
					q <= d;						// q gets d
				end
		end
	
endmodule

// flopr
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module flopr #(parameter WIDTH = 8)					// default 8-bit
			 (	input           		clk, reset,	// input clk, reset
				input      [WIDTH-1:0] 	d, 			// WIDTH-bit input
				output reg [WIDTH-1:0] 	q			// WIDTH-bit output
				);			

	always @(posedge clk)
		begin
			if (reset)							// if reset
				begin							// then
					q <= 0;						// q gets 0
				end								//
			else 								// else
				begin							// then
					q <= d;						// q gets d
				end
		end
	
endmodule

// flopenr
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module flopenr #(parameter WIDTH = 8)					// default 8-bit
               (	input                  	clk, reset,	// input clk, reset
					input                  	en,			// enable
					input      [WIDTH-1:0]	d, 			// WIDTH-bit input
					output reg [WIDTH-1:0] 	q			// WIDTH-bit output
					);			
 
	always @(posedge clk)
		begin
			if (reset) 								// if reset
				begin								// then
					q <= 0;							// q gets 0
				end									//
			else if (en) 							// else if enable
				begin								// then
					q <= d;							// q gets d
				end
		end
	
endmodule

// mux2
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module mux2 #(parameter WIDTH = 8)			// default 8-bit
			(	input  [WIDTH-1:0]	d0, d1,	// inputs d0, d1 to select from
				input              	s, 		// select bit
				output [WIDTH-1:0] 	y		// output selected
				);

	assign y = s ? d1 : d0; 			// y gets d1 if s = 1 / d0 if s = 0
  
endmodule

// mux3
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module mux3 #(parameter WIDTH = 8)					// default 8-bit
            (	input  [WIDTH-1:0] 	d0, d1, d2,		// inputs d0, d1, d2 to select from
				input  [1:0]       	s, 				// select bits
				output [WIDTH-1:0] 	y				// output selected
				);

	assign #1 y = s[1] ? d2 : (s[0] ? d1 : d0);	// y gets d2 if s = 10 / d1 if s = 01 / d0 if s = 00
	
endmodule

// mux4
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////												
module mux4 #(parameter WIDTH = 8)								// default 8-bit								
            (	input  [WIDTH-1:0] d0, d1, d2, d3,				// inputs d0, d1, d2, d3 to select from					
				input  [1:0]       s, 							// select bits
				output [WIDTH-1:0] y							// output selected
				);				
																		
  assign #1 y = s[1] ? (s[0] ? d3 : d2) : (s[0] ? d1 : d0);	// y gets d3 if s = 11 / d2 if s = 10 / d1 if s = 01 / d0 if s = 00	
  
endmodule																

// upimm
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module upimm(	input  [15:0] 	a,	// 16-bit input
				output [31:0] 	y	// 32-bit result
				);
              
	assign y = {a, 16'b0};		// load 16-bit input into upper 16-bits of 32-bit output (lower 16-bits zero'd)
	
endmodule