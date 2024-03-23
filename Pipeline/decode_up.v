module decode_up(
    input clk,
    input [3:0] D_icode,
    input [3:0] D_ifun,
    input [3:0] D_rA,
    input [3:0] D_rB,
    input signed [63:0] D_valC,
    input [63:0] D_valP,
    input [1:0] D_stat,
    input [3:0] e_dstE,
    input [3:0] M_dstM,
    input [3:0] M_dstE,
    input [3:0] W_dstM,
    input [3:0] W_dstE,
    input signed [63:0] e_valE,
    input [63:0] m_valM,
    input [63:0] M_valE,
    input signed [63:0] W_valM,
    input signed [63:0] W_valE,
    input E_bubble,
    output reg [3:0] d_srcA,
    output reg [3:0] d_srcB,
    output reg [3:0] E_icode,
    output reg [3:0] E_ifun,
    output reg signed [63:0] E_valA,
    output reg signed [63:0] E_valB,
    output reg signed [63:0] E_valC,
    // output reg signed [63:0] valA,
    // output reg signed [63:0] valB,
    output reg [3:0] E_dstE,
    output reg [3:0] E_dstM,
    output reg [3:0] E_srcA,
    output reg [3:0] E_srcB,
    output reg [1:0] E_stat
 );


 reg [63:0] register_file [0:15];
 reg [3:0] d_dstE;
 reg [3:0] d_dstM;
 reg [63:0] valA;
 reg [63:0] valB;
 reg signed [63:0] rax;
 reg signed [63:0] rcx;
 reg signed [63:0] rdx;
 reg signed [63:0] rbx;
 reg signed [63:0] rsp;
 reg signed [63:0] rbp;
 reg signed [63:0] rsi;
 reg signed [63:0] rdi;
 reg signed [63:0] r8;
 reg signed [63:0] r9;
 reg signed [63:0] r10;
 reg signed [63:0] r11;
 reg signed [63:0] r12;
 reg signed [63:0] r13;
 reg signed [63:0] r14;
 reg signed [63:0] rnone;

 initial begin
    rax <= 64'd0;
    rcx <= 64'd0;
    rdx <= 64'd0;
    rbx <= 64'd0;
    rsp <= 64'd0;
    rbp <= 64'd0;
    rsi <= 64'd0;
    rdi <= 64'd0;
    r8 <= 64'd0;
    r9 <= 64'd0;
    r10 <= 64'd0;
    r11 <= 64'd0;
    r12 <= 64'd0;
    r13 <= 64'd0;
    r14 <= 64'd0;
    rnone <= 64'd0;
 end

always @(*) begin
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
    rnone <= register_file[15];
end

initial begin
    valA = 64'd0;
    valB = 64'd0;
end
//  initial begin
//     $readmemh("reg_file.txt",register_file);
//  end
always @(posedge clk ) begin
    $readmemh("reg_file.txt",register_file);
end

//  always @(posedge clk)begin
//     E_icode <= D_icode;
//     E_ifun <= D_ifun;
//     E_stat <= D_stat;
//     E_valC <= D_valC;
//  end

always @(*)begin
    d_srcA = 4'hf;
    d_srcB = 4'hf;
    d_dstE = 4'hf;
    d_dstE = 4'hf;

    
    if(D_icode == 4'd2)begin//cmovxx
        d_srcA = D_rA;
        d_srcB = 4'hf;//
        d_dstE = D_rB;
        d_dstM = 4'hf;//
        valA = register_file[D_rA];
        // E_valB = register_file[4'hf];  //0 //////////
    end
    else if(D_icode == 4'd3)begin//irmovq
        d_srcA = 4'hf;//
        d_srcB = 4'hf;//
        d_dstE = D_rB;
        d_dstM = 4'hf;//
        //valA = 4'hf;
        //valB = 4'hf;
    end
    else if(D_icode == 4'd4)begin//rmmovq
        d_srcA = D_rA;
        d_srcB = D_rB;//4'hf/////////////////////////////////////////////
        d_dstE = D_rB;//
        d_dstM = 4'hf;//
        valA = register_file[D_rA];
        valB = register_file[D_rB];
    end
    else if(D_icode == 4'd5)begin//mrmovq
        d_srcA = 4'hf;//
        d_srcB = D_rA;
        d_dstE = 4'hf;//
        d_dstM = D_rA; //
        // valA = register_file[4'hf];
        valB = register_file[D_rB];
    end
    else if(D_icode == 4'd6)begin//opq
        d_srcA = D_rA;
        d_srcB = D_rB;
        d_dstE = D_rB;
        d_dstM = 4'hf;//
        valA = register_file[D_rA];
        valB = register_file[D_rB];
    end
    else if(D_icode == 4'd8)begin//call
        d_srcA = 4'hf;//
        d_srcB = 4'd4;
        d_dstE = 4'd4;
        d_dstM = 4'hf;//
        //valA = register_file[4'hf];
        valB = register_file[4];
    end
    else if(D_icode == 4'd9)begin//return
        d_srcA = 4'd4;
        d_srcB = 4'd4;
        d_dstE = 4'd4;
        d_dstM = 4'd4;//4'hf////////////////////////////////////
        valA = register_file[4];
        valB = register_file[4];
    end
    else if(D_icode == 4'd10)begin// pushq
        d_srcA = D_rA;
        d_srcB = 4'd4;
        d_dstE = 4'd4;
        d_dstM = 4'hf;//
        valA = register_file[D_rA];
        valB = register_file[4];
    end
    else if(D_icode == 4'd11)begin//popq
        d_srcA = 4'd4;
        d_srcB = 4'd4;
        d_dstE = 4'd4;
        d_dstM = D_rA;
        valA = register_file[4];
        valB = register_file[4];
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
        valA = D_valP;
    end
 else if (d_srcA == e_dstE && e_dstE != 4'hf)
    begin
        valA = e_valE;
    end
 else if (d_srcA == M_dstM && M_dstM!= 4'hf)
    begin
        valA = m_valM;
    end
 else if (d_srcA == M_dstE && M_dstE != 4'hf)
    begin
        valA = M_valE;
    end
 else if (d_srcA == W_dstM && W_dstM != 4'hf)
    begin
        valA = W_valM;
    end
 else if (d_srcA == W_dstE && W_dstE != 4'hf)
    begin
        valA = W_valE;
    end
 else
    begin
        valA = valA;
    end
end
        
always@(*)begin
    if(d_srcB == e_dstE && e_dstE != 4'hf)
        begin
            valB = e_valE;
        end
    else if(d_srcB == M_dstM && M_dstM != 4'hf)
        begin
            valB = m_valM;
        end
    else if(d_srcB == M_dstE && M_dstE != 4'hf)
        begin
            valB = M_valE;
        end
    else if(d_srcB == W_dstM && W_dstM!= 4'hf)
        begin
            valB = W_valM;
        end
    else if(d_srcB == W_dstE && W_dstE != 4'hf)
        begin
            valB = W_valE;
        end
    else
        begin
            valB =valB;
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
        E_valA <= valA;
        E_valB <= valB;
        E_srcA <= d_srcA;
        E_srcB <= d_srcB;
        E_dstE <= d_dstE;
        E_dstM <= d_dstM;
    end
    end

endmodule