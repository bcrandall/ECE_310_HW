module hw3_dec (
  input [4:0] A, K,
  input Cin,
  output [4:0] F
);

  wire w1, w2, w3;
  wire Cout4, Cout3, Cout2, Cout1,Cout0;
  
  f_add inst_0(A[0], K[0], Cin, Cout0, F[0]);
  f_add inst_1(A[1], K[1], Cout0, Cout1, F[1]);
  f_add inst_2(A[2], K[2], Cout1, Cout2, F[2]);
  f_add inst_3(A[3], K[3], Cout2, Cout3, F[3]);
  f_add inst_4(A[4], K[4], Cout3, Cout4, F[4]);

endmodule


