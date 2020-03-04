module sipo_33bit (
  input rst_n, clk, shift, s_in,
  output [32:0] p_out,
  output [5:0] count
);

  wire [32:0] shifted, nstate;
  wire en, count_lt_34;

  // Instantiate the register
  dff #( .WIDTH(33) ) state (
    .rst_n( rst_n ),
    .clk( clk ),
    .D( nstate ),
    .Q( p_out )
  );

  // Concatenate the serial in bit to the
  // MSb of the p_out making it a single bit
  // wider, and shift truncating the new 0
  // brought in at the top
  assign shifted = {s_in, p_out } >> 1;

  
  // The next state of p_out is based on the
  // shift control bit
  assign nstate = shift ? shifted : p_out;

  // Count number of bits
  wire [5:0] ncount, added; 

  dff #( .WIDTH(6) ) cnt (
    .rst_n(rst_n),
    .clk( clk ),
    .D( ncount ),
    .Q( count )
  );

  assign added = count + 1;

  assign ncount = shift ? added : count;
  

endmodule

module sipo_33bit_tb;

  reg rst_n, clk, shift, s_in;
  wire [32:0] p_out;
  wire [32:0] count;

  // Instantiate the DUT
  sipo_33bit DUT (
    .rst_n( rst_n ),
    .clk( clk ),
    .shift( shift ),
    .s_in( s_in ),
    .p_out( p_out ),
    .count( count )
  );

  // Initialize the clock to 0
  initial clk = 0;

  // Free-running clock
  always #5 clk = ~clk;

  // Run through a reset at the beginning
  initial begin
        rst_n = 0;
    #10 rst_n = 1;
  end

  // Randomize the value of the s_in bit every
  // 10 units of time to be on the falling edge
  // of the clock (for clarity)
  initial
  begin
    s_in = 1;
    forever
      #10 s_in = 1;
  end

  //  Run through some shifting
  initial
  begin
    $monitor( $time, ": shift(%b), s_in(%b), p_out(%016b, %04x), count(%b)",
      shift, s_in, p_out, p_out, count );
    shift = 0;

    #50  shift = 1;
    #300 shift = 0;
    #80  shift = 1;
    #300 $stop;
  end

endmodule

