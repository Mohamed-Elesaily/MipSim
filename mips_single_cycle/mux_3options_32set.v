module mux_3options_32set(option_0,option_1,option_2,out, sel);
	parameter N = 31;
  input [N:0] option_0,option_1,option_2;
input [1:0] sel;
  output [N:0] out;
assign out = ((sel == 00)? option_0:((sel == 01) ? option_1:option_2)) ;
endmodule