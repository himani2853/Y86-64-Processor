module decode_write_back(
    input clk,
    input [1:0] D_stat,
    input [3:0] D_icode,
    input [3:0] D_ifun,
    input [3:0] D_rA,
    input [3:0] D_rB,
    input signed [63:0] D_valC,
    input [63:0] D_valP,
    input [3:0] e_dstE,
    input signed [63:0] e_valE,
    input [3:0] M_dstE,
    input [3:0] M_dstM,
    input [63:0] M_valE,
    // input [3:0] M_valM,
    input signed [63:0] m_valM,
    input [3:0] W_dstM,
    input signed [63:0] W_valM,
    input [3:0] W_dstE,
    input signed [63:0] W_valE,
    // input D_bubble,
    input E_bubble,
    input [3:0] W_icode,
    output reg [3:0] d_srcA,
    output reg [3:0] d_srcB,
    output reg [63:0] d_valA,
    output reg [63:0] d_valB,
    output reg [1:0] E_stat,
    output reg [3:0] E_icode,
    output reg [3:0] E_ifun,
    output reg signed [63:0] E_valC,
    output reg signed [63:0] E_valA,
    output reg signed [63:0] E_valB,
    output reg [3:0] E_dstE,
    output reg [3:0] E_dstM,
    output reg [3:0] E_srcA,
    output reg [3:0] E_srcB,
    output reg signed [63:0] rax,
    output reg signed [63:0] rcx,
    output reg signed [63:0] rdx,
    output reg signed [63:0] rbx,
    output reg signed [63:0] rsp,
    output reg signed [63:0] rbp,
    output reg signed [63:0] rsi,
    output reg signed[63:0] rdi,
    output reg signed [63:0] r8,
    output reg signed [63:0] r9,
    output reg signed [63:0] r10,
    output reg signed [63:0] r11,
    output reg signed [63:0] r12,
    output reg signed [63:0] r13,
    output reg signed [63:0] r14,
    output reg signed [63:0] rnone
);
 
  reg [63:0] register_file[0:15];
  reg [63:0] d_rvalA;
  reg [63:0] d_rvalB;
  reg [3:0] d_dstE;
  reg [3:0] d_dstM;

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
    // register_file[15] = 64'd15;
  end



