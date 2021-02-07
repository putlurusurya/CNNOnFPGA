// Code your testbench here
// or browse Examples
module Demultiplexer_1_to_4_case_tb;
  wire [3:0] d_out;
  reg [1:0] sel;
  reg d_in;
  demux1_4 uut (d_in, sel, d_out);
initial begin
    d_in = 255;
    sel = 2'b00;
#1  sel = 2'b01;
#1  sel = 2'b10;
#1  sel = 2'b11;
end
initial begin
  $monitor("%t| d_in = %d| sel[1] = %d| sel[0] = %d| d_out[0] = %d| d_out[1] = %d| d_out[2] = %d| d_out[3] = %d",
           $time, d_in, sel[1], sel[0], d_out[0], d_out[1], d_out[2], d_out[3]);
end
endmodule