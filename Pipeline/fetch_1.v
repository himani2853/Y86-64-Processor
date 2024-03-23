module fetch_1(
  input clk,
  input [63:0] F_predPC,
  input [3:0] M_icode,
  input M_Cnd,
  input [63:0] M_valA,
  input [3:0] W_icode,
  input [63:0] W_valM,
  input F_stall,
  input D_stall,
  input D_bubble,
  // input [63:0] m_valM,
//   output reg [63:0] f_pc,
  output reg [63:0] f_predPC,
  output reg [1:0] D_stat,
  output reg [3:0] D_icode,
  output reg [3:0] D_ifun,
  output reg [3:0] D_rA,
  output reg [3:0] D_rB,
  output reg [63:0] D_valC,
  output reg [63:0] D_valP
);

reg [7:0] memory_instruction[0:1023];
reg [0:79] instruction_set;
reg [0:71] instruction_set_jc;
reg imem_error;
reg instr_valid;
reg [63:0] Need_valC;
reg [63:0] Need_regis;
reg [3:0] icode;
reg [3:0] ifun;
reg [3:0] rA;
reg [3:0] rB;
reg [63:0] valC;
reg [63:0] valP;
reg [1:0] f_stat;
reg [63:0] f_pc;
reg or_check_1;
reg or_check_2;
reg or_out_check;


initial begin
    $readmemb("2.txt",memory_instruction);
    #10;
end

// initial begin
//   #200
//   D_icode = 4'd0;
// end

initial begin
    imem_error <= 1'b0;
    instr_valid <= 1'b0;
    Need_regis <= 64'd0;
    Need_valC <= 64'd0;
    icode <= 4'hf;
    ifun <= 4'hf;
    rA <= 4'hf;
    rB <= 4'hf;
    valC <= 64'd0;
    valP <= 64'd0;
    f_stat <= 2'b0;
    f_pc = 64'd0;
end

