module hw3_dec3_tb;

  integer i;
  reg [4:0] A;
  reg [4:0] K = 5'b11101;
  reg Cin = 1'b0;
  wire [4:0] F;

  hw3_dec DUT ( .A(A), .K(K), .Cin(Cin), .F(F));
  
  initial
  begin
    $monitor( $time, " A: %b=%d, F: %b=%d", A, A, F, F );
    for( i=0; i< 32; i=i+1 )
    begin
      #10 A = i;
    end
    #10 $stop;
  end

endmodule
