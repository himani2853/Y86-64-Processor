module decode_tb;
reg clk;
reg [3:0] D_icode;
reg [3:0] D_ifun;
reg [3:0] D_rA;
reg [3:0] D_rB;
reg [63:0] D_valC;
reg [63:0] D_valP;
reg [1:0] D_stat;
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

decode call1(.clk(clk),.D_icode(D_icode),.D_ifun(D_ifun),.D_rA(D_rA),.D_rB(D_rB),.D_valC(D_valC),.D_valP(D_valP),.D_stat(D_stat),.E_icode(E_icode),.E_ifun(E_ifun),.E_valA(E_valA),.E_valB(E_valB),.E_valC(E_valC),.E_dstE(E_dstE),.E_dstM(E_dstM),.E_srcA(E_srcA),.E_srcB(E_srcB),.E_stat(E_stat));

always begin
    #10 clk = ~clk;
end

initial begin
    $dumpfile("decode_tb.vcd");
    $dumpvars(0,decode_tb);
end

initial begin
    clk = 1'b0;
    D_icode = 4'd0;
    D_ifun = 4'd0;
    D_rA = 4'd0;
    D_rB = 4'd0;
    D_valC = 64'd0;
    D_valP = 64'd0;
    D_stat = 2'd0;
    #20
    D_icode = 4'd2;
    D_ifun = 4'd0;
    D_rA = 4'd1;
    D_rB = 4'd2;
    #20
    D_icode = 4'd3;
    D_ifun = 4'd0;
    D_rA = 4'd2;
    D_rB = 4'd3;
    D_valC = 64'd10;
    #20
    D_icode = 4'd4;
    D_ifun = 4'd0;
    D_rA = 4'd3;
    D_rB = 4'd4;
    D_valC = 64'd15;
    #20
    D_icode = 4'd5;
    D_ifun = 4'd0;
    D_rA = 4'd4;
    D_rB = 4'd5;
    D_valC = 64'd20;
    #20
    D_icode = 4'd6;
    D_ifun = 4'd0;
    D_rA = 4'd5;
    D_rB = 4'd6;
    #20
    D_icode = 4'd8;
    D_ifun = 4'd0;
    D_rA = 4'd7;
    D_rB = 4'd8;
    D_valC = 64'd25;
    #20
    D_icode = 4'd9;
    #20
    D_icode = 4'd10;
    D_rA = 4'd9;
    #20
    D_icode = 4'd11;
    D_rA = 4'd10;
    #20
    $finish;
end

initial begin
    $monitor($time, "clk = %d, D_icode = %d, D_ifun=%d, D_rA=%d, D_rB=%d, D_valC=%d, D_valP = %d, D_stat=%d, \n\t\t\t E_icode=%d, E_ifun=%d, E_valA=%d,E_valB=%d, E_valC=%d, E_dstE=%d, E_dstM=%d, E_srcA=%d,E_srcB=%d,E_stat=%d",clk,D_icode,D_ifun,D_rA,D_rB,D_valC,D_valP,D_stat,E_icode,
    E_ifun,E_valA,E_valB,E_valC,E_dstE,E_dstM,E_srcA,E_srcB,E_stat);
end

endmodule