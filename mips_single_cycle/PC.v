module PC(pc,pc_input,clock,reset);//reset is active low
	output reg [31:0] pc;
	input [31:0] pc_input;
	input clock,reset;
  integer  file;
  
  initial
  begin
  file=$fopen("pc1.txt");
  end
  
  
  
  always @(posedge clock or  negedge reset ) 
   
    begin
      if(!reset) 
		begin
		pc<=32'h0;
		$fwrite(file ,"%b  \n",32'b0);
			end
      else 
			begin
		pc <= pc_input;
		$fwrite(file ,"%b  \n",pc_input);
		end
     end
endmodule