always @(*) begin
    if(M_icode == 4'b0111 && M_Cnd == 1'b0) 
    begin
        f_pc = M_valA;
    end   
    else if (W_icode == 4'b1001)// W_icode or M_icode
    begin
        f_pc = W_valM;
    end
    else
    begin
        f_pc = F_predPC;
    end
end

always @(*) begin
  // f_stat = 2'b00;
        imem_error = 0;
        if(f_pc>64'd1024)
        begin
          imem_error = 1'b1;
          f_stat = 2'b11;
        end
    
    else
    begin

        instruction_set = {memory_instruction[f_pc], memory_instruction[f_pc+1], memory_instruction[f_pc+9],memory_instruction[f_pc+8], memory_instruction[f_pc+7],memory_instruction[f_pc+6], memory_instruction[f_pc+5], memory_instruction[f_pc+4], memory_instruction[f_pc+3],memory_instruction[f_pc+2]};
        icode = instruction_set[0:3];
        ifun = instruction_set[4:7];

        
      if(icode == 4'b0111 | icode == 4'b1000)
      begin
        instruction_set_jc = {memory_instruction[f_pc],memory_instruction[f_pc+8],memory_instruction[f_pc+7],memory_instruction[f_pc+6],memory_instruction[f_pc+5],memory_instruction[f_pc+4],memory_instruction[f_pc+3],memory_instruction[f_pc+2],memory_instruction[f_pc+1]};
        icode = instruction_set_jc[0:3];
        ifun = instruction_set_jc[4:7];
      end


// Split
    
    Need_regis=64'd0;
    Need_valC=64'd0;
    imem_error = 1'b0;


// Align
    or_check_1 = (icode<4'd0);
    or_check_2 = (icode>4'd11);
    if(or_out_check == 1'b1)
    begin
      instr_valid = 1'b0;
      f_stat = 2'b11;
    end

    else
    begin
      // initialize valC with smtg
    // instr_valid = 1'b1;
    if(icode == 4'b0000)//halt
    begin
      instr_valid = 1'b1;
      valP = f_pc + 64'd1 + Need_regis + 8*Need_valC;
      f_stat = 2'b01;
      f_predPC = valP;
    end


    else if(icode == 4'b0001)//nop
    begin
      instr_valid = 1'b1;
      valP = f_pc + 64'd1 + Need_regis + 8*Need_valC;
      f_predPC = valP;
    end


    else if(icode == 4'b0010)//rrmovq
    begin
      instr_valid = 1'b1;
      Need_regis = 64'd1;  
      rA = instruction_set[8:11];
      rB = instruction_set[12:15];
      // valC = instruction_set[16:79];
      valP = f_pc + 64'd1 + Need_regis + 8*Need_valC;
      f_predPC = valP;
    end


    else if(icode == 4'b0011)//irmovq
    begin
      instr_valid = 1'b1;
      Need_regis = 64'd1;  
      rA = instruction_set[8:11];
      rB = instruction_set[12:15];
      valC = instruction_set[16:79];
      Need_valC = 64'd1;
      valP = f_pc + 64'd1 + Need_regis + 8*Need_valC;
      f_predPC = valP;
    end


    else if(icode == 4'b0100)//rmmovq
    begin
      instr_valid = 1'b1;
      Need_regis = 64'd1;  
      rA = instruction_set[8:11];
      rB = instruction_set[12:15];
      valC = instruction_set[16:79];
      Need_valC = 64'd1;
      valP = f_pc + 64'd1 + Need_regis + 8*Need_valC; 
      f_predPC = valP;
    end


    else if(icode == 4'b0101)//mrmovq
    begin
      instr_valid = 1'b1;
      Need_regis = 64'd1;  
      rA = instruction_set[8:11];
      rB = instruction_set[12:15];
      valC = instruction_set[16:79];
      Need_valC = 64'd1;
      valP = f_pc + 64'd1 + Need_regis + 8*Need_valC;
      f_predPC = valP;
    end


    else if(icode == 4'b0110)//opq
    begin
      instr_valid = 1'b1;
      Need_regis = 64'd1;  
      rA = instruction_set[8:11];
      rB = instruction_set[12:15];
      // valC = instruction_set[16:79];
      valP = f_pc + 64'd1 + Need_regis + 8*Need_valC;
      f_predPC = valP;
    end


    else if(icode == 4'b0111)//jxx
    begin
      instr_valid = 1'b1;
      // instruction_set[16:23] = 8'd0;
      // valC = instruction_set[8:71];
      valC = instruction_set_jc[8:71];
      Need_valC = 64'd1;
      valP = f_pc + 64'd1 + Need_regis + 8*Need_valC;
      f_predPC = valC;   
    end


    else if(icode == 4'b1000)//call
    begin
      instr_valid = 1'b1;
      // instruction_set[16:23] = 8'd0;
      valC = instruction_set_jc[8:71];
      Need_valC = 64'd1;
      valP = f_pc + 64'd1 + Need_regis + 8*Need_valC;
      f_predPC = valC;
    end


    else if(icode == 4'b1001)//ret
    begin
      instr_valid = 1'b1;
      // valC = instruction_set[16:79];
      valP = f_pc + 64'd1 + Need_regis + 8*Need_valC;
      // f_predPC = f_pc;
    end


    else if(icode == 4'b1010)//pushq
    begin
      instr_valid = 1'b1;
      Need_regis = 64'd1;  
      rA = instruction_set[8:11];
      rB = instruction_set[12:15];
      // valC = instruction_set[16:79];
      valP = f_pc + 64'd1 + Need_regis + 8*Need_valC;
      f_predPC = valP;
    end


    else if(icode == 4'b1011)//popq
    begin
      instr_valid = 1'b1;
      Need_regis = 64'd1;  
      rA = instruction_set[8:11];
      rB = instruction_set[12:15];
      // valC = instruction_set[16:79];
      valP = f_pc + 64'd1 + Need_regis + 8*Need_valC;
      f_predPC = valP;
    end


    else
    begin
      instr_valid = 1'b0;
      f_stat = 2'b11;
    end

  end
end

// if(instr_valid == 1'b0)
// begin
//   f_stat = 2'b11;
// end 
// else
// begin
//   f_stat = 2'b00;
// end   // $display($time," icode = %d", icode);
// // $display("f_stat =%d",f_stat);
end

always @(posedge clk) begin
      // $display("D_stall = %d, D_bubble = %d", D_stall, D_bubble);
    if(D_stall != 1'b1 && D_bubble != 1'b1)
    begin
        D_icode <= icode;
        D_ifun <= ifun;
        D_rA <= rA;
        D_rB <= rB;
        D_stat <= f_stat;
        D_valC <= valC;
        D_valP <= valP; 
        // $display($time," D_icode = %d, icode =%d, D_stall1 = %d, F_stall1 = %d, D_bubble = %d",D_icode,icode,D_stall,F_stall,D_bubble);
    end

    else if(D_stall == 1'b1)
    begin
      // $display($time," D_icode = %d, D_stall2 = %d, F_stall2 = %d",D_icode,D_stall,F_stall);
        // F_predPC <= f_predPC;
    end

    else if(D_bubble == 1'b1)
    begin
        D_icode <= 4'b0001;
        D_ifun <= 4'b0000;
        D_rA <= 4'hf;
        D_rB <= 4'hf;
        D_stat <= 2'b00;
        D_valC <= 64'd0;
        D_valP <= 64'd0; 
        // $display($time," D_icode = %d, D_stall3 = %d, F_stall3 = %d, D_bubble = %d",D_icode,D_stall,F_stall,D_bubble);
    end
    // $display($time," D_icode = %d, D_stall = %d, F_stall = %d",D_icode,D_stall,F_stall);
end


endmodule