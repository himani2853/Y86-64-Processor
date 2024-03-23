module full_adder(A,B,C,S,C_out);
input A,B,C;
output S,C_out;
wire t1,t2,t3;
xor(t1,A,B);
xor(S,t1,C);
and(t2,t1,C);
and(t3,A,B);
or (C_out,t2,t3);
endmodule