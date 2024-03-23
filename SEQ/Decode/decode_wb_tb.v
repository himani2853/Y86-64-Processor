`include "decode_wb.v"
module decode_wb_tb;
reg clk;
reg Cnd;
reg [3:0] icode;
reg [3:0] rA;
reg [3:0] rB;
reg signed [63:0] valE;
reg signed [63:0] valM;
wire signed [63:0] valA;
wire signed [63:0] valB;
wire signed [63:0] rax;
wire signed [63:0] rcx;
wire signed [63:0] rdx;
wire signed [63:0] rbx;
wire signed [63:0] rsp;
wire signed [63:0] rbp;
wire signed [63:0] rsi;
wire signed [63:0] rdi;
wire signed [63:0] r8;
wire signed [63:0] r9;
wire signed [63:0] r10;
wire signed [63:0] r11;
wire signed [63:0] r12;
wire signed [63:0] r13;
wire signed [63:0] r14;
wire signed [63:0] rnone;

decode_wb call1(.clk(clk),.Cnd(Cnd),.icode(icode),.rA(rA),.rB(rB),.valE(valE),.valM(valM),.valA(valA),.valB(valB),.rax(rax),.rcx(rcx),.rdx(rdx),.rbx(rbx),.rsp(rsp),.rbp(rbp),.rsi(rsi),.rdi(rdi),.r8(r8),.r9(r9),.r10(r10),.r11(r11),.r12(r12),.r13(r13),.r14(r14),.rnone(rnone));

initial begin
    #10 clk = ~clk;
end

initial begin
    clk = 1'b0;
    Cnd = 1'b0;
    icode = 4'd0;
    rA = 4'd0;
    rB = 4'd0;
    valE = 64'd0;
    valM = 64'd0;
    #20
    Cnd = 1'b1;
    icode = 4'd6;
    rA = 4'd2;
    rB = 4'd3;
    valE = 64'd2;
    valM = 64'd3;
    #20
    Cnd = 1'b0;
    icode = 4'd2;
    rA = 4'd6;
    rB = 4'd7;
    valE = 64'd6;
    valM = 64'd7;
    #20
    Cnd = 1'b1;
    icode = 4'd2;
    rA = 4'd6;
    rB = 4'd7;
    valE = 64'd6;
    valM = 64'd7;
    #20
    Cnd = 1'b0;
    icode = 4'd11;
    rA = 4'd4;
    rB = 4'd15;
    valE = 64'd4;
    valM = 64'd5;
    #20
    Cnd = 1'b0;
    icode = 4'd10;
    rA = 4'd8;
    rB = 4'd15;
    valE = 64'd8;
    valM = 64'd9;
    #20
    Cnd = 1'b0;
    icode = 4'd9;
    rA = 4'd1;
    rB = 4'd2;
    valE = 64'd1;
    valM = 64'd2;
    #20
   Cnd = 1'b0;
    icode = 4'd8;
    rA = 4'd3;
    rB = 4'd7;
    valE = 64'd3;
    valM = 64'd7;
    #20
    Cnd = 1'b0;
    icode = 4'd7;
    rA = 4'd2;
    rB = 4'd8;
    valE = 64'd2;
    valM = 64'd8;
    #20
    Cnd = 1'b0;
    icode = 4'd5;
    rA = 4'd13;
    rB = 4'd12;
    valE = 64'd13;
    valM = 64'd12;
    #20
    Cnd = 1'b0;
    icode = 4'd4;
    rA = 4'd14;
    rB = 4'd10;
    valE = 64'd14;
    valM = 64'd10;
    #20
    Cnd = 1'b0;
    icode = 4'd3;
    rA = 4'd15;
    rB = 4'd11;
    valE = 64'd13;
    valM = 64'd12;
    #20
    $finish;
end


always @(*) begin
    
    if(clk == 1)
    begin
        $monitor(" Clk = %d, Time=%d: icode=%d, Cnd =%d, rA=%d, rB=%d, valE =%d, valM =%d, valA=%d , valB=%d", clk, $time, icode, Cnd, rA, rB, valE, valM, valA, valB);
    end
  end


endmodule