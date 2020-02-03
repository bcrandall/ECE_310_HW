module bcd_add (
  input [3:0] A, B,
  input Cin,
  output Cout,
  output [3:0] S
);

reg [3:0] K = 4'b0110;
reg Gr = 1'b0;
wire [3:0] C, C1, M, R;
wire Cout1, Cout2, F;

f_add inst_0 (A[0], B[0], Cin, C[0], M[0]);
f_add inst_1 (A[1], B[1], C[0], C[1], M[1]);
f_add inst_2 (A[2], B[2], C[1], C[2], M[2]);
f_add inst_3 (A[3], B[3], C[2], C[3], M[3]);

assign Cout1 = C[3];

test_out test1 (M, Cout1, F);
and U2A (R[0], F, K[0]);
and U2B (R[1], F, K[1]);
and U2C (R[2], F, K[2]);
and U2D (R[3], F, K[3]);

f_add inst_4 (M[0], R[0], Gr, C1[0], S[0]);
f_add inst_5 (M[1], R[1], C1[0], C1[1], S[1]);
f_add inst_6 (M[2], R[2], C1[1], C1[2], S[2]);
f_add inst_7 (M[3], R[3], C1[2], C1[3], S[3]);

assign Cout2 = C1[3];

or U3A (Cout, Cout1, Cout2);

endmodule
