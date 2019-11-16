//`timescale 1 ns / 1 ps
`include"datapath.v"
module datapath_tb();
	reg reset,clk;
  wire [31:0]t0,t1,t2,t3,t4,t5,s0,s1,s2,s3,a0,a1,v0,rra;
	parameter duty = 5;
  datapath datapath_dut(clk,reset,t0,t1,t2,t3,t4,t5,s0,s1,s2,s3,a0,a1,v0,rra);	
  initial
	begin
		 reset<=1;
		  clk <= 1;
      	#3 reset <= 0;
      	#10 reset <= 1;
	end
  
  always 
		#duty clk = ~clk;
	
	initial
	begin
      $monitor("t0 =%d ,t1 =%d ,t2 =%d ,t3 =%d ,t4 =%d ,t5 =%d ,s0 =%d ,s1 =%d ,s2 =%d ,s3 =%d ,a0 =%d ,a1 =%d ,v0 =%d ,ra =%d ", t0,t1,t2,t3,t4,t5,s0,s1,s2,s3,a0,a1,v0,rra);
	#600 $finish;
    end

	initial
	begin
      $dumpfile("dump.vcd");
      $dumpvars(0,datapath_tb);
		
	end
endmodule
