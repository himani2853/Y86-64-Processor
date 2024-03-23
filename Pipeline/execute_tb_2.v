`include "fetch_1.v"
`include "decode_up.v"
`include "execute.v"
module execute_tb_2;
reg clk;
reg [63:0] F_predPC;
wire [3:0] M_icode;
wire M_Cnd;
wire [63:0] M_valA;
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

wire [3:0] e_dstE;
wire [3:0] M_dstM;
wire [3:0] M_dstE;
reg [3:0] W_dstM;
reg [3:0] W_dstE;

wire [63:0] e_valE;
reg [63:0] m_valM;
wire [63:0] M_valE;
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

reg W_stat;
reg m_stat;
reg set_cc;
reg M_bubble;

wire [1:0] M_stat;
// wire [3:0] M_icode;
// wire M_Cnd;
// wire signed [63:0] M_valE;
// wire signed [63:0] M_valA;
// wire [3:0] M_dstE;
// wire [3:0] M_dstM;
wire e_Cnd;
// wire signed [63:0] e_valE;
// wire [63:0] e_dstE;

fetch_1 fetch_(clk, F_predPC,M_icode,M_Cnd,M_valA,W_icode,W_valM,F_stall,D_stall,D_bubble,f_predPC,D_stat,D_icode, D_ifun, D_rA, D_rB, D_valC, D_valP);

decode_up decode_(clk,D_icode,D_ifun,D_rA,D_rB,D_valC,D_valP,D_stat,e_dstE,M_dstM, M_dstE, W_dstM, W_dstE, e_valE, m_valM, M_valE, W_valM, W_valE, E_bubble, d_srcA, d_srcB, E_icode, E_ifun, E_valA, E_valB, E_valC, E_dstE, E_dstM, E_srcA, E_srcB, E_stat);

execute execute_(clk,E_stat,E_icode,E_ifun,E_valC,E_valA,E_valB,E_dstE,E_dstM,W_stat,m_stat,set_cc,M_bubble,M_stat,M_icode,M_Cnd,M_valE,M_valA,M_dstE,M_dstM,e_Cnd,e_valE,e_dstE);


always begin
    #10 clk = ~clk;
end

always@(E_icode)
if(M_icode == 4'd0)begin
    $finish;
end

always @(posedge clk)begin
    F_predPC <= f_predPC;
end

initial begin
    $dumpfile("decode_tb_2.vcd");
    $dumpvars(0,execute_tb_2);
end

initial begin
    F_predPC = 64'd0;
    clk = 0;
    F_stall = 0;
    D_stall = 0;
    D_bubble = 0;
    E_bubble = 0;
    set_cc = 1;
end

initial begin
    $monitor($time,"clk = %d,\n\t\t\t F_predPC = %d, f_pc = %d, \n\t\t D_icode = %d, D_ifun = %d, D_rA = %d, D_rB = %d, D_valC = %d, D_valP = %d, D_stat = %d, \n\t\t E_icode = %d, E_ifun = %d, E_valA = %d, E_valB = %d, E_valC = %d, E_dstE = %d, E_dstM = %d, E_srcA = %d, E_srcB = %d, E_stat = %d,\n\t\tM_stat = %d, M_icode = %d, M_Cnd = %d, M_valE = %d, M_valA = %d, M_dstE = %d, M_dstM = %d ",clk,F_predPC,f_predPC,D_icode,D_ifun,D_rA,D_rB,D_valC,D_valP,D_stat,E_icode,E_ifun,E_valA,E_valB,E_valC,E_dstE,E_dstM,E_srcA,E_srcB,E_stat,M_stat,M_icode,M_Cnd,M_valE, M_valA,M_dstE, M_dstM);
end

endmodule