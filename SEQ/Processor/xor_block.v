module xor_block(
    input [63:0]A,
    input [63:0]B,
    output [63:0]ans
);

genvar i;

generate for(i=0;i<64;i=i+1)
begin
    xor(ans[i],A[i],B[i]);
end
endgenerate

endmodule

