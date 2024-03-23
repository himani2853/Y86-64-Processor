`include "decode.v"
module decode_tb;
reg clk;
reg [3:0] icode;
reg [3:0] rA;
reg [3:0] rB;
wire signed [63:0] valA;
wire signed [63:0] valB;

decode call1(.clk(clk),.icode(icode),.rA(rA),.rB(rB),.valA(valA),.valB(valB));

initial begin
    #10 clk = ~clk;
end

initial begin
    clk = 1'b0;
    icode = 4'd0;
    rA = 4'd0;
    rB = 4'd0;
    #20
    icode = 4'd2;
    rA = 4'd2;
    rB = 4'd3;
    #20
     icode = 4'd3;
    rA = 4'd5;
    rB = 4'd8;
    #20
    icode = 4'd4;
    rA = 4'd4;
    rB = 4'd5;
    #20
    icode = 4'd5;
    rA = 4'd6;
    rB = 4'd7;
    #20
    icode = 4'd6;
    rA = 4'd2;
    rB = 4'd3;
    #20
    icode = 4'd8;
    rA = 4'd10;
    rB = 4'd11;
    #20
    icode = 4'd9;
    rA = 4'd12;
    rB = 4'd13;
    #20
    icode = 4'd10;
    rA = 4'd0;
    rB = 4'd1;
    #20
    icode = 4'd11;
    rA = 4'd14;
    rB = 4'd10;
    #20
    $finish;
end


always @(*) begin
    // $monitor(" Clk = %d, Time=%d: icode=%d, rA=%d, rB=%d, valA=%d , valB=%d,\n\t\t\t\t\t\t\t\trax = %d, rcx=%d, rdx =%d, rbx=%d, rsp=%d,\n\t\t\t\t\t\t\t\trbp=%d, rsi=%d, rdi =%d, r8=%d, r9 =%d,\n\t\t\t\t\t\t\t\tr10 = %d, r11=%d, r12 = %d, r13=%d, r14 =%d, rnone=%d", clk, $time, icode, rA, rB, valA, valB, rax, rcx, rdx, rbx, rsp, rbp, rsi,rdi,r8,r9,r10,r11,r12,r13,r14,rnone);
    
    if(clk == 1)
    begin
        $monitor(" Clk = %d, Time=%d: icode=%d, rA=%d, rB=%d, valA=%d , valB=%d", clk, $time, icode, rA, rB, valA, valB);
    end
  end


endmodule