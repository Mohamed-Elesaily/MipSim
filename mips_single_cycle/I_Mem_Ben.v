module I_memory(instruction,reset,pc,clock);
	output reg [31:0] instruction;
	input [31:0] pc;
	input clock , reset ;

	reg [31:0]  memory [0:8191];
  //initial
  always@( reset)
   begin
      
    /*  memory[0] = 32'h200801F4;
	  memory[1] = 32'h20100007;
	  memory[2] = 32'h20110000;
      memory[3] = 32'h3C098000;
      memory[4] = 32'h01305024;
      memory[5] = 32'h11400004;
      memory[6] = 32'h0211582A;
      memory[7] = 32'h11800006;
      memory[8] = 32'h2231FFFF;
      memory[9] = 32'h08000006;
      memory[10] = 32'h0230602A;
      memory[11] = 32'h11800002;
      memory[12] = 32'h22310001;
      memory[13] = 32'h0800000A;
      memory[14] = 32'h02114820;
      memory[15] = 32'hAD090000;
      memory[16] = 32'h200B0001;
      memory[17] = 32'h000B5880;
      memory[18] = 32'h010B5820;
      memory[19] = 32'h3C0C0001;
      memory[20] = 32'h358C0001;
      memory[21] = 32'h8D120000;
      memory[22] = 32'h000C9820;
      memory[23] = 32'h02716825;
      memory[24] = 32'h02402020;
      memory[25] = 32'h02602820;
      memory[26] = 32'h0C00001E;
      memory[27] = 32'h00409820;
      memory[28] = 32'hAD730000;
      memory[29] = 32'h08000020;
      memory[30] = 32'h00851020;
      memory[31] = 32'h03E00008;*/
      
      $readmemb("machine.txt",memory);  // we did it bro <3 
     
    
      end
  always @(posedge clock )
	begin
	if((pc >> 2) < 8191)
 #1	instruction <= memory[pc >> 2];
   
	end
endmodule