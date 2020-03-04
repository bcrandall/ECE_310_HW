module bcd_full_add (
  input [15:0] A, B,
  input Cin, dir,
  output [19:0] result
);

wire [3:0] C;
wire [19:0] S;

bcd_add inst_0 (A[3:0], B[3:0], Cin, C[0], S[3:0]);
bcd_add inst_1 (A[7:4], B[7:4], C[0], C[1], S[7:4]);
bcd_add inst_2 (A[11:8], B[11:8], C[1], C[2], S[11:8]);
bcd_add inst_3 (A[15:12], B[15:12], C[2], C[3], S[15:12]); 

//always @*
//  $display($time, ": Carry(%b), S(%b), result(%b), dir(%b)", C, S, result, dir);

assign S[16]=C[3];
assign S[19:17] = 0;

assign result[3:0] = S[3:0];
assign result[7:4] = S[7:4] - dir; 
assign result[11:8] = S[11:8] - dir;
assign result[15:12] = S[15:12] - dir;
assign result[19:16] = S[19:16] - dir;

endmodule
