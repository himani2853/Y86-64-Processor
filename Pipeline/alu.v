`include "add.v"
`include "sub.v"
`include "and_block.v"
`include "xor_block.v"

module alu(
    input [1:0] control,
    input signed [63:0] A,
    input signed [63:0] B,
    output reg signed [63:0] S,
    output reg overflow,
    output reg signed[63:0] ans
);

wire signed[63:0]S_add;
wire signed overflow_add;
wire signed[63:0]S_sub;
wire signed overflow_sub;
wire signed[63:0]ans_and;
wire signed[63:0]ans_xor;


add G1(A,B,S_add,overflow_add);
sub G2(A,B,S_sub,overflow_sub);
and_block G3(A,B,ans_and);
xor_block G4(A,B,ans_xor);

always @(*) 
begin
if(control==2'b00)begin
     S <= S_add;
     overflow <= overflow_add;
     ans <= 0;
end
if(control==2'b01)begin
    S <= S_sub;
    overflow <= overflow_sub;
    ans <= 0;
end
if(control==2'b10)begin
     S <= 0;
     overflow <= 0;
     ans <= ans_and;
end
if(control==2'b11)begin
     S <= 0;
     overflow <= 0;
     ans <= ans_xor;
end

    
end


endmodule
