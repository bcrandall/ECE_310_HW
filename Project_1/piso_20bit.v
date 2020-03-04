module piso_20bit (
  input rst_n, clk,capture, shift,
  input [19:0] p_in,
  output s_out
);

  wire [19:0] cstate, nstate;
  wire [19:0] next_shift, shifted;

  // Instantiate the state register
  dff #( .WIDTH(20) ) state (
    .rst_n( rst_n ),
    .clk( clk ),
    .D( nstate ),
    .Q( cstate )
  );  
  
  reg delay = 0;
  reg [1:0] count = 0;

  always @(negedge capture)begin
    delay = 1;
    count = 0;
  end

  always @(posedge clk) begin
    if(delay == 1 && count == 0)begin
      count = 1;
      delay = 1;
//      $display("count == 0, count(%b), delay(%b)", count, delay);
    end
//    else if(delay == 1 && count == 1)begin
//      count = 2;
//      delay = 1;
//      $display("count == 1, count(%b), delay(%b)", count, delay);
//    end
    else if(delay == 1 && count != 0)begin
      count = 0;
      delay = 0;
//      $display("count > 1, count(%b), delay(%b)", count, delay);
    end
    else begin
      count = 0;
      delay = 0;
//      $display("standard count(%b), delay(%b)", count, delay);
    end
  end

  // We're shifting out of the MSb
  assign s_out = cstate[0];

  // Get the shifted value; Verilog specifies
  // that what comes in to the LSb will be a
  // zero
  assign shifted = cstate >> 1;

  // Check whether we should shift
  assign next_shift = shift ? shifted : cstate;

  // Check whether we should be capturing
  assign nstate = capture|delay ? p_in : next_shift; 

  always @*
  begin
//    $display($time, ": p_in(%b), shift(%b), capture(%b), cstate(%b), next_shift(%b), nstate(%b), s_out(%b)", p_in, shift, capture, cstate, next_shift, nstate, s_out); 
  end

endmodule

module piso_20bit_tb;

  reg rst_n, clk, shift, capture;
  reg [19:0] p_in;
  wire s_out;

  // Instantiate the DUT
  piso_20bit DUT (
    .rst_n( rst_n ),
    .clk( clk ),
    .capture( capture ),
    .shift( shift ),
    .p_in( p_in ),
    .s_out( s_out )
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

  // Randomize the value of p_in every 10 units
  // of time to be on the falling edge of the
  // clock (for clarity)
  initial
  begin
    p_in = 0;
    forever
      #10 p_in = 20'b00000110100001010000;
  end

  always @(*)
  begin
    capture = ~shift;
  end


  //  Run through some shifting and loading
  initial
  begin
    $monitor( $time, ": rreg(%20b), s_out(%b), p_in(%b), capture(%b), shift(%b)", rreg, s_out, p_in, capture, shift);
    shift = 0;

    #50  shift = 0;
    #10  shift = 1;
    #100 shift = 1;
    #500 shift = 0;
    #100 shift = 0;
    #20  shift = 0;
    #80  shift = 1;
    #300 $stop;
  end

  reg [19:0] rreg;
 
  always @( posedge clk )
  begin
  if( ~rst_n )
    rreg <= 0;
  else
    rreg <= {s_out, rreg[19:1] };
  end

endmodule
