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

 
  
  initial 
  begin
    ///dumping to GTK wave
   
   	$readmemb("machine.txt",mips.I_memory);
  file=$fopen("memory1.txt");
   file2=$fopen("register1.txt");
   file3=$fopen("pc1.txt");

 
		


#49998 for(j=0;j<8192;j=j+1)
        begin
           $fwrite(file ,"%b \n",mips.D_memory[j]); 
           if(mips.I_memory[j] ==32'hffffffff)
           begin
             mips.pc = j*4;
           end
        end

	
 for(k=0;k<32;k=k+1)
	$fwrite(file2,"%b \n",mips.reg_file[k]);
	
	$fwrite(file3,"%b \n",mips.pc);

			

    end
	 initial 
	 begin
 $dumpfile ("mips.vcd");
 $dumpvars (0,testbench);
 #50000 $finish;
	 end
	 
endmodule