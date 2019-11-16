module pipelined_mips (clk1,clk2);

  input clk1,clk2;    //2 phase clk

  parameter R_format=6'b000000,lw=6'b100011,sw=6'b101011,
  beq=6'b000100,bne=6'b000101,j=6'b000010,jal=6'b000011,
  addi=6'b001000,andi=6'b001100,ori=6'b001101,xori=6'b001110,
  slti=6'b001010,lui=6'b001111,hlt=6'b111111;
  parameter jr_func=8;
  ////////////////////////////////////////////////////////////////////////////////
  reg halted , branch_taken;// special regs for hlt and indicating jump/branches
  //// inbetween stages registers
  reg [31:0] IF_ID_IR, ID_EX_IR, EX_MEM_IR, MEM_WB_IR,IF_ID_NPC, ID_EX_NPC,
  			 EX_MEM_NPC,MEM_WB_NPC,ID_EX_A,ID_EX_B,ID_EX_IMM,EX_MEM_ALUresult,
  			EX_MEM_A,EX_MEM_B,EX_MEM_BranchAdrr,MEM_WB_RDM,MEM_WB_ALUresult
  			,EX_MEM_JumpAdrr;
                  
  //////////////////////////////////////////////////////////////////////////////
  reg [31:0]  I_memory [0:8191];  // declaration of instruction mem of size 4KB 
  reg [31:0]  D_memory [0:8191];  // declaration of data mem of size 4KB 
  reg [31:0] reg_file[0:31]; 
  reg [31:0] pc;
////////////////////////////////////////////////////////////
  //stage 1 */ Instruction fetch (IF) /*////////////////////
  always @(posedge clk1)
    begin 
    	branch_taken<=#2  0;
      if (halted==0)
        begin
         
             // 	jump_taken<=#2 0;
          if (((EX_MEM_ALUresult==0)&&(EX_MEM_IR[31:26]==beq)) ||
              ((EX_MEM_ALUresult!=0)&&(EX_MEM_IR[31:26]==bne)) )     
          begin// if instruction being executed is bne or beq
          		IF_ID_NPC <=#2  EX_MEM_BranchAdrr+4;
         IF_ID_IR <= #2 I_memory[({2'b00,EX_MEM_BranchAdrr[31:2]})];
            	pc<=#2 EX_MEM_BranchAdrr+4;//>>2for byte addressed mem
            	branch_taken<=#2 1;
          end
          
          else if ((EX_MEM_IR[31:26]==j)||(EX_MEM_IR[31:26]==jal))
          begin		// if instruction being executed is jump/jal
          		IF_ID_NPC <=#2 EX_MEM_JumpAdrr+4;
          IF_ID_IR <=#2  I_memory[({2'b00,EX_MEM_JumpAdrr[31:2]})];
            pc<=#2 EX_MEM_JumpAdrr+4; 
             	branch_taken<=#2 1;
          end
          
          else if ( (EX_MEM_IR[5:0]==jr_func)&&(EX_MEM_IR[31:26]==0) )
          begin           // if instruction being executed is jr
            	IF_ID_NPC <=#2 EX_MEM_A+4;
            IF_ID_IR <=#2  I_memory[({2'b00,EX_MEM_A[31:2]})];
            	pc<=#2 EX_MEM_A+4;
             	branch_taken<=#2 1;
          end
           
          else // if instruction being executed is nonbranching inst.
          begin
          		IF_ID_NPC <=#2  pc+4;
            IF_ID_IR <= #2 I_memory[({2'b00,pc[31:2]})];
           	pc<=#2 pc+4;
            
          end       
            
        end
     end
