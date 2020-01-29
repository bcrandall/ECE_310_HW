module f_add_tb;

  integer i;
  reg A, K;
  reg Cin = 1'b0;
  wire Cout, F;

  f_add DUT ( A, K, Cin, Cout, F);

  initial
  begin
    $monitor( $time, " %b + %b = %b + %b", A, K, F, Cout );
    for( i=0; i< 4; i=i+1 )
    begin
      #10 {A, K} = i;
    end
    #10 $stop;
  end

endmodule
