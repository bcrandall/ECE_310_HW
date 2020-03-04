module serial_bcd_alu(
  input rst_n, clk, en, in,
  output result
);

  wire [5:0] count;
  wire [15:0] A, B;
  wire Cin = 0;
  wire [19:0] p_in;
  wire [32:0] p_out;
  wire test_count;
  reg cnt = 0;
  wire shift, capture;

  sipo_33bit inst0 ( ~rst_n, clk, en, in, p_out, count );

  assign A = p_out[15:0];
  assign B = p_out[32] ? {4'b1010-p_out[31:28], 4'b1010-p_out[27:24], 4'b1010-p_out[23:20], 4'b1010-p_out[19:16]} : p_out[31:16];
  
  always @(p_in)
  begin
//    $display("rst(%b), serial_in(%b), en(%b), result(%b), p(%b)", rst_n, in, en, result, p_out);
    $display($time, ": A(%d %d %d %d) + B(%d %d %d %d) = p_in(%d %d %d %d %d), result(%b)", A[15:12], A[11:8], A[7:4], A[3:0], B[15:12], B[11:8], B[7:4], B[3:0], p_in[19:16], p_in[15:12], p_in[11:8], p_in[7:4], p_in[3:0], result);
    $display($time, ": A(%4b %4b %4b %4b) + B(%4b %4b %4b %4b) = p_in(%4b %4b %4b %4b %4b), result(%b)", A[15:12], A[11:8], A[7:4], A[3:0], B[15:12], B[11:8], B[7:4], B[3:0], p_in[19:16], p_in[15:12], p_in[11:8], p_in[7:4], p_in[3:0], result);
//    $display("rst_n(%b), clk(%b), capture(%b), shift(%b), p_in(%b), result(%b)", ~rst_n, clk, en, ~en, p_in, result);
  end

//  pause inst3 (en, clk, shift, capture);


  bcd_full_add inst1 (A, B, Cin, p_out[32],  p_in);
  always @(*)begin
//    $display($time, ": p_in from full_adder(%b)", p_in);
//    $display($time, ": result(%b)", result);
  end
 
  piso_20bit inst2 (~rst_n, clk, en, ~en, p_in, result);

endmodule


module pause(
  input en, clk,
  output reg shift, capture
);

  reg delay;
  reg [2:0] count = 5;

  always @(negedge en) begin
    delay = 1;
    count = 0;
    capture = 1;
    shift = 0;
  end

  always @(posedge clk) begin
    if(delay == 1 && count == 0)begin
      count = 1;
      capture = 0;
      delay = 1;
      shift = 0;
    end
    else if(delay == 1 && count == 1)begin
      count = 2;
      delay = 1;
      capture = 0;
      shift = 0;
    end
    else if(delay == 1 && count > 1)begin
      count = 0;
      delay = 0;
      capture = 0;
      shift = 1;
    end
    else begin
      count = 0;
      delay = 0;
      capture = ~en;
      shift = en;
    end
  end

//  always @*
//    $display("capture(%b), shift(%b), count(%b), delay(%b)", capture, shift, count, delay);


endmodule  
 


module my_serial_tb;

  reg rst_n, clk, en, in;
  wire result;

  serial_bcd_alu DUT (rst_n, clk, en, in, result);

  initial clk = 0;

  // Free-running clock
  always #5 clk = ~clk;

  // Run through a reset at the beginning
  initial begin
        rst_n = 1;
    #10 rst_n = 0;
  end

  // Randomize the value of the s_in bit every
  // 10 units of time to be on the falling edge
  // of the clock (for clarity)
  initial
  begin
    in = 0;
    forever
      #10 in = $urandom % 2;
  end

  //  Run through some shifting
  initial
  begin
    $monitor( $time, ": rst(%b), en(%b), in(%b), result(%b)",
      en, in, result);
    en = 0;

    #50  en = 1;
    #300 en = 0;
    #80  en = 1;
    #300 $stop;
  end

endmodule