////////////////////////////////////////////////////////////
 
  //stage 2 */ Instruction decode and reg fetch (ID) /*////
  always @(posedge clk2)
    begin 
      if (halted==0)
        begin
      	  ID_EX_IR<=#2 IF_ID_IR;
          ID_EX_NPC<=#2 IF_ID_NPC;
          ID_EX_IMM <= #2 {{16{IF_ID_IR[15]}},{IF_ID_IR[15:0]}};
          //extending imm field to 32 bits
          
          if (IF_ID_IR[25:21]==5'b00000)//tryin to access reg zero?!
            ID_EX_A <=#2  0;//else read1_A=reg_file[reg_address]
          else ID_EX_A <=#2 reg_file[IF_ID_IR[25:21]];
        
          if (IF_ID_IR[20:16]==5'b00000)//tryin to access reg zero?!
            ID_EX_B <=#2  0;//else read2_B=reg_file[reg_address]
          else ID_EX_B <=#2  reg_file[IF_ID_IR[20:16]];
     
        
        end
    end
///////////////////////////////////////////////////////////
  //stage 3 */ execution and effective addr calc (EX) /*////
  always @(posedge clk1)
    begin 
      if (halted==0)
        begin
      	 	    	
      
          EX_MEM_ALUresult<=#2 32'hDEADBEEF;//initialization(avoid latching)
          case (ID_EX_IR[31:26])//opcode
	        R_format:
	        begin
              case (ID_EX_IR[5:0]) //func
                //shamt=ID_EX_IR[10:6]
	         0:	EX_MEM_ALUresult<=#2 ID_EX_B<<ID_EX_IR[10:6] ; 	//sll
	         2:	EX_MEM_ALUresult<=#2 ID_EX_B>>ID_EX_IR[10:6] ; 	//srl
             3:	EX_MEM_ALUresult<=#2 $signed(ID_EX_B)>>>ID_EX_IR[10:6] ; 	//sra
	            32: EX_MEM_ALUresult<=#2 ID_EX_A+ID_EX_B ;	//add
	            34: EX_MEM_ALUresult<=#2 ID_EX_A-ID_EX_B ; 	//sub
	            36: EX_MEM_ALUresult<=#2 ID_EX_A&ID_EX_B ; 	//and
	            37: EX_MEM_ALUresult<=#2 ID_EX_A|ID_EX_B ; 	//or
	            38: EX_MEM_ALUresult<=#2 ID_EX_A^ID_EX_B ; 	//xor
                39: EX_MEM_ALUresult<=#2  ~(ID_EX_A|ID_EX_B) ; 	//nor
	            42: EX_MEM_ALUresult<=#2 $signed(ID_EX_A)<$signed(ID_EX_B) ; 	//slt
	            endcase
	        end

	        addi,lw,sw: EX_MEM_ALUresult<=#2 ID_EX_A+ID_EX_IMM; //addi, loads, stores
	        beq,bne: EX_MEM_ALUresult<=#2 ID_EX_A-ID_EX_B; //beq, bne
	        andi: EX_MEM_ALUresult<=#2 ID_EX_A&ID_EX_IMM; //andi
	        ori: EX_MEM_ALUresult<=#2 ID_EX_A|ID_EX_IMM; //ori
	        xori: EX_MEM_ALUresult<=#2 ID_EX_A^ID_EX_IMM; //xori
	        slti: EX_MEM_ALUresult<=#2 $signed(ID_EX_A)<$signed(ID_EX_IMM); //slti
	        lui: EX_MEM_ALUresult<=#2 ID_EX_IMM<<16; //lui
        endcase
         EX_MEM_IR<=#2 ID_EX_IR;
         	EX_MEM_NPC<=#2 ID_EX_NPC;
			EX_MEM_A<=#2 ID_EX_A;
         	EX_MEM_B<=#2 ID_EX_B;
            EX_MEM_BranchAdrr<=#2 ID_EX_NPC+(ID_EX_IMM<<2);
          EX_MEM_JumpAdrr<=#2 {ID_EX_NPC[31:28],ID_EX_IR[25:0],2'b00};
        end
    end
///////////////////////////////////////////////////////////
 
  //stage 4 */ Memory access and branch checking (MEM) /*////
  always @(posedge clk2)
    begin 
      if (halted==0)
        begin
      
          if (EX_MEM_IR[31:26]==lw)
            MEM_WB_RDM<=#2 D_memory[EX_MEM_ALUresult>>2];
          
          else if((EX_MEM_IR[31:26]==sw)&&(branch_taken==0))
					//disable writing if there is abranch
            D_memory[EX_MEM_ALUresult>>2]<=#2 EX_MEM_B;
      
        	MEM_WB_IR<=#2 EX_MEM_IR;
        MEM_WB_NPC<=#2 EX_MEM_NPC;
          MEM_WB_ALUresult<=#2 EX_MEM_ALUresult;
          
        end
    end
///////////////////////////////////////////////////////////
  
  //stage 5  register write back stage (WB) ///////////
  always @(posedge clk1)
    begin
      if (branch_taken==0)
         	 begin
        case (MEM_WB_IR[31:26])
          hlt : halted<=#2 1'b1;
          R_format : reg_file [MEM_WB_IR[15:11]]<=#2 MEM_WB_ALUresult;
  addi,andi,slti,ori,xori,lui : reg_file [MEM_WB_IR[20:16]]<=#2 MEM_WB_ALUresult;
          lw :  reg_file [MEM_WB_IR[20:16]]<=#2 MEM_WB_RDM;
            jal : reg_file[31]<=#2 MEM_WB_NPC;//current pc+4
           
                
            endcase
    end
    end
///////////////////////////////////////////////////////////


endmodule