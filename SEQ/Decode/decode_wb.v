module decode_wb(
  input clk,
  input Cnd,
  input [3:0] icode,
  input [3:0] rA,
  input [3:0] rB,
  output reg [63:0] valA,
  output reg [63:0] valB,
  input [63:0] valE,
  input [63:0] valM,

  output reg [63:0] rax,
  output reg [63:0] rcx,
  output reg [63:0] rdx,
  output reg [63:0] rbx,
  output reg [63:0] rsp,
  output reg [63:0] rbp,
  output reg [63:0] rsi,
  output reg [63:0] rdi,
  output reg [63:0] r8,
  output reg [63:0] r9,
  output reg [63:0] r10,
  output reg [63:0] r11,
  output reg [63:0] r12,
  output reg [63:0] r13,
  output reg [63:0] r14,
  output reg [63:0] rnone
);
  reg [63:0] register_file[0:15];

  initial begin
    register_file[0]=64'd0;
    register_file[1]=64'd1;
    register_file[2]=64'd2;
    register_file[3]=64'd3;
    register_file[4]=64'd4;
    register_file[5]=64'd5;
    register_file[6]=64'd6;
    register_file[7]=64'd7;
    register_file[8]=64'd8;
    register_file[9]=64'd9;
    register_file[10]=64'd10;
    register_file[11]=64'd11;
    register_file[12]=64'd12;
    register_file[13]=64'd13;
    register_file[14]=64'd14;
  end

  //decode
  always@(*)
  begin
       if(clk ==1)
    begin
    if(icode == 4'b0010) //cmovxx
    begin
      valA = register_file[rA];
      valB = 64'd0;
    end
    else if(icode == 4'b0011) //irmovq
    begin
      valA = register_file[15];
      valB = 64'd0;
      // valB = register_file[rB];
    end
    else if(icode == 4'b0100) //rmmovq 
    begin
      valA = register_file[rA];
      valB = register_file[rB];
    end
    else if(icode == 4'b0101) //mrmovq
    begin
      valA = register_file[15];
      valB = register_file[rB];
    end
    else if(icode == 4'b0110) // opq
    begin
      valA = register_file[rA];
      valB = register_file[rB];
    end
    else if(icode == 4'b1010) // pushq
    begin
      valA = register_file[rA];
      valB = register_file[4];
    end
    else if(icode == 4'b1011) // popq
    begin
      valA = register_file[4];
      valB = register_file[4];
    end
    else if(icode == 4'b1000) // call
    begin
      valA = register_file[15];
      valB = register_file[4];
    end
    else if(icode == 4'b1001) // ret
    begin
      valA = register_file[4];
      valB = register_file[4];
    end
    end
    
    rax=register_file[0];
    rcx=register_file[1];
    rdx=register_file[2];
    rbx=register_file[3];
    rsi=register_file[4];
    rbp=register_file[5];
    rsi=register_file[6];
    rdi=register_file[7];
    r8=register_file[8];
    r9=register_file[9];
    r10=register_file[10];
    r11=register_file[11];
    r12=register_file[12];
    r13=register_file[13];
    r14=register_file[14];
  end

  //write_back
  

always @(negedge clk) begin
  //  if(clk==0)
    // begin
        if(icode == 4'b0010) //cmovxx
    begin
        if(Cnd == 1'b1)
        begin
          register_file[rB] <= valE;
        end
    end

    else if(icode == 4'b0011) //irmovq
    begin
      register_file[rB] <= valE;
    end
    // else if(icode == 4'b0100) //rmmovq 
    // begin
    //   valA = register_file[rA];
    //   valB = register_file[rB];
    // end
    
    else if(icode == 4'b0101) //mrmovq
    begin
      register_file[rA] <= valM;
    end
   
    else if(icode == 4'b0110) // opq
    begin
      register_file[rB] <= valE;
    end
    
    else if(icode == 4'b1010) // pushq
    begin
      register_file[4] <= valE;
    end
   
    else if(icode == 4'b1011) // popq
    begin
      register_file[rA] <= valM;
      register_file[4] <= valE;
    end
    
    else if(icode == 4'b1000) // call
    begin
    //   valA = register_file[rA];
      register_file[4] <= valE;
    end
   
    else if(icode == 4'b1001) // ret
    begin
      register_file[4] <= valE;
    end
    rax=register_file[0];
    rcx=register_file[1];
    rdx=register_file[2];
    rbx=register_file[3];
    rsi=register_file[4];
    rbp=register_file[5];
    rsi=register_file[6];
    rdi=register_file[7];
    r8=register_file[8];
    r9=register_file[9];
    r10=register_file[10];
    r11=register_file[11];
    r12=register_file[12];
    r13=register_file[13];
    r14=register_file[14];
  end

endmodule