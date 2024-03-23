module fetch_1_tb;
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

fetch_1 call1(.clk(clk),.F_predPC(F_predPC),.M_icode(M_icode),.M_Cnd(M_Cnd),.M_valA(M_valA),.W_icode(W_icode),.W_valM(W_valM),.F_stall(F_stall),.D_stall(D_stall),.D_bubble(D_bubble),.f_predPC(f_predPC),.D_stat(D_stat),.D_icode(D_icode),.D_ifun(D_ifun),.D_rA(D_rA),.D_rB(D_rB),.D_valC(D_valC),.D_valP(D_valP));

always begin
    #10 clk = ~clk;
end

always @(*)begin
    if(D_icode == 0)begin
       $finish;
    end
    if(D_stat != 2'd0)begin
        $finish;
    end
end

always @(posedge clk) begin
    F_predPC <= f_predPC;
end

initial begin
    $dumpfile("fetch_1_tb.vcd");
    $dumpvars(0,fetch_1_tb);
end

initial begin
    clk = 1'b0;
    F_predPC = 64'd0;
    D_stall = 1'b0;
    D_bubble = 1'b0;
end

initial begin
    $monitor($time, "\tclk=%d\n\t\t\tF Reg:\t\tF_predPC = %d\n\t\t\tfetch:\t\tf_predPC = %d\n\t\t\tD Reg:\t\tD_icode = %d D_ifun = %d D_rA = %d D_rB = %d D_valC = %d D_valP = %d D_stat = %d\n",clk,F_predPC,f_predPC,D_icode,D_ifun,D_rA,D_rB,D_valC,D_valP,D_stat);
end


endmodule