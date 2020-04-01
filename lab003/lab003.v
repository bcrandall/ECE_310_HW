module lab004 (
  input rst_n, clk,
  input [7:0] in,
  input start, stop,
  output [31:0] acc
);

  wire en, load;

  controller ctrl ( rst_n, clk, start, stop, en, load );
  datapath dpth ( rst_n, clk, in, en, load, acc );

endmodule

module controller (
  input rst_n, clk,
  input start, stop,
  output reg en, load
);

  reg cstate;
  reg nstate;

  always @( posedge clk )
  begin
    if( !rst_n )
    begin
      cstate <= 0;
      nstate <= 0;
      en <= 0;
      load <= 0;
    end
    else
      cstate <= nstate;
  end

  always @(start || stop)
  begin
    en     <= cstate;
    load   <= ((~cstate) & start);
    nstate <= (((~cstate) & start) |
      (cstate & (~stop)));
//    $display($time, ": en = %b, load = %b, start = %b, stop = %b, cstate = %b, nstate = %b", en, load, start, stop, cstate, nstate);
  end

endmodule

module datapath (
  input rst_n, clk,
  input [7:0] in,
  input en, load,
  output reg [31:0] acc
);

  always @( posedge clk )
  begin
    //$display($time, ": rst_n = %b, load = %b, in = %b, en = %b",rst_n, load, in, en);   
    if( !rst_n )
      acc <= 0;
    else
    begin
      if( load )
        acc <= in;
      else
      begin
        if( en )
          acc <= acc + in;
        else
          acc <= acc;
      end
    end
  end
endmodule

module lab003_tb;

  reg rst, clk;

  wire [31:0] acc;
  reg [7:0] in;
  reg start, stop;

  lab003 DUT ( rst, clk, in, start, stop, acc );

  always #5 clk = ~clk;

  initial begin
    rst = 0;
    clk = 0;

    #10
    rst = 1;
  end

  // There is nothing wrong with this section.  I use the negative edge of the
  // clock to store the updated value on in only to get it to align with the
  // start and stop pulses in the simulation.
  always @( negedge clk )
    if( !rst )
      in <= 0;
    else
      if(in == 4)
        in <= 1;
      else
        in <= in + 1;

  initial begin
    $monitor( $time, ": in = %d, ACC = %d, clk = %b, rst = %b", in, acc, clk, rst );
    start = 0;
    stop  = 0;

    #40 start  = 1;
    #10 start  = 0;
    #70  stop  = 1;
    #10  stop  = 0;

    #40  start = 1;
    #10  start = 0;
    #60  stop  = 1;
    #10  stop  = 0;

    #30 $stop;
  end

endmodule

