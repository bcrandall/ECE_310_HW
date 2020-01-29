module f_add (
  input A, K, Cin,
  output Cout, F
);

  wire w1, w2, w3;

  // Sum
  xor U1A ( w1, A, K );
  xor U1B ( F, w1, Cin );

  // Cout
  and U2A ( w2, A, K );
  and U2B ( w3, w1, Cin );
  or U3A ( Cout, w3, w2 );

endmodule
