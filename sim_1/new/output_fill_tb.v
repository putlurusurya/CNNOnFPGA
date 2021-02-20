`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.02.2021 11:42:45
// Design Name: 
// Module Name: output_fill_tb
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

module output_fill_tb();
  reg w_clk,enable,rst;
  reg initial_address,is_empty,c_address;
  wire [7:0]output_featuremapsize;
  reg w_enable,r_enable;
  
  
  output_fill1 uut(
    .w_clk(w_clk),
    .enable(enable),
    .reset(rst),
    .initial_address(initial_address),
    .output_featuremapsize(output_featuremapsize),
    .is_empty(is_empty),
    .c_address(c_address),
    .write_enable(write_enable),
    .read_enable(read_enable)
  );
  
  initial begin
    rst = 0;
    #1
    enable = 1;
    #1
    initial_address = 0x010;
    #1
    output_featuremap_size = 7b'0001000;
    end

endmodule
    
    
    