always @(*)begin
    d_srcA = 4'hf;
    d_srcB = 4'hf;
    d_dstE = 4'hf;
    d_dstM = 4'hf;

    if(D_icode == 4'd2)begin//cmovxx
        d_srcA = D_rA;
        d_srcB = 4'hf;//
        d_dstE = D_rB;
        d_dstM = 4'hf;//
        d_rvalA = register_file[D_rA];
        d_rvalB = 64'd0;
        // E_valB = register_file[rnone];  //0 //////////
    end
    else if(D_icode == 4'd3)begin//irmovq
        d_srcA = 4'hf;//
        d_srcB = 4'hf;//
        d_dstE = D_rB;
        d_dstM = 4'hf;//
        d_rvalA = 4'hf;
        d_rvalB = 4'hf;
    end
    else if(D_icode == 4'd4)begin//rmmovq
        d_srcA = D_rA;
        d_srcB = D_rB;//rnone
        // d_dstE = D_rB;// Srihari has nothing // 
        d_dstE = 4'hf;
        d_dstM = 4'hf;//
        d_rvalA = register_file[D_rA];
        d_rvalB = register_file[D_rB];
    end
    else if(D_icode == 4'd5)begin//mrmovq
        d_srcA = 4'hf;//
        d_srcB = D_rB;
        d_dstE = 4'hf;//
        d_dstM = D_rA;
        // d_rvalA = register_file[rnone];// Srihari has nothing
        d_rvalB = register_file[D_rB];
    end
    else if(D_icode == 4'd6)begin//opq
        d_srcA = D_rA;
        d_srcB = D_rB;
        d_dstE = D_rB;
        d_dstM = 4'hf;//
        d_rvalA = register_file[D_rA];
        d_rvalB = register_file[D_rB];
    end
    else if(D_icode == 4'd8)begin//call
        d_srcA = 4'hf;//
        d_srcB = 4'd4;
        d_dstE = 4'd4;
        d_dstM = 4'hf;//
        // d_rvalA = register_file[rnone]; //Srihari has nothing
        d_rvalB = register_file[4];
    end
    else if(D_icode == 4'd9)begin//return
        d_srcA = 4'd4;
        d_srcB = 4'd4;
        d_dstE = 4'd4;
        d_dstM = 4'd4;//rnone// Srihari has d_dstM = 4'hf;
        d_rvalA = register_file[4];
        d_rvalB = register_file[4];
    end
    else if(D_icode == 4'd10)begin// pushq
        d_srcA = D_rA;
        d_srcB = 4'd4;
        d_dstE = 4'd4;
        d_dstM = rnone;//
        d_rvalA = register_file[D_rA];
        d_rvalB = register_file[4];
    end
    else if(D_icode == 4'd11)begin//popq
        d_srcA = 4'd4;
        d_srcB = 4'd4;
        d_dstE = 4'd4;
        d_dstM = D_rA;
        d_rvalA = register_file[4];
        d_rvalB = register_file[4];
    end
    else
    begin
        d_srcA = 4'hf;
        d_srcB = 4'hf;
        d_dstE = 4'hf;
        d_dstM = 4'hf;
    end
end

 always@(*)begin
 if(D_icode == 4'd8 || D_icode == 4'd7)// jmp or call 
    begin
        d_valA = D_valP;
    end
 else if (d_srcA == e_dstE && e_dstE != 4'hf)
    begin
        d_valA = e_valE;
    end
 else if (d_srcA == M_dstM && M_dstM != 4'hf)
    begin
        d_valA = m_valM;
    end
 else if (d_srcA == M_dstE && M_dstE != 4'hf)
    begin
        d_valA = M_valE;
    end
 else if (d_srcA == W_dstM && W_dstM != 4'hf)
    begin
        d_valA = W_valM;
    end
 else if (d_srcA == W_dstE && W_dstE != 4'hf)
    begin
        d_valA = W_valE;
    end
 else
    begin
        d_valA = d_rvalA;
    end
end
        
always@(*)begin
    if(d_srcB == e_dstE && e_dstE != 4'hf)
        begin
            d_valB = e_valE;
        end
    else if(d_srcB == M_dstM && M_dstM != 4'hf)
        begin
            d_valB = m_valM;
        end
    else if(d_srcB == M_dstE && M_dstE != 4'hf)
        begin
            d_valB = M_valE;
        end
    else if(d_srcB == W_dstM && W_dstM!= 4'hf)
        begin
            d_valB = W_valM;
        end
    else if(d_srcB == W_dstE && W_dstE != 4'hf)
        begin
            d_valB = W_valE;
        end
    else
        begin
            d_valB =d_rvalB;
        end
end

always@(posedge clk)begin
    if(E_bubble == 1)
    begin
        E_icode <= 4'd1; 
        E_ifun <= 4'd0;
        E_valA <= 4'd0;
        E_valB <= 4'd0;
        E_valC <= 4'd0;
        E_srcA <= 4'hf;
        E_srcB <= 4'hf;
        E_dstE <= 4'hf;
        E_dstM <= 4'hf;
        E_stat <= 2'd0;
    end
    else
    begin
        E_icode <= D_icode; 
        E_ifun <= D_ifun;
        E_valC <= D_valC;
        E_stat <= D_stat;
        E_valA <= d_valA;
        E_valB <= d_valB;
        E_srcA <= d_srcA;
        E_srcB <= d_srcB;
        E_dstE <= d_dstE;
        E_dstM <= d_dstM;
    end

end




//WRITE_BACK
reg [3:0] icode;
reg [63:0] valE;
reg [63:0] valM;
reg [2:0] w_stat;
reg [3:0] reg_to_writeE;
reg [3:0] reg_to_writeM;


always @(*) begin
    icode <= W_icode;
    valE <= W_valE;
    valM <= W_valM;
    reg_to_writeE <= W_dstE;
    reg_to_writeM <= W_dstM;
end


always @(posedge clk) begin
        if(icode == 4'b0010) //cmovxx
    begin
        register_file[W_dstE] <= valE;
    end

    else if(icode == 4'b0011) //irmovq
    begin
      register_file[W_dstE] <= valE;
    end
    // else if(icode == 4'b0100) //rmmovq 
    // begin
    //   valA = register_file[rA];
    //   valB = register_file[rB];
    // end
    
    else if(icode == 4'b0101) //mrmovq
    begin
      register_file[W_dstM] <= valM;
    end
   
    else if(icode == 4'b0110) // opq
    begin
      register_file[W_dstE] <= valE;
    end
    
    else if(icode == 4'b1010) // pushq
    begin
        // 4 -> W_dstE
      register_file[4] <= valE;
    end
   
    else if(icode == 4'b1011) // popq
    begin
      // 4 -> W_dstE
      register_file[W_dstM] <= valM;
      register_file[4] <= valE;
    end
    
    else if(icode == 4'b1000) // call
    begin
    //   valA = register_file[rA];
    // 4 -> W_dstE
      register_file[4] <= valE;
    end
   
    else if(icode == 4'b1001) // ret
    begin
      // 4 -> W_dstE
      register_file[4] <= valE;
    end  

    rax <= register_file[0];
    rcx <= register_file[1];
    rdx <= register_file[2];
    rbx <= register_file[3];
    rsp <= register_file[4];
    rbp <= register_file[5];
    rsi <= register_file[6];
    rdi <= register_file[7];
    r8 <= register_file[8];
    r9 <= register_file[9];
    r10 <= register_file[10];
    r11 <= register_file[11];
    r12 <= register_file[12];
    r13 <= register_file[13];
    r14 <= register_file[14];
    // rnone <= register_file[15];
end


endmodule