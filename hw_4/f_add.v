module f_add (
  input A, K, Cin,
  output Cout, F
);

  wire w1, w2, w3;

  // Sum
  xor U6A ( w1, A, K );
  xor U6B ( F, w1, Cin );

  // Cout
  and U7A ( w2, A, K );
  and U7B ( w3, w1, Cin );
  or U8A ( Cout, w3, w2 );
endmodule
