module hw4_q1b (
  input [15:0] A, B,
  input Cin,
  output [16:0] S
);

wire [3:0] C;

bcd_add inst_0 (A[3:0], B[3:0], Cin, C[0], S[3:0]);
bcd_add inst_1 (A[7:4], B[7:4], C[0], C[1], S[7:4]);
bcd_add inst_2 (A[11:8], B[11:8], C[1], C[2], S[11:8]);
bcd_add inst_3 (A[15:12], B[15:12], C[2], C[3], S[15:12]);

assign S[16]=C[3];

endmodule
