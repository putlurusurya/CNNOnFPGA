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
    input [15:0] addra,
    input [15:0] addrb,

    input clka,
    input clkb,
    output [7:0] doutb,
    input wea,
    input [7:0] dina,
    input [7:0] dina1,
    input ena,
    input enb,
    input enb1
);
buffer_memory_blocks your_instance_name (
  .clka(clka),    // input wire clka
  .ena(ena),      // input wire ena
  .wea(wea),      // input wire [0 : 0] wea
  .addra(addra),  // input wire [15 : 0] addra
  .dina(dina),    // input wire [7 : 0] dina
  .clkb(clkb),    // input wire clkb
  .enb(enb),      // input wire enb
  .addrb(addrb),  // input wire [15 : 0] addrb
  .doutb(doutb)  // output wire [7 : 0] doutb
);
buffer_memory_blocks your_instance_name1 (
  .clka(clka),    // input wire clka
  .ena(ena),      // input wire ena
  .wea(wea),      // input wire [0 : 0] wea
  .addra(addra),  // input wire [15 : 0] addra
  .dina(dina1),    // input wire [7 : 0] dina
  .clkb(clkb),    // input wire clkb
  .enb(enb1),      // input wire enb
  .addrb(addrb),  // input wire [15 : 0] addrb
  .doutb(doutb)  // output wire [7 : 0] doutb
);
      
    
endmodule
