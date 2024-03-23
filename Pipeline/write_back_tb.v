module write_back_tb;
reg clk;
reg [1:0] W_stat;
reg [3:0] W_icode;
reg [63:0] W_valE;
reg [63:0] W_valM;
reg [3:0] W_dstE;
reg [3:0] W_dstM;

write_back call1(.clk(clk),.W_stat(W_stat),.W_icode(W_icode),.W_valE(W_valE),.W_valM(W_valM),.W_dstE(W_dstE),.W_dstM(W_dstM));

always begin
    #10 clk = ~clk;
end

initial begin
    $dumpfile("write_back_tb.vcd");
    $dumpvars(0,write_back_tb);
end

initial begin
    clk = 1'b0;
    W_stat = 2'b0;
    W_icode = 2'b0;
    W_valE = 64'd0;
    W_valM = 64'd0;
    W_dstE = 4'd0;
    W_dstM = 4'd0;
    #20
    W_icode = 4'd2;
    W_valE = 64'd20;
    W_dstE = 64'd1;
    #20
    W_icode = 4'd3;
    W_valE = 64'd25;
    W_dstE = 64'd2;
    #20
    W_icode = 4'd5;
    W_valM = 64'd30;
    W_dstM = 64'd3;
    #20
    W_icode = 4'd6;
    W_dstE = 64'd4;
    W_valE = 64'd60;
    #20
    W_icode = 4'd10;
    W_valE = 64'd40;
    #20
    W_icode = 4'd11;
    W_valE = 64'd45;
    W_dstM = 64'd5;
    W_valM = 64'd50;
    #20
    W_icode = 4'd8;
    W_valE = 64'd55;
    #20
    W_icode = 4'd9;
    W_valE = 64'd60;
    #20
    $finish;
end

endmodule