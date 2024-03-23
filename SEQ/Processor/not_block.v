module not_block(
    input signed [63:0] A,
    output signed [63:0] B
);

genvar i;

generate for(i=0;i<64;i=i+1)
begin
    not(B[i],A[i]);
end
endgenerate

endmodule