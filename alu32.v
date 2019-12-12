module alu32(	input		[31:0] 	A, B, 		// source A, source B
				input 		[3:0] 	F, 			// ALU Control
				output reg 	[31:0] 	Y			// result Y
				); 
	
	wire [31:0] Bout;						// potentially invert B for SUB based on F[3]
	wire [31:0] S;							// sum of A and Bout and F[3]
	
	assign Bout = F[3] ? ~B : B;			// ADD or SUB
	assign S = A + Bout + F[3];  			// ADD/SUB

	always @ (*)
		case (F[2:0])
			3'b000: Y <= A & Bout;			// AND
			3'b001: Y <= A | Bout;			// OR
			3'b010: Y <= S;					// ADD/SUB
			3'b011: Y <= S[31];				// SLT
			default: Y <= 32'hz;			
		endcase

endmodule