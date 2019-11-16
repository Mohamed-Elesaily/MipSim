module s5_set_of_mux(option_0,option_1,out, sel);
	parameter N = 4;
  input [N:0] option_0,option_1;
input sel;
  output [N:0] out;
assign out= sel? option_1 : option_0 ;
endmodule
