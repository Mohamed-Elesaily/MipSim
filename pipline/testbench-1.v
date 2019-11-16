`include"Design.v"

module testbench ();
  
	reg clk1,clk2;
	integer i;
	integer j;
	integer k;
	integer file;
	integer file2;
	integer file3;
	
  pipelined_mips mips(clk1,clk2);
  
  initial///initializng to zero and generating clk
  	begin
      
      clk1=0;clk2=0;
      mips.halted=0;
     mips.branch_taken=0;
    //  mips.jump_taken=0;
      mips.pc=0;
     mips.reg_file[28]=32'h00000000;//initializing $gp
  
      forever
        begin
        #5 clk1=1; #5clk1=0;//2phase clk
       #5 clk2=1; #5clk2=0;
        
        end
      
    end
 
  initial///instruction memory initalization
  	begin
      
    /*  mips.I_memory[0]=32'h20080000 ;
      mips.I_memory[1]=32'h20110000 ;
      mips.I_memory[2]=32'h20100006 ;
      mips.I_memory[3]=32'h00000000 ;
      mips.I_memory[4]=32'h2210FFFF ;
      mips.I_memory[5]=32'h00000000 ;
      mips.I_memory[6]=32'h2A080002 ;
      mips.I_memory[7]=32'h22310001 ;
      mips.I_memory[8]=32'h15000002 ;
      mips.I_memory[9]=32'h00000000 ;
      mips.I_memory[10]=32'h0C000004 ; 
      mips.I_memory[11]=32'hFFFFFFFF ;
    */
     /* mips.I_memory[0]=32'h20100064 ;
      mips.I_memory[1]=32'h00000000 ;
      mips.I_memory[2]=32'h00000000 ;
      mips.I_memory[3]=32'hAE100000 ;
      mips.I_memory[4]=32'h00000000 ;
      mips.I_memory[5]=32'h00000000 ;
      mips.I_memory[6]=32'h8E150000 ;
      mips.I_memory[7]=32'hFFFFFFFF ;
      */
      
      
    end
  initial///monitoring output
    begin
      /*#680 for(i=0;i<32;i++)
        $display("%d   %d ",i ,mips.reg_file[i]);*/
      /*$monitor($time," s0=%d  s1=%d  t0=%d ra=%d",mips.reg_file[16],mips.reg_file[17],mips.reg_file[8],mips.reg_file[31]);*/
      $monitor($time," s0=%d  s5=%d  loc0x64=%d",mips.reg_file[16],mips.reg_file[21],mips.D_memory[25]);
    end
  
  
  initial 
  begin
    ///dumping to GTK wave
      //$dumpfile ("mips.vcd");
    //  $dumpvars (0,testbench);
   	$readmemb("machine.txt",mips.I_memory);
  file=$fopen("memory1.txt");
   file2=$fopen("register1.txt");
   file3=$fopen("Pc1.txt");

 
		

#1000
for(j=0;j<8192;j=j+1)
 $fwrite(file ,"%b \n",mips.D_memory[j]); 
	
 for(k=0;k<32;k=k+1)
	$fwrite(file2,"%b \n",mips.reg_file[k]);
	
	$fwrite(file3,"%b \n",mips.pc);

			
		/*$readmemb("E:\\xilinx test\\las\\machine.txt",mips.I_memory);
		for(j=0;j<8191;j=j+1)
 $fwrite(file ,"%b  \n",mips.D_memory[i]);*/
    end
	 initial 
	 begin
 #1000
 $finish;
	 end
	 
endmodule