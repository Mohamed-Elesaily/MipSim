module register_file(
    data1, data2,
    read1, read2,
    writeReg, writeData, writeEna,
    clock,t0,t1,t2,t3,t4,t5,s0,s1,s2,s3,a0,a1,v0,rra
);
  output [31:0] data1, data2,t0,t1,t2,t3,t4,t5,s0,s1,s2,s3,a0,a1,v0,rra;
    input [4:0] read1, read2, writeReg;
    input [31:0] writeData;
    input writeEna, clock;
	
	 reg [31:0] reg_file[0:31];
	
	integer file;
	integer i;
	
  assign t0=reg_file[8];
  assign t1=reg_file[9];
  assign t2=reg_file[10];
  assign t3=reg_file[11];
  assign t4=reg_file[12];
  assign t5=reg_file[13];
  assign s0=reg_file[16];
  assign s1=reg_file[17];
  assign s2=reg_file[18];
  assign s3=reg_file[19];
  assign a0=reg_file[4];
  assign a1=reg_file[5];
  assign v0=reg_file[2];
  assign rra=reg_file[31];
 
  
  assign data1 = (read1==0)? 0:reg_file[read1];
  assign data2 =(read2==0)?  0:reg_file[read2];
  
  

    always @(posedge clock)
    begin
				
       	if(writeEna)
            
				begin
				reg_file[writeReg] <= writeData;
				
				
				end
		
	end

initial
  begin
  file=$fopen("register1.txt");
 #600
 reg_file[0]=32'b0;

 for(i=0;i<32;i=i+1)
 $fwrite(file ,"%b  \n",reg_file[i]);
  end
		



endmodule 