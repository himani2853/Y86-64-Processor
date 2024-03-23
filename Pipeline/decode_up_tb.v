`include "fetch_1.v"
`include "decode_up.v"
module decode_up_tb;
reg clk;
reg [63:0] F_predPC;
reg [3:0] M_icode;
reg M_Cnd;
reg [63:0] M_valA;
reg [3:0] W_icode;
reg [63:0] W_valM;
reg F_stall;
reg D_stall;
reg D_bubble;
wire [63:0] f_predPC;
wire [1:0] D_stat;
wire [3:0] D_icode;
wire [3:0] D_ifun;
wire [3:0] D_rA;
wire [3:0] D_rB;
wire [63:0] D_valC;
wire [63:0] D_valP;

reg [3:0] e_dstE;
reg [3:0] M_dstM;
reg [3:0] M_dstE;
reg [3:0] W_dstM;
reg [3:0] W_dstE;

reg [63:0] e_valE;
reg [63:0] m_valM;
reg [63:0] M_valE;
reg [63:0] W_valE;

reg E_bubble;

wire [3:0] d_srcA;
wire [3:0] d_srcB;
wire [3:0] E_icode;
wire [3:0] E_ifun;
wire [63:0] E_valA;
wire [63:0] E_valB;
wire [63:0] E_valC;

wire [3:0] E_dstE;
wire [3:0] E_dstM;
wire [3:0] E_srcA;
wire [3:0] E_srcB;
wire [1:0] E_stat;

fetch_1 fetch_(clk, F_predPC,M_icode,M_Cnd,M_valA,W_icode,W_valM,F_stall,D_stall,D_bubble,f_predPC,D_stat,D_icode, D_ifun, D_rA, D_rB, D_valC, D_valP);

decode_up decode_(clk,D_icode,D_ifun,D_rA,D_rB,D_valC,D_valP,D_stat,e_dstE,M_dstM, M_dstE, W_dstM, W_dstE, e_valE, m_valM, M_valE, W_valM, W_valE, E_bubble, d_srcA, d_srcB, E_icode, E_ifun, E_valA, E_valB, E_valC, E_dstE, E_dstM, E_srcA, E_srcB, E_stat);

always begin
    #10 clk = ~clk;
end

always@(E_icode)
if(E_icode == 4'd0)begin
    $finish;
end

always @(posedge clk)begin
    F_predPC <= f_predPC;
end

initial begin
    $dumpfile("decode_up_tb.vcd");
    $dumpvars(0,decode_up_tb);
end

initial begin
    F_predPC = 64'd0;
    clk = 0;
    F_stall = 0;
    D_stall = 0;
    D_bubble = 0;
    E_bubble = 0;
end

initial begin
    $monitor($time,"clk = %d, F_predPC = %d, f_pc = %d, D_icode = %d, D_ifun = %d, D_rA = %d, D_rB = %d, D_valC = %d, D_valP = %d, \n\t\t\t\t D_stat = %d, E_icode = %d, E_ifun = %d, E_valA = %d, E_valB = %d, E_valC = %d, E_dstE = %d, E_dstM = %d, E_srcA = %d, E_srcB = %d, E_stat = %d ",clk,F_predPC,f_predPC,D_icode,D_ifun,D_rA,D_rB,D_valC,D_valP,D_stat,E_icode,E_ifun,E_valA,E_valB,E_valC,E_dstE,E_dstM,E_srcA,E_srcB,E_stat);
end

endmodule