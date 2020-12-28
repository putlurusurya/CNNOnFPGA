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
    input [19:0] address,
    input clk,
    output [7:0] read
);
 InputDataROM InputROM (
      .clka(clk),    // input wire clka
      .addra(address),  // input wire [19 : 0] addra
      .douta(read)  // output wire [7 : 0] douta
    );
      
    
endmodule
