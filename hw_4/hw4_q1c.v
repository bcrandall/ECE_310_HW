module hw4_q1c;

  integer i, j;
  reg [15:0] A, B;
  reg Cin = 1'b0;
  wire [16:0] S;
  
  hw4_q1b DUT ( A, B, Cin, S);

  initial
  begin
    $monitor( $time, " %d + %d = %d%d%d%d", A, B, S[16], S[15:12], S[11:8], S[7:4], S[3:0]); 
    for( i=0; i<10; i=i+1 )
      for( j=0; j<10; j=j+1 )
        begin
          #10 A = i;
              B = j;
    end
  end

endmodule
