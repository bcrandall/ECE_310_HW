module hw5_q1_tb;

  integer i;
  reg dir, clk, rst_n;
  wire [3:0] count;
  
  hw5_q1 DUT (dir, clk, rst_n, count);

  initial clk = 0;
  initial dir = 1;

  initial begin 
        rst_n = 0;
    #10 rst_n = 1;
  end

  always #5 clk = ~clk;

  initial
  begin
    $monitor($time, " dir:%b, rst_n:%b, count:%b", dir, rst_n, count);
    #200 dir = 0;
    #200 $stop;
  end

endmodule
  
