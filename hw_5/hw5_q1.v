module hw5_q1 (
  input dir, clk, rst_n,
  output [3:0] count
  );
  
  wire [3:0] w1, w2, w3, w4;
  wire enable;
  
  assign w1 = count - enable;
  assign w2 = count + enable;
  assign w3 = dir ? w2 : w1;
  
  sat_check inst_0 (count, dir, enable);
  dff DQ (.Q(count), .D(w3), .rst_n(rst_n), .clk(clk));
  
endmodule




module sat_check (
  input [3:0] count,
  input dir,
  output  enable
  );
  
  wire w1, w2;
  
  and U1A (w1, ~count[0], ~count[1], ~count[2], ~count[3], ~dir);
  and U1B (w2, count[0], count[1], count[2], count[3], dir);
  and U2 (enable, ~w1, ~w2);
  
endmodule




module dff #(
  parameter WIDTH=4
) (
  input rst_n, clk,
  input [WIDTH-1:0] D,
  output reg [WIDTH-1:0] Q
);

  always @( posedge clk )
  begin
    if( !rst_n )
      Q <= 0;
    else
      Q <= D;
  end

endmodule

