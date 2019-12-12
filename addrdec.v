module addrdec(	input 				memwrite_M,		// set if instr is SW
				input [31:0]		aluout_M,		// 32-bit address to access in dmem in M or memory-mapped I/Os
				output reg			WEDM,			// write enable to dmem
				output reg			WEUK,			// write enable to upper DES key
				output reg			WELK,			// write enable to lower DES key
				output reg			WEUD,			// write enable to upper DES data
				output reg			WELD,			// write enable to lower DES data
				output reg [1:0]	RDsel			// select bits for readdata_M
				);
				
	always @ (*)
	begin
		case(aluout_M)
			32'hFFFF_FFFC: 						// maps to upper DES key
				begin							//
					if(memwrite_M)				// if instr is SW
						begin					// then
							WEDM <= 0;			// clear enable to dmem
							WEUK <= 1;			// set enable to upper DES key
							WELK <= 0;			// clear enable to lower DES key
							WEUD <= 0;			// clear enable to upper DES data
							WELD <= 0;			// clear enable to lower DES data
						end						//
					else						// if instr is not SW
						begin					// then
							WEDM <= 0;			// clear enable to dmem
							WEUK <= 0;			// clear enable to upper DES key
							WELK <= 0;			// clear enable to lower DES key
							WEUD <= 0;			// clear enable to upper DES data
							WELD <= 0;			// clear enable to lower DES data
						end
				end	
			32'hFFFF_FFF8: 						// maps to lower DES key
				begin							//
					if(memwrite_M)				// if instr is SW
						begin					// then
							WEDM <= 0;			// clear enable to dmem
							WEUK <= 0;			// clear enable to upper DES key
							WELK <= 1;			// set enable to lower DES key
							WEUD <= 0;			// clear enable to upper DES data
							WELD <= 0;			// clear enable to lower DES data
						end						//
					else						// if instr is not SW
						begin					// then
							WEDM <= 0;			// clear enable to dmem
							WEUK <= 0;			// clear enable to upper DES key
							WELK <= 0;			// clear enable to lower DES key
							WEUD <= 0;			// clear enable to upper DES data
							WELD <= 0;			// clear enable to upper DES data
						end
				end
			32'hFFFF_FFF4: 						// maps to upper DES data
				begin							//
					if(memwrite_M)				// if instr is SW
						begin					// then
							WEDM <= 0;			// clear enable to dmem
							WEUK <= 0;			// clear enable to upper DES key
							WELK <= 0;			// clear enable to lower DES key
							WEUD <= 1;			// set enable to upper DES data
							WELD <= 0;			// clear enable to lower DES data
						end						//
					else						// if instr is not SW
						begin					// then
							WEDM <= 0;			// clear enable to dmem
							WEUK <= 0;			// clear enable to upper DES key
							WELK <= 0;			// clear enable to lower DES key
							WEUD <= 0;			// clear enable to upper DES data
							WELD <= 0;			// clear enable to lower DES data
						end
				end
			32'hFFFF_FFF0: 						// maps to lower DES data
				begin							//
					if(memwrite_M)				// if instr is SW
						begin					// then
							WEDM <= 0;			// clear enable to dmem
							WEUK <= 0;			// clear enable to upper DES key
							WELK <= 0;			// clear enable to lower DES key
							WEUD <= 0;			// clear enable to upper DES data
							WELD <= 1;			// set enable to lower DES data
						end						//
					else						// if instr is not SW
						begin					// then
							WEDM <= 0;			// clear enable to dmem
							WEUK <= 0;			// set enable to upper DES key
							WELK <= 0;			// clear enable to lower DES key
							WEUD <= 0;			// clear enable to upper DES data
							WELD <= 0;			// clear enable to lower DES data
						end
				end
			32'hFFFF_FFEC: 						// maps to desOut[63:32]
				begin							//
					if(memwrite_M)				// if instr is SW
						begin					// then
							WEDM <= 0;			// clear enable to dmem
							WEUK <= 0;			// clear enable to upper DES key
							WELK <= 0;			// clear enable to lower DES key
							WEUD <= 0;			// clear enable to upper DES data
							WELD <= 0;			// clear enable to lower DES data
						end						// 
					else						// if instr is not SW 
						begin					// then
							WEDM <= 0;			// clear enable to dmem
							WEUK <= 0;			// clear enable to upper DES key
							WELK <= 0;			// clear enable to lower DES key
							WEUD <= 0;			// clear enable to upper DES data
							WELD <= 0;			// clear enable to upper DES data
							RDsel <= 2'b10;		// select desOut[63:32] for readdata_M
						end
				end
			32'hFFFF_FFE8: 						// maps to desOut[31:0]
				begin							//
					if(memwrite_M)				// if instr is SW
						begin					// then
							WEDM <= 0;			// clear enable to dmem
							WEUK <= 0;			// clear enable to upper DES key
							WELK <= 0;			// clear enable to lower DES key
							WEUD <= 0;			// clear enable to upper DES data
							WELD <= 0;			// clear enable to lower DES data
						end						// 
					else						// if instr is not SW 
						begin					// then
							WEDM <= 0;			// clear enable to dmem
							WEUK <= 0;			// clear enable to upper DES key
							WELK <= 0;			// clear enable to lower DES key
							WEUD <= 0;			// clear enable to upper DES data
							WELD <= 0;			// clear enable to upper DES data
							RDsel <= 2'b01;		// select desOut[31:0] for readdata_M
						end
				end
			default: 							// case default (any other address)
				begin							//
					if(memwrite_M)				// if instr is SW
						begin					// then	
							WEDM <= 1;			// set enable to dmem
							WEUK <= 0;			// clear enable to upper DES key
							WELK <= 0;			// clear enable to lower DES key
							WEUD <= 0;			// clear enable to upper DES data
							WELD <= 0;			// clear enable to lower DES data
						end						//
					else						// if instr is not store word
						begin					// then
							WEDM <= 0;			// clear enable to dmem
							WEUK <= 0;			// clear enable to upper DES key
							WELK <= 0;			// clear enable to lower DES key
							WEUD <= 0;			// clear enable to upper DES data
							WELD <= 0;			// clear enable to lower DES data
							RDsel <= 2'b00;		// select dmem_M for readdata_M
						end
				end
		endcase
	end
			
endmodule