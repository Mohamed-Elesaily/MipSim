
`include"ALU.v"
`include"ALU_control.v"
`include"control_case.v"
`include"datamemory_mod.v"
`include"I_Mem_Ben.v"
`include"mux_3options_5set.v"
`include"mux_3options_32set.v"
`include"PC.v"
`include"register_file.v"
`include"sign_extend.v"
`include"s5mux_design.v"
`include"s32mux_design.v"

module datapath(clk,reset,t0,t1,t2,t3,t4,t5,s0,s1,s2,s3,a0,a1,v0,rra);
  
  input reset, clk; output[31:0] t0,t1,t2,t3,t4,t5,s0,s1,s2,s3,a0,a1,v0,rra;

  wire alusrc, beq, bne, beq_out, bne_out, jr, jump, memread, memwrite, notzero, regwrite, zero;
	wire [1:0] memtoreg, regdst;
	wire [2:0] aluop;
	wire [3:0] alucontrol;
	wire [4:0] mux_w;
	wire [31:0] add2_result, muxtomux0, alu_result, alu_select, dm_out, instruction, jump_pc_conc, mux_writedata, muxtomux1, muxtomux2, out_extend, pc_4tomux, pc_address, readdata1, readdata2, return_pc;
	
	parameter ra = 5'd31;
	parameter pcstep = 32'd4;
	
	assign pc_4tomux = pc_address + pcstep;
	assign add2_result = (out_extend << 2 ) + pc_4tomux;
	assign jump_pc_conc = {pc_4tomux[31:28],instruction[25:0],2'b00};

	not inv(notzero,zero);
	and and_beq(beq_out,beq,zero), and_bne(bne_out,bne,notzero);
	
	ALU ALU1(.operand1(readdata1), .operand2(alu_select), .result(alu_result), .control(alucontrol), .zero(zero), .shamt(instruction[10:6]));
	
	ALU_control alu_control1(.JR(jr), .ctrl(alucontrol), .funct(instruction[5:0]), .aluOp(aluop));
	
	control_unit control1(.RegDst(regdst), .BEQ(beq), .BNE(bne), .Jump(jump), .RegWrite(regwrite), .ALUSrc(alusrc), .ALUOp(aluop), .MemWrite(memwrite), .MemRead(memread), .MemtoReg(memtoreg), .opcode(instruction[31:26]));
	
	Dmemory datamemory(.memRead(memread), .memWrite(memwrite), .address(alu_result), .Writedata(readdata2), .Readdata(dm_out));
	
  I_memory instructionmemory(.instruction(instruction), .pc(pc_address),.reset(reset), .clock(clk));
	
	mux_3options_5set mux7(.option_0(instruction[20:16]), .option_1(instruction[15:11]), .option_2(ra), .out(mux_w), .sel(regdst));
	
	mux_3options_32set mux5(.option_0(alu_result), .option_1(dm_out), .option_2(pc_4tomux), .out(mux_writedata), .sel(memtoreg));
	
  PC pc1(.pc_input(return_pc), .pc(pc_address), .clock(clk), .reset(reset));
	
	register_file reg_file1(
	    .data1(readdata1), .data2(readdata2),
	    .read1(instruction[25:21]), .read2(instruction[20:16]),
      .writeReg(mux_w), .writeData(mux_writedata), .writeEna(regwrite),.clock(clk),.t0(t0),.t1(t1),.t2(t2),.t3(t3),.t4(t4),
      .t5(t5),.s0(s0),.s1(s1),.s2(s2),.s3(s3),.a0(a0),.a1(a1),.v0(v0),.rra(rra));
  
  
	s32_set_of_mux mux1(.option_0(muxtomux2),.option_1(readdata1),.out(return_pc),. sel(jr));
          
	s32_set_of_mux mux2(.option_0(muxtomux1),.option_1(add2_result),.out(muxtomux2),. sel(bne_out));
       
  s32_set_of_mux mux3(.option_1(jump_pc_conc),.option_0(muxtomux0),.out(muxtomux1),. sel(jump));

	s32_set_of_mux mux4(.option_0(pc_4tomux),.option_1(add2_result),.out(muxtomux0),. sel(beq_out));
 
	s32_set_of_mux mux6(.option_0(readdata2),.option_1(out_extend),.out(alu_select),. sel(alusrc));

  sign_extend extend(.dataIn(instruction[15:0]), .dataOut(out_extend));
  
   

  
endmodule 
