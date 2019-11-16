module ALU(result,zero,operand1,operand2,control,shamt);
	output zero;
	output reg [31:0] result;
	input [31:0] operand1, operand2;
	input [3:0] control;
	input [4:0] shamt;
	
	parameter sll = 4'b1000, srl = 4'b1001, sra = 4'b1010, lui = 4'b1011, add = 4'b0010, sub = 4'b0110;
	parameter AND = 4'b0000, OR = 4'b0001, XOR = 4'b1111, NOR = 4'b1100, slt = 4'b0111;
	assign zero = ~|result;
	
	always @(*)
	begin
		result = 32'hDEADBEEF;
		case (control)
			sll:	result = operand2 << shamt;
			srl:	result = operand2 >> shamt;
			sra:	result = $signed(operand2) >>> shamt;
			lui:	result = operand2 << 16;
			add:	result = operand1 + operand2;
			sub:	result = operand1 - operand2;
			AND:	result = operand1 & operand2;
			OR:		result = operand1 | operand2;
			XOR:	result = operand1 ^ operand2;
			NOR:	result = ~(operand1 | operand2);
			slt:	result =  (operand1 < operand2)? 1 : 0;
		endcase
	end
endmodule