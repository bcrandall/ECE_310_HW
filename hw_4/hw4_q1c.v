module hw4_q1c;

  integer i, j, m, n;
  reg [15:0] A, B;
  reg Cin = 1'b0;
  wire [16:0] S;
  
  hw4_q1b DUT ( A, B, Cin, S);

  initial
  begin
    $monitor( $time, " %d%d%d%d + %d%d%d%d = %d%d%d%d%d", A[15:12], A[11:8], A[7:4], A[3:0], B[15:12], B[11:8], B[7:4], B[3:0], S[16], S[15:12], S[11:8], S[7:4], S[3:0]); 
    for( n=0; n<10; n=n+1 )
    for( m=0; m<10; m=m+1 )
      for( i=0; i<10; i=i+1 )
        for( j=0; j<10; j=j+1 )
          begin
            #10 A = i;
                B = j;
                A[7:4] = m;
                B[7:4] = n;
    end
  end

endmodule
