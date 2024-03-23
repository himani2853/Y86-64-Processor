`include "full_adder.v"

module add(
  input signed [63:0] A,
  input signed [63:0] B,
  output signed [63:0] S,
  output overflow
);

wire [64:0] C;

assign C[0] = 0;

genvar i;

generate for(i=0;i<64;i=i+1)
begin
  full_adder G1(A[i],B[i],C[i],S[i],C[i+1]);
end
endgenerate

xor G2(overflow,C[63],C[64]);

endmodule


