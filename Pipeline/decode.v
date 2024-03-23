module decode(
    input clk,
    input [3:0] D_icode,
    input [3:0] D_ifun,
    input [3:0] D_rA,
    input [3:0] D_rB,
    input [63:0] D_valC,
    input [63:0] D_valP,
    input [1:0] D_stat,
    output reg [3:0] E_icode,
    output reg [3:0] E_ifun,
    output reg [63:0] E_valA,
    output reg [63:0] E_valB,
    output reg [63:0] E_valC,
    output reg [3:0] E_dstE,
    output reg [3:0] E_dstM,
    output reg [3:0] E_srcA,
    output reg [3:0] E_srcB,
    output reg [1:0] E_stat
 );

 reg [63:0] register_file [0:15];
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
    $readmemh("reg_file.txt",register_file);
 end

 always @(posedge clk)begin
    E_icode <= D_icode;
    E_ifun <= D_ifun;
    E_stat <= D_stat;
    E_valC <= D_valC;
 end

always @(*)begin
    if(D_icode == 4'd2)begin
        E_srcA = D_rA;
        E_srcB = rnone;
        E_dstE = D_rB;
        E_dstM = rnone;
        E_valA = register_file[D_rA];
        E_valB = register_file[rnone];   
    end
    else if(D_icode == 4'd3)begin
        E_srcA = rnone;
        E_srcB = rnone;
        E_dstE = D_rB;
        E_dstM = rnone;
        E_valA = register_file[rnone];
        E_valB = register_file[rnone];
    end
    else if(D_icode == 4'd4)begin
        E_srcA = D_rA;
        E_srcB = D_rB;
        E_dstE = D_rB;
        E_dstM = rnone;
        E_valA = register_file[D_rA];
        E_valB = register_file[D_rB];
    end
    else if(D_icode == 4'd5)begin
        E_srcA = rnone;
        E_srcB = D_rB;
        E_dstE = rnone;
        E_dstM = D_rA;
        E_valA = register_file[rnone];
        E_valB = register_file[D_rB];
    end
    else if(D_icode == 4'd6)begin
        E_srcA = D_rA;
        E_srcB = D_rB;
        E_dstE = D_rB;
        E_dstM = rnone;
        E_valA = register_file[D_rA];
        E_valB = register_file[D_rB];
    end
    else if(D_icode == 4'd8)begin
        E_srcA = rnone;
        E_srcB = 4'd4;
        E_dstE = 4'd4;
        E_dstM = rnone;
        E_valA = register_file[rnone];
        E_valB = register_file[4];
    end
    else if(D_icode == 4'd9)begin
        E_srcA = 4'd4;
        E_srcB = 4'd4;
        E_dstE = 4'd4;
        E_dstM = 4'd4;
        E_valA = register_file[4];
        E_valB = register_file[4];
    end
    else if(D_icode == 4'd10)begin
        E_srcA = D_rA;
        E_srcB = 4'd4;
        E_dstE = 4'd4;
        E_dstM = rnone;
        E_valA = register_file[D_rA];
        E_valB = register_file[4];
    end
    else if(D_icode == 4'd11)begin
        E_srcA = 4'd4;
        E_srcB = 4'd4;
        E_dstE = 4'd4;
        E_dstM = D_rA;
        E_valA = register_file[4];
        E_valB = register_file[4];
    end
    else
    begin
        E_srcA = rnone;
        E_srcB = rnone;
        E_dstE = rnone;
        E_dstM = rnone;
    end
end

endmodule