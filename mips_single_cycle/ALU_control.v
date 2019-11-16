module ALU_control(JR,ctrl,funct,aluOp);
	output reg JR;
	output reg [3:0] ctrl;
	input [5:0] funct;
	input [2:0] aluOp;

	always @(aluOp or funct)
    begin
    	JR = 0;
		ctrl = 4'b0000;
        case (aluOp)
	        3'b100:
	        begin
	            case (funct)
	                8:	JR = 1;			//jr
	                0:	ctrl = 4'b1000; 	//sll 
	                2:	ctrl = 4'b1001; 	//srl
	                3:	ctrl = 4'b1010; 	//sra
	                32: ctrl = 4'b0010;	//add
	                34: ctrl = 4'b0110; 	//sub
	                36: ctrl = 4'b0000; 	//and
	                37: ctrl = 4'b0001; 	//or
	                38: ctrl = 4'b1111; 	//xor
	                39: ctrl = 4'b1100; 	//nor
	                42: ctrl = 4'b0111; 	//slt
	            endcase
	        end

	        3'b010: ctrl = 4'b0010; //addi, loads, stores
	        3'b110: ctrl = 4'b0110; //beq, bne
	        3'b000: ctrl = 4'b0000; //andi
	        3'b001: ctrl = 4'b0001; //ori
	        3'b111: ctrl = 4'b1111; //xori
	        3'b011: ctrl = 4'b0111; //slti
	        3'b101: ctrl = 4'b1011; //lui
        endcase
    end
endmodule