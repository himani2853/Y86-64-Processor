module fetch(
    input clk,
    input [63:0] pc,//address
    output reg [3:0] icode,
    output reg [3:0] ifun,
    output reg [3:0] rA,
    output reg [3:0] rB,
    output reg signed [63:0] valC,
    output reg [63:0] valP,
    output reg imem_error,
    output reg instr_valid,
    output reg halt
);

reg [7:0] memory_instruction[0:41];
reg [0:79] instruction_set;
reg [0:71] instruction_set_jc;
reg [63:0] Need_valC;
reg [63:0] Need_regis;

initial begin
  $readmemb("1.txt",memory_instruction);
  #10;
end


initial begin
  imem_error = 1'b0;
  instr_valid = 1'b1;
  halt = 1'b0;
end

initial begin
  rA = 4'hf;
  rB = 4'hf;
  valC = 64'd0;
end

reg or_check_1;
reg or_check_2;
wire or_out_check;
or (or_out_check,or_check_1,or_check_2);


always @(posedge clk) 
  
     begin
        imem_error = 0;
        if(pc>64'd255)
        begin
          imem_error = 1;
        end
    
    else
    begin

        instruction_set = {memory_instruction[pc], memory_instruction[pc+1], memory_instruction[pc+9],memory_instruction[pc+8], memory_instruction[pc+7],memory_instruction[pc+6], memory_instruction[pc+5], memory_instruction[pc+4], memory_instruction[pc+3],memory_instruction[pc+2]};
        icode = instruction_set[0:3];
        ifun = instruction_set[4:7];
        
      if(icode == 4'b0111 | icode == 4'b1000)
      begin
        instruction_set_jc = {memory_instruction[pc],memory_instruction[pc+8],memory_instruction[pc+7],memory_instruction[pc+6],memory_instruction[pc+5],memory_instruction[pc+4],memory_instruction[pc+3],memory_instruction[pc+2],memory_instruction[pc+1]};
        icode = instruction_set_jc[0:3];
        ifun = instruction_set_jc[4:7];
      end


// Split
    
    Need_regis=64'd0;
    Need_valC=64'd0;
    halt = 1'b0;
    imem_error = 1'b0;


// Align
    or_check_1 = (icode<4'd0);
    or_check_2 = (icode>4'd11);
    if(or_out_check == 1'b1)
    begin
      instr_valid = 1'b0;
    end

    else
    begin
      // initialize valC with smtg
    // instr_valid = 1'b1;
    if(icode == 4'b0000)//halt
    begin
      instr_valid = 1'b1;
      valP = pc + 64'd1 + Need_regis + 8*Need_valC;
      halt = 1;
    end


    else if(icode == 4'b0001)//nop
    begin
      instr_valid = 1'b1;
      valP = pc + 64'd1 + Need_regis + 8*Need_valC;
    end


    else if(icode == 4'b0010)//rrmovq
    begin
      instr_valid = 1'b1;
      Need_regis = 64'd1;  
      rA = instruction_set[8:11];
      rB = instruction_set[12:15];
      // valC = instruction_set[16:79];
      valP = pc + 64'd1 + Need_regis + 8*Need_valC;
    end


    else if(icode == 4'b0011)//irmovq
    begin
      instr_valid = 1'b1;
      Need_regis = 64'd1;  
      rA = instruction_set[8:11];
      rB = instruction_set[12:15];
      valC = instruction_set[16:79];
      Need_valC = 64'd1;
      valP = pc + 64'd1 + Need_regis + 8*Need_valC;
    end


    else if(icode == 4'b0100)//rmmovq
    begin
      instr_valid = 1'b1;
      Need_regis = 64'd1;  
      rA = instruction_set[8:11];
      rB = instruction_set[12:15];
      valC = instruction_set[16:79];
      Need_valC = 64'd1;
      valP = pc + 64'd1 + Need_regis + 8*Need_valC; 
    end


    else if(icode == 4'b0101)//mrmovq
    begin
      instr_valid = 1'b1;
      Need_regis = 64'd1;  
      rA = instruction_set[8:11];
      rB = instruction_set[12:15];
      valC = instruction_set[16:79];
      Need_valC = 64'd1;
      valP = pc + 64'd1 + Need_regis + 8*Need_valC;
    end


    else if(icode == 4'b0110)//opq
    begin
      instr_valid = 1'b1;
      Need_regis = 64'd1;  
      rA = instruction_set[8:11];
      rB = instruction_set[12:15];
      // valC = instruction_set[16:79];
      valP = pc + 64'd1 + Need_regis + 8*Need_valC;
    end


    else if(icode == 4'b0111)//jxx
    begin
      instr_valid = 1'b1;
      // instruction_set[16:23] = 8'd0;
      // valC = instruction_set[8:71];
      valC = instruction_set_jc[8:71];
      Need_valC = 64'd1;
      valP = pc + 64'd1 + Need_regis + 8*Need_valC;   
    end


    else if(icode == 4'b1000)//call
    begin
      instr_valid = 1'b1;
      // instruction_set[16:23] = 8'd0;
      valC = instruction_set_jc[8:71];
      Need_valC = 64'd1;
      valP = pc + 64'd1 + Need_regis + 8*Need_valC;
    end


    else if(icode == 4'b1001)//ret
    begin
      instr_valid = 1'b1;
      // valC = instruction_set[16:79];
      valP = pc + 64'd1 + Need_regis + 8*Need_valC;
    end


    else if(icode == 4'b1010)//pushq
    begin
      instr_valid = 1'b1;
      Need_regis = 64'd1;  
      rA = instruction_set[8:11];
      rB = instruction_set[12:15];
      // valC = instruction_set[16:79];
      valP = pc + 64'd1 + Need_regis + 8*Need_valC;
    end


    else if(icode == 4'b1011)//popq
    begin
      instr_valid = 1'b1;
      Need_regis = 64'd1;  
      rA = instruction_set[8:11];
      rB = instruction_set[12:15];
      // valC = instruction_set[16:79];
      valP = pc + 64'd1 + Need_regis + 8*Need_valC;
    end


    else
    begin
      instr_valid = 1'b0;
    end

  end
end
  
end

endmodule