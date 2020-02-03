module test_out_tb;

  integer i;
  reg [3:0] S;
  reg Cin = 1'b0;
  wire F;
  
  test_out DUT ( S, Cin, F);

  initial
  begin
    $monitor( $time, " %d + %d = %b", S, Cin, F);
    for( i=0; i<31; i=i+1 )
    begin
      #10 S = i;
    end
  end

endmodule
