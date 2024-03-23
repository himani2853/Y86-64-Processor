module execute_tb;
reg clk;
reg [1:0] E_stat;
reg [3:0] E_icode;
reg [3:0] E_ifun;
reg signed [63:0] E_valC;
reg signed [63:0] E_valA;
reg signed [63:0] E_valB;
reg [3:0] E_dstE;
reg [3:0] E_dstM;
reg W_stat;
reg m_stat;
reg set_cc;
reg M_bubble;
wire [1:0] M_stat;
wire [3:0] M_icode;
wire M_Cnd;
wire signed [63:0] M_valE;
wire signed [63:0] M_valA;
wire [3:0] M_dstE;
wire [3:0] M_dstM;
wire e_cnd;
wire signed [63:0] e_valE;
wire [63:0] e_dstE;

execute call1(.clk(clk),.E_stat(E_stat),.E_icode(E_icode),.E_ifun(E_ifun),.E_valC(E_valC),.E_valA(E_valA),.E_valB(E_valB),.E_dstE(E_dstE),.E_dstM(E_dstM),.W_stat(W_stat),.m_stat(m_stat),.set_cc(set_cc),.M_bubble(M_bubble),.M_stat(M_stat),.M_icode(M_icode),.M_Cnd(M_Cnd),.M_valE(M_valE),.M_valA(M_valA),.M_dstE(M_dstE),.M_dstM(M_dstM),.e_Cnd(e_Cnd),.e_valE(e_valE),.e_dstE(e_dstE));

always begin
    #10 clk = ~clk;
end

initial begin
    $dumpfile("execute_tb.vcd");
    $dumpvars(0,execute_tb);
end

initial begin
    clk = 1'b0;
    E_stat = 2'd0;
    E_icode = 4'd0;
    E_ifun = 4'd0;
    E_valC = 64'd0;
    E_valA = 64'd0;
    E_valB = 64'd0;
    E_dstE = 4'd0;
    E_dstM = 4'd0;
    set_cc = 1'b0;
    #20
    E_icode = 4'd2;
    E_ifun = 4'd0;
    E_valA = 64'd10;
    E_dstE = 4'd1;
    #20
    E_icode = 4'd2;
    E_ifun = 4'd1;
    E_valA = 64'd15;
    E_dstE = 4'd2;
    #20
    E_icode = 4'd2;
    E_ifun = 4'd2;
    E_valA = 64'd15;
    E_dstE = 4'd2;
    #20
    E_icode = 4'd2;
    E_ifun = 4'd3;
    E_valA = 64'd20;
    E_dstE = 4'd3;
    #20
    E_icode = 4'd2;
    E_ifun = 4'd4;
    E_valA = 64'd25;
    E_dstE = 4'd4;
    #20
    E_icode = 4'd2;
    E_ifun = 4'd5;
    E_valA = 64'd30;
    E_dstE = 4'd5;
    #20
    E_icode = 4'd2;
    E_ifun = 4'd6;
    E_valA = 64'd35;
    E_dstE = 4'd6;
    #20
    E_icode = 4'd3;
    E_ifun = 4'd0;
    E_valC = 64'd40;
    E_dstE = 4'd7;
    #20
    E_icode = 4'd4;
    E_ifun = 4'd0;
    E_valA = 64'd45;
    E_valB = 64'd50;
    E_valC = 64'd55;
    E_dstE = 4'd8;
    #20
    E_icode = 4'd5;
    E_ifun = 4'd0;
    E_valB = 64'd60;
    E_valC = 64'd55;
    E_dstM = 4'd9;
    #20
    E_icode = 4'd6;
    E_ifun = 4'd0;
    E_valA = 64'd60;
    E_valB = 64'd65;
    E_dstE = 4'd10;
    set_cc = 1'b1;
    #20
    E_icode = 4'd6;
    E_ifun = 4'd1;
    E_valA = 64'd70;
    E_valB = 64'd75;
    E_dstE = 4'd11;
    set_cc = 1'b1;
    #20
    E_icode = 4'd6;
    E_ifun = 4'd2;
    E_valA = 64'd80;
    E_valB = 64'd85;
    E_dstE = 4'd12;
    set_cc = 1'b1;
    #20
    E_icode = 4'd6;
    E_ifun = 4'd3;
    E_valA = 64'd90;
    E_valB = 64'd95;
    E_dstE = 4'd12;
    set_cc = 1'b1;
    #20
    E_icode = 4'd7;
    E_ifun = 4'd0;
    E_valC = 64'd100;
    #20
    E_icode = 4'd7;
    E_ifun = 4'd1;
    E_valC = 64'd105;
    #20
    E_icode = 4'd7;
    E_ifun = 4'd2;
    E_valC = 64'd110;
    #20
    E_icode = 4'd7;
    E_ifun = 4'd3;
    E_valC = 64'd115;
    #20
    E_icode = 4'd7;
    E_ifun = 4'd4;
    E_valC = 64'd120;
    #20
    E_icode = 4'd7;
    E_ifun = 4'd5;
    E_valC = 64'd125;
    #20
    E_icode = 4'd7;
    E_ifun = 4'd6;
    E_valC = 64'd130;
    #20
    E_icode = 4'd8;
    E_ifun = 4'd0;
    E_valC = 64'd130;
    E_valB = 64'd135;
    E_dstE = 4'd13;
    #20
    E_icode = 4'd9;
    E_ifun = 4'd0;
    E_valA = 64'd140;
    E_valB = 64'd145;
    E_dstM = 4'd14;
    #20
    E_icode = 4'd10;
    E_ifun = 4'd0;
    E_valA = 64'd150;
    E_valB = 64'd155;
    E_dstE = 64'd0;
    #20
    E_icode = 4'd11;
    E_ifun =  4'd0;
    E_valA = 64'd160;
    E_valB = 64'd165;
    E_dstM = 4'd1;
    #20
    $finish;
end

initial begin
    $monitor($time,"clk=%d,E_stat = %d,E_icode = %d,E_ifun = %d, E_valC = %d,E_valA = %d, E_valB = %d, E_dstE = %d, E_dstM = %d, set_cc = %d, M_stat = %d, M_icode = %d, M_Cnd = %d, M_valE = %d, \n\t\t\t M_valA = %d, M_dstE = %d, M_dstM = %d, e_Cnd = %d",clk,E_stat,E_icode,E_ifun,E_valC,E_valA,E_valB,E_dstE,E_dstM,set_cc,M_stat,M_icode,M_Cnd,M_valE,M_valA,M_dstE,M_dstM,e_Cnd);
end

endmodule