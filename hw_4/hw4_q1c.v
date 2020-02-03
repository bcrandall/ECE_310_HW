module hw4_q1c;

  integer i;
  reg [15:0] A, B;
  reg Cin = 1'b0;
  wire [16:0] S;
  
  hw4_q1b DUT ( A, B, Cin, S);

  initial
  begin
    $monitor( $time, " %d + %d = %d", A, B, S);
    for( i=0; i<1000; i=i+1 )
    begin
      #10 A = i;
          B = i;
    end
  end

endmodule
