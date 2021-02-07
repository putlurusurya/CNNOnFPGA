`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.02.2021 08:29:24
// Design Name: 
// Module Name: demux_array
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module demux_array#(
  parameter array_size = 9,
  parameter data_size = 8
)(input [data_size*array_size-1:0]d_in,
  input [1:0] sel ,
  output [data_size*array_size-1:0]d_out_1,
  output [data_size*array_size-1:0]d_out_2,
  output [data_size*array_size-1:0]d_out_3,
  output [data_size*array_size-1:0]d_out_4
  );
  
  
  genvar i;
  generate
    for(i=0;i<array_size;i=i+1)
      begin
      demux1_4 demux(
                   .d_in(d_in[(i+1)*data_size-1:i*data_size]),
                   .sel(sel),
                   .d_out1(d_out_1[(i+1)*data_size-1:i*data_size]),
                   .d_out2(d_out_2[(i+1)*data_size-1:i*data_size]),
                   .d_out3(d_out_3[(i+1)*data_size-1:i*data_size]),
                   .d_out4(d_out_4[(i+1)*data_size-1:i*data_size])
                   );
      end
  endgenerate
  endmodule
