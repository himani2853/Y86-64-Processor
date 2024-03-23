`include "write_back.v"
module write_back_tb;
reg clk;
reg [3:0] icode;
reg Cnd;
reg [3:0] rA;
reg [3:0] rB;
reg signed [63:0] valE;
reg signed [63:0] valM;
// wire signed [63:0] rax;
// wire signed [63:0] rcx;
// wire signed [63:0] rdx;
// wire signed [63:0] rbx;
// wire signed [63:0] rsp;
// wire signed [63:0] rbp;
// wire signed [63:0] rsi;
// wire signed [63:0] rdi;
// wire signed [63:0] r8;
// wire signed [63:0] r9;
// wire signed [63:0] r10;
// wire signed [63:0] r11;
// wire signed [63:0] r12;
// wire signed [63:0] r13;
// wire signed [63:0] r14;
// wire signed [63:0] rnone;

write_back call1(.clk(clk),.icode(icode),.Cnd(Cnd),.rA(rA),.rB(rB),.valE(valE),.valM(valM));

always begin
    #10 clk = ~clk;
end

initial begin
    clk = 1'b0;
    icode = 4'd0;
    Cnd = 1'b0;
    rA = 4'd0;
    rB = 4'd0;
    valE = 64'd0;
    valM = 64'd0;
    #20
    icode = 4'd2;
    Cnd = 1'b1;
    rA = 4'd0;
    rB = 4'd1;
    valE = 64'd45;
    valM = 64'd35;
    #20
    icode = 4'd3;
    Cnd = 1'b1;
    rA = 4'd2;
    rB = 4'd3;
    valE = 64'd45;
    valM = 64'd35;
    #20
    icode = 4'd5;
    Cnd = 1'b1;
    rA = 4'd4;
    rB = 4'd5;
    valE = 64'd45;
    valM = 64'd35;
    #20
    icode = 4'd6;
    Cnd = 1'b1;
    rA = 4'd6;
    rB = 4'd7;
    valE = 64'd45;
    valM = 64'd35;
    #20
    icode = 4'd10;
    Cnd = 1'b1;
    rA = 4'd8;
    rB = 4'd9;
    valE = 64'd45;
    valM = 64'd35;
    #20
    icode = 4'd11;
    Cnd = 1'b1;
    rA = 4'd10;
    rB = 4'd11;
    valE = 64'd45;
    valM = 64'd35;
    #20
    icode = 4'd8;
    Cnd = 1'b1;
    rA = 4'd12;
    rB = 4'd13;
    valE = 64'd45;
    valM = 64'd35;
    #20
    icode = 4'd9;
    Cnd = 1'b1;
    rA = 4'd14;
    rB = 4'd1;
    valE = 64'd45;
    valM = 64'd35;
    #20
    $finish;

end

// initial begin
//     $dumpfile("write_back_tb.vcd");
//     $dumpvars(0,write_back_tb);
// end 

always @(*) begin
    $monitor(" Clk = %d, Time=%d: icode=%d, Cnd=%d, rA=%d, rB=%d , valE=%d, valM= %d", clk, $time, icode, Cnd, rA, rB, valE, valM);
  end

endmodule