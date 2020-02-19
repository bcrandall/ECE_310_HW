module sat_check_tb;

  integer i;
  reg [3:0] count;
  reg dir;
  wire enable;

  sat_check DUT (count, dir, enable);
 
  initial
  begin
    $monitor($time, " count: %b direction: %b enable: %d", count, dir, enable);
    for( i=0; i<32; i=i+1 )
    begin
      #10 {dir,count} = i;
    end
  end

endmodule
