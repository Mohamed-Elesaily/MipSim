
module control_unit(ALUOp, ALUSrc, BEQ, BNE, Jump, MemRead, MemtoReg, MemWrite, RegDst, RegWrite,  opcode);
	input  [5:0] opcode;
	output reg [2:0] ALUOp;
	output reg ALUSrc;
	output reg BEQ;
	output reg BNE;
	output reg Jump;
	output reg MemRead;
	output reg [1:0] MemtoReg;
	output reg MemWrite;
	output reg [1:0] RegDst;
	output reg RegWrite;
always @(*) 
	begin	
	case (opcode)
	
		//R-format
		6'b000000: begin
			ALUOp = 3'b100;
			ALUSrc = 0;
			BEQ= 0;
			BNE = 0;
			Jump = 0;
			MemRead = 0;
			MemtoReg = 2'b00;
			MemWrite = 0;
			RegDst = 2'b01;
			RegWrite = 1;
		end

				//lw
		6'b100011: begin
			ALUOp = 3'b010;
			ALUSrc = 1;
			BEQ = 0;
			BNE = 0;
			Jump = 0;
			MemRead = 1;
			MemtoReg = 2'b01;
			MemWrite = 0;
			RegDst = 2'b00;
			RegWrite = 1;
		end

				//sw
		6'b101011: begin
			ALUOp = 3'b010;
			ALUSrc = 1;
			BEQ = 0;
			BNE = 0;
			Jump = 0;
			MemRead = 0;
			MemtoReg = 2'b00;
			MemWrite = 1;
			RegDst = 2'bxx;
			RegWrite = 0;
		end

				//beq
		6'b000100: begin
			ALUOp = 3'b110;
			ALUSrc = 0;
			BEQ = 1;
			BNE = 0;
			Jump = 0;
			MemRead = 0;
			MemtoReg = 2'bxx;
			MemWrite = 0;
			RegDst = 2'bxx;
			RegWrite = 0;
		end

					//bne
		6'b000101: begin
			ALUOp = 3'b110;
			ALUSrc = 0;
			BEQ = 0;
			BNE = 1;
			Jump = 0;
			MemRead = 0;
			MemtoReg = 2'bxx;
			MemWrite = 0;
			RegDst = 2'bxx;
			RegWrite = 0;
		end

					//j
		6'b000010:begin
			ALUOp = 3'bxxx;
			ALUSrc = 1'bx;
			BEQ = 0;
			BNE = 0;
			Jump = 1;
			MemRead = 0;
			MemtoReg = 2'bxx;
			MemWrite = 0;
			RegDst = 2'bxx;
			RegWrite = 0;
		end

				//jal
		6'b000011:begin
			ALUOp = 3'bxxx;
			ALUSrc = 1'bx;
			BEQ = 0;
			BNE = 0;
			Jump = 1;
			MemRead = 0;
			MemtoReg = 2'b10;
			MemWrite = 0;
			RegDst = 2'b10;
			RegWrite = 1;
		end

					//addi
		6'b001000:begin
			ALUOp = 3'b010;
			ALUSrc = 1;
			BEQ = 0;
			BNE = 0;
			Jump = 0;
			MemRead = 0;
			MemtoReg = 2'b00;
			MemWrite = 0;
			RegDst = 2'b00;
			RegWrite = 1;
		end

					//andi
		6'b001100:begin
			ALUOp = 3'b000;
			ALUSrc = 1;
			BEQ = 0;
			BNE = 0;
			Jump = 0;
			MemRead = 0;
			MemtoReg = 2'b00;
			MemWrite = 0;
			RegDst = 2'b00;
			RegWrite = 1;
		end

					//ori
		6'b001101: begin
			ALUOp = 3'b001;
			ALUSrc = 1;
			BEQ = 0;
			BNE = 0;
			Jump = 0;
			MemRead = 0;
			MemtoReg = 2'b00;
			MemWrite = 0;
			RegDst = 2'b00;
			RegWrite = 1;
		end

					//xori
		6'b001110: begin
			ALUOp = 3'b111;
			ALUSrc = 1;
			BEQ = 0;
			BNE = 0;
			Jump = 0;
			MemRead = 0;
			MemtoReg = 2'b00;
			MemWrite = 0;
			RegDst = 2'b00;
			RegWrite = 1;
		end

					//slti
		6'b001010: begin
			ALUOp = 3'b011;
			ALUSrc = 1;
			BEQ = 0;
			BNE = 0;
			Jump = 0;
			MemRead = 0;
			MemtoReg = 2'b00;
			MemWrite = 0;
			RegDst = 2'b00;
			RegWrite = 1;
		end
		
					//lui
		6'b001111: begin
			ALUOp = 3'b101;
			ALUSrc = 1;
			BEQ = 0;
			BNE = 0;
			Jump = 0;
			MemRead = 0;
			MemtoReg = 2'b00;
			MemWrite = 0;
			RegDst = 2'b00;
			RegWrite = 1;
          

       end
      default:begin
       			ALUOp = 3'bxxx;
			ALUSrc = 1'bx;
			BEQ = 1'bx;
			BNE = 1'bx;
			Jump = 1'bx;
			MemRead =1'bx;
			MemtoReg = 2'bxx;
			MemWrite = 1'bx;
			RegDst = 2'bxx;
			RegWrite = 1'bx;
        	  end
	endcase
    end
endmodule 




// Code your testbench here
// or browse Examples
/*module test_control;
	 reg [5:0]op;
  	 wire [2:0] aLUOp;
	 wire aLUSrc;
	 wire bEQ;
	 wire bNE;
	 wire jump;
	 wire memRead;
	 wire [1:0] memtoReg;
	 wire memWrite;
	 wire [1:0] regDst;
	 wire regWrite;
	
initial
begin
  $monitor ("%b ,%b,%b ,%b ,%b ,%b ,%b, %b ,%b, %b ,%b ",op,aLUOp,aLUSrc,bEQ,bNE,jump,memRead,memtoReg,memWrite,regDst,regWrite);

  op = 6'b100011;
#5
op=6'b000011;

end

control_unit S1(aLUOp,aLUSrc,bEQ,bNE,jump,memRead,memtoReg,memWrite,regDst,regWrite,op);


endmodule  */