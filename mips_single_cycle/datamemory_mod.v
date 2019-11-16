module Dmemory(memRead,memWrite,address,Writedata,Readdata);
input memRead,memWrite;
input [31:0] Writedata,address;
output reg [31:0] Readdata;
reg [31:0] memory[0:8191];
integer file;
integer i ;
 
  
  always @ (memRead,memWrite,Writedata,address)
begin

if((!memRead) && memWrite)
begin
  memory[(address>>2)] <= Writedata;
  

 end
 
  else if(memRead && (!memWrite))
   Readdata <= memory[(address>>2)];
	
	else
	 memory[(address>>2)] <= 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
  Readdata <=32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;

end
initial
  begin
  file=$fopen("memory1.txt");
 #600
 for(i=0;i<8191;i=i+1)
 $fwrite(file ,"%b  \n",memory[i]);
  end

endmodule
