module test_out (
  input [3:0] S,
  input Cin,
  output F
);

wire w1, w2, w3;

and U4A (w1, S[3], S[2]);
and U4B (w2, S[3], S[1]);
or U5A (w3, w2, w1);
or U5B (F, Cin, w3);

endmodule
