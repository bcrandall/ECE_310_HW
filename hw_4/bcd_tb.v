module bcd_tb;

  integer i;
  reg [3:0] A, B;
  reg Cin = 1'b0;
  wire [3:0] S;
  wire Cout;
  
  bcd_add DUT ( A, B, Cin, Cout, S);

  initial
  begin
    $monitor( $time, " %d + %d = %b", A, B, S);
    for( i=0; i<100; i=i+1 )
    begin
      #10 A = i;
          B = i;
    end
  end

endmodule
