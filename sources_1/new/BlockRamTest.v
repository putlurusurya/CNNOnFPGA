`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.12.2020 09:41:26
// Design Name: 
// Module Name: BlockRamTest
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


module BlockRamTest(
    input [31:0] address,
    input clk,
    input en,
    input [7:0] datain,
    output read
);
    WeightBRAM your_instance_name (
  .clka(clk),    // input wire clka
  .ena(en),      // input wire ena
  .wea(1'b1),      // input wire [0 : 0] wea
  .addra(address),  // input wire [10 : 0] addra
  .dina(datain),    // input wire [7 : 0] dina
  .douta(read)  // output wire [7 : 0] douta
);
endmodule
