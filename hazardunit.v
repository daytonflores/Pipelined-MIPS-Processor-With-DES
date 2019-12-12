module hazardunit(	input 			branch_D,					// branch control for instr in D
					input	[4:0]	rs_D, rt_D,					// source/target reg of instr in D
					input	[4:0]	rs_E, rt_E,					// source/target reg of instr in D
					input	[4:0]	writereg_E,					// reg that data will be written to for instr in E
					input 			memtoreg_E,					// low when non-LW for instr in E
					input			regwrite_E,					// low when SW/BEQ/J for instr in E
					input	[4:0]	writereg_M,					// reg that data will be written to for instr in M
					input			memtoreg_M,					// low when non-LW for instr in M
					input			regwrite_M,					// low when SW/BEQ/J for instr in M
					input	[4:0]	writereg_W,					// reg that data will be written to for instr in W
					input			regwrite_W,					// low when SW/BEQ/J for instr in W
					output reg		stall_F,					// hold instr in PC reg
					output reg		stall_D,					// hold instr in D reg
					output reg 	 	forwardA_D, forwardB_D,		// select bits for srcA_D, srcB_D
					output reg		flush_E,					// clear instr in E reg
					output reg[1:0] forwardA_E, forwardB_E		// select bits for srcA_E, srcB_E
					);
	
	reg lwstall;					// temp to be assigned in always() block
	reg branchstall;				// temp to be assigned in always() block
	reg cbranchstall;				// temp to be assigned in always() block
	reg dbranchstall;				// temp to be assigned in always() block
					
	always @ (*)
		begin
		// lwstall
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			if		(  ((rs_D == rt_E)			// if either source reg needed for instr in D is the same as the reg to be written in E
					|| (rt_D == rt_E))			// if either target reg needed for instr in D is the same as the reg to be written in E
					&& (memtoreg_E == 1'b1))	// if instr in E is LW
				begin							// then
					lwstall <= 1'b1;			// set lwstall
				end
			else
				begin
					lwstall <= 1'b0;			// else, clear lwstall
				end
		// cbranchstall
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			if		(  ((rs_D == writereg_E)	// if either source reg needed for instr in D is the same as the reg to be written in E
					|| (rt_D == writereg_E))	// if either target reg needed for instr in D is the same as the reg to be written in E
					&& (regwrite_E == 1'b1))	// if instr in E is non-SW/BEQ/J
				begin							// then
					cbranchstall <= 1'b1;		// set cbranchstall
				end
			else
				begin
					cbranchstall <= 1'b0;		// else, clear cbranchstall
				end
		// dbranchstall
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			if		(  ((rs_D == writereg_M)	// if either source reg needed for instr in D is the same as the reg to be written in M
					|| (rt_D == writereg_M))	// if either target reg needed for instr in D is the same as the reg to be written in M
					&& (memtoreg_M == 1'b1))	// if instr in M is LW
				begin							// then
					dbranchstall <= 1'b1;		// set dbranchstall
				end
			else
				begin
					dbranchstall <= 1'b0;		// else, clear dbranchstall
				end
		// branchstall
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			if		(  ((cbranchstall)			// if either control branch hazard
					|| (dbranchstall))			// if either data branch hazard
					&& (branch_D == 1'b1))		// if instr in D is BEQ
				begin							// then
					branchstall <= 1'b1;		// set branchstall
				end
			else
				begin
					branchstall <= 1'b0;		// else, clear branchstall
				end
		// stall_F, stall_D, flush_E
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			if		(  (lwstall)				// if either lwstall
					|| (branchstall))			// if either branchstall
				begin							// then
					stall_F <= 1'b1;			// hold instr in PC reg
					stall_D <= 1'b1;			// hold instr in D reg
					flush_E <= 1'b1;			// clear instr in E reg
				end
			else
				begin
					stall_F <= 1'b0;			// if no LW/BEQ hazards for rs_D/rt_D, then continue pipelining
					stall_D <= 1'b0;			// if no LW/BEQ hazards for rs_D/rt_D, then continue pipelining
					flush_E <= 1'b0;			// if no LW/BEQ hazards for rs_D/rt_D, then continue pipelining
				end
		// forwardA_D
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			if		(  (rs_D != 5'b00000)		// if source reg in D is not $0
					&& (rs_D == writereg_M)		// if source reg needed for instr in D is the same as the reg to be written in M
					&& (regwrite_M == 1'b1))	// if instr in M will actually write data to register file
				begin							// then
					forwardA_D <= 1'b1;			// forward ALUout_M to srcA_D
				end
			else
				begin
					forwardA_D <= 1'b0;			// if no RAW hazards for srcA_D, then select rs_D
				end
		// forwardB_D
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			if		(  (rt_D != 5'b00000)		// if target reg in D is not $0
					&& (rt_D == writereg_M)		// if target reg needed for instr in D is the same as the reg to be written in M
					&& (regwrite_M == 1'b1))	// if instr in M will actually write data to register file
				begin							// then
					forwardB_D <= 1'b1;			// forward ALUout_M to srcB_D
				end
			else
				begin
					forwardB_D <= 1'b0;			// if no RAW hazards for srcB_D, then select rt_D
				end
		// forwardA_E
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			if		(  (rs_E != 5'b00000)		// if source reg in E is not $0
					&& (rs_E == writereg_M)		// if source reg needed for instr in E is the same as the reg to be written in M
					&& (regwrite_M == 1'b1))	// if instr in M will actually write data to register file
				begin							// then
					forwardA_E <= 2'b10;		// forward ALUout_M to srcA_E
				end
			else if (  (rs_E != 5'b00000)		// if source reg in E is not $0
					&& (rs_E == writereg_W)		// if source reg needed for instr in E is the same as the reg to be written in W
					&& (regwrite_W == 1'b1))	// if instr in W will actually write data to register file
				begin							// then
					forwardA_E <= 2'b01;		// forward result_W to srcA_E
				end
			else
				begin
					forwardA_E <= 2'b00;		// if no RAW hazards for srcA_E, then select srcA_D
				end	
		// forwardB_E
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
			if		(  (rt_E != 5'b00000)		// if target reg in E is not $0
					&& (rt_E == writereg_M)		// if target reg needed for instr in E is the same as the reg to be written in M
					&& (regwrite_M == 1'b1))	// if instr in M will actually write data to register file
				begin							// then
					forwardB_E <= 2'b10;		// forward ALUout_M to srcB_E
				end
			else if (  (rt_E != 5'b00000)		// if target reg in E is not $0
					&& (rt_E == writereg_W)		// if target reg needed for instr in E is the same as the reg to be written in W
					&& (regwrite_W == 1'b1))	// if instr in W will actually write data to register file
				begin							// then
					forwardB_E <= 2'b01;		// forward result_W to srcB_E
				end
			else
				begin
					forwardB_E <= 2'b00;		// if no RAW hazards for srcB_E, then select srcB_D
				end
		end
					
endmodule