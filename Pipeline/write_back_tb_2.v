`include "fetch_1.v"
`include "decode_up.v"
// `include "decode_write_back.v"
`include "execute.v"
`include "memory.v"
`include "write_back.v"

module write_back_tb_2;
reg clk;
reg [63:0] F_predPC;
wire [3:0] M_icode;
wire M_Cnd;
wire [63:0] M_valA;
wire [3:0] W_icode;
wire [63:0] W_valM;
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
wire [3:0] W_dstM;
wire [3:0] W_dstE;

wire [63:0] e_valE;
wire [63:0] m_valM;
wire [63:0] M_valE;
wire [63:0] W_valE;

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

wire [1:0] W_stat;
wire [1:0] m_stat;
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

// wire [1:0] W_stat;
// wire [3:0] W_icode;
// wire [63:0] W_valE;
// wire [63:0] W_valM;
// wire [3:0] W_dstE;
// wire [3:0] W_dstM;
// wire [63:0] m_valM;
// wire [1:0] m_stat;
wire dmem_error;
wire mem_read;
wire mem_write;

wire signed [63:0] rax;
wire signed [63:0] rcx;
wire signed [63:0] rdx;
wire signed [63:0] rbx;
wire signed [63:0] rsp;
wire signed [63:0] rbp;
wire signed [63:0] rsi;
wire signed[63:0] rdi;
wire signed [63:0] r8;
wire signed [63:0] r9;
wire signed [63:0] r10;
wire signed [63:0] r11;
wire signed [63:0] r12;
wire signed [63:0] r13;
wire signed [63:0] r14;
wire signed [63:0] rnone;
// wire [63:0] d_valA;
// wire [63:0] d_valB;

fetch_1 fetch_(clk, F_predPC,M_icode,M_Cnd,M_valA,W_icode,W_valM,F_stall,D_stall,D_bubble,f_predPC,D_stat,D_icode, D_ifun, D_rA, D_rB, D_valC, D_valP);

decode_up decode_(clk,D_icode,D_ifun,D_rA,D_rB,D_valC,D_valP,D_stat,e_dstE,M_dstM, M_dstE, W_dstM, W_dstE, e_valE, m_valM, M_valE, W_valM, W_valE, E_bubble, d_srcA, d_srcB, E_icode, E_ifun, E_valA, E_valB, E_valC, E_dstE, E_dstM, E_srcA, E_srcB, E_stat);
// decode_write_back decode_write_back_(clk,D_stat,D_icode,D_ifun,D_rA,D_rB,D_valC,D_valP,e_dstE,e_valE,M_dstE,M_dstM,M_valE,m_valM,W_dstM,W_valM,W_dstE,W_valE,E_bubble,W_icode,d_srcA,d_srcB,d_valA,d_valB,E_stat,E_icode,E_ifun,E_valC,E_valA,E_valB,E_dstE,E_dstM,E_srcA,E_srcB,rax,rcx,rdx,rbx,rsp,rbp,rsi,rdi,r8,r9,r10,r11,r12,r13,r14,rnone);
execute execute_(clk,E_stat,E_icode,E_ifun,E_valC,E_valA,E_valB,E_dstE,E_dstM,W_stat,m_stat,set_cc,M_bubble,M_stat,M_icode,M_Cnd,M_valE,M_valA,M_dstE,M_dstM,e_Cnd,e_valE,e_dstE);

memory memory_(clk,M_icode,M_stat,M_Cnd,M_valE,M_valA,M_dstE,M_dstM,W_stall,W_stat,W_icode,W_valE,W_valM,W_dstE,W_dstM,m_valM,m_stat,dmem_error,mem_read,mem_write);

write_back write_back_(clk,W_stat,W_icode,W_valE,W_valM,W_dstE,W_dstM);

always begin
    #10 clk = ~clk;
end

always@(W_icode)
if(W_icode == 4'd0)begin
    $finish;
end

always @(posedge clk)begin
    F_predPC <= f_predPC; 
end

initial begin
    $dumpfile("write_back_tb_2.vcd");
    $dumpvars(0,write_back_tb_2);
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
    $monitor($time,"clk = %d,\n\t\t\t F_predPC = %d, f_pc = %d, \n\t\t D_icode = %d, D_ifun = %d, D_rA = %d, D_rB = %d, D_valC = %d, D_valP = %d, D_stat = %d, \n\t\t E_icode = %d, E_ifun = %d, E_valA = %d, E_valB = %d, E_valC = %d, E_dstE = %d, E_dstM = %d, E_srcA = %d, E_srcB = %d, E_stat = %d,\n\t\tM_stat = %d, M_icode = %d, M_Cnd = %d, M_valE = %d, M_valA = %d, M_dstE = %d, M_dstM = %d, W_stat = %d, W_icode = %d, W_valE = %d, W_valM = %d, W_dstE = %d, W_dstM = %d, dmem_error = %d, mem_read = %d, mem_write = %d",clk,F_predPC,f_predPC,D_icode,D_ifun,D_rA,D_rB,D_valC,D_valP,D_stat,E_icode,E_ifun,E_valA,E_valB,E_valC,E_dstE,E_dstM,E_srcA,E_srcB,E_stat,M_stat,M_icode,M_Cnd,M_valE, M_valA,M_dstE, M_dstM, W_stat,W_icode,W_valE,W_valM,W_dstE,W_dstM,dmem_error,mem_read, mem_write);
end

endmodule