// `include "full_adder.v"
`include "not_block.v"

module sub(
  input signed [63:0] A,
  input signed [63:0] B,
  output signed [63:0] S,
  output overflow
);

wire [64:0] C;

assign C[0] = 1;

wire signed [63:0] B_final;

genvar i;

not_block G3(B,B_final);

generate for(i=0;i<64;i=i+1)
begin
  full_adder G1(A[i],B_final[i],C[i],S[i],C[i+1]);
end
endgenerate

xor G2(overflow,C[63],C[64]);

endmodule

