`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.01.2021 10:32:31
// Design Name: 
// Module Name: WeightROM
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


module WeightROM#(
        parameter data_size=8
    )(
        input clk,
        input [19:0] c_address,
        output [data_size-1:0] bus
    );
    
    WeightDataROM weight_ROM (
      .clka(clk),    // input wire clka
      .addra(c_address),  // input wire [19 : 0] addra
      .douta(bus)  // output wire [7 : 0] douta
    );
endmodule
