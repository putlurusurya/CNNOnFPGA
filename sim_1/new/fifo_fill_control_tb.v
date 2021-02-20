`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.12.2020 10:53:16
// Design Name: 
// Module Name: fifo_fill_control_tb
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


module fifo_fill_control_tb;
    parameter data_size=8;
    parameter array_size=9;
    parameter dim_data_size=8;
    reg clk;
    reg [19:0] initial_address;
    reg enable;
    reg reset;
    reg [dim_data_size-1:0] weight_size;
    reg [dim_data_size-1:0] image_height;
    reg [dim_data_size-1:0] image_width;
    reg [dim_data_size-1:0] offset;
    wire [data_size-1:0] bus;
    wire [array_size-1:0] write_enable;

    wire done;

    reg [array_size-1:0] write_enable_in;
input_data_rom uut(
    .clk(clk),
    .initial_address(initial_address),
    .write_enable_in(write_enable_in),
    .enable(enable),
    .reset(reset),
    .weight_size(weight_size),
    .image_height(image_height),
    .image_width(image_width),
    .bus(bus),
    .offset(offset),
    .write_enable_out(write_enable),
    .completed(done)
    
);

initial
begin
        weight_size<=2;
        image_height<=5;
        image_width<=5;
        initial_address<=0;
        offset<=5;
        reset <= 0;
        enable<=1;
        clk <= 1'b0;
        write_enable_in<=9'b111111111;
        #50;
        reset<=1;
        #10;
        write_enable_in<=9'b000000000;
end
 
 initial begin
  forever #5 clk <= ~clk;
 end
endmodule
