`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.02.2021 12:00:59
// Design Name: 
// Module Name: input_data_rom
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


module input_data_rom#(
        parameter data_size=8,
        parameter array_size=9,
        parameter dim_data_size=8
    )(
        input clk,
        input [19:0] initial_address,
        input enable,
        input [array_size-1:0] write_enable_in,
        input reset,
        input [dim_data_size-1:0] weight_size,
        input [dim_data_size-1:0] image_height,
        input [dim_data_size-1:0] image_width,
        input [dim_data_size-1:0] offset,
        output [data_size-1:0] bus,
        output [array_size-1:0] write_enable_out,
        output  completed
    );
    wire [19:0] c_address;
     InputDataROM InputROM (
      .clka(clk),    // input wire clka
      .addra(c_address),  // input wire [19 : 0] addra
      .douta(bus)  // output wire [7 : 0] douta
    );
    fifo_fill_control_2 uut(
    .clk(clk),
    .initial_address(initial_address),
    .write_enable_in(write_enable_in),
    .enable(enable),
    .reset(reset),
    .weight_size(weight_size),
    .image_height(image_height),
    .image_width(image_width),
    .c_address(c_address),
    .offset(offset),
    .write_enable_out(write_enable_out),
    .completed(completed)
);

endmodule
