`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.12.2020 16:10:52
// Design Name: 
// Module Name: top_module_tb
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


module top_module_tb;

    parameter data_size=8;
    parameter array_size=9;
    parameter dim_data_size=8;
    localparam weight_size=8*array_size*array_size;
    localparam mac_size=8*array_size;
    reg s_clk;
    reg reset;
    reg w_clk;
    reg [19:0] initial_address;
    reg [dim_data_size-1:0] Weight_size;
    reg [dim_data_size-1:0] image_height;
    reg [dim_data_size-1:0] image_width;
    wire  [mac_size-1:0] macout;
    reg enable;
    reg [weight_size-1:0] weight_in;
    reg [array_size-1:0] r_en;
   
    top_module uut(
        .s_clk(s_clk),
        .w_clk(w_clk),
        .Weight_size(Weight_size),
        .image_height(image_height),
        .image_width(image_width),
        .initial_address(initial_address),
        .macout(macout),
        .weightin(weight_in),
        .reset(reset),
        .enable(enable),
        .r_en(ren)
    );
    initial
    begin
            Weight_size<=3;
            image_height<=5;
            image_width<=5;
            initial_address<=0;
            weight_in<=648'h0000000000000000090000000000000000080000000000000000007000000000000000006000000000000000005000000000000000004000000000000000003000000000000000002000000000000000001;
            reset <= 0;
            enable<=1;
            s_clk <= 1'b0;
            w_clk <= 1'b0;
            #10;
            reset<=1;
            #200;
            r_en<=9'h1ff;
            #10000;
    end
     initial begin
      forever #100 s_clk <= ~s_clk;
     end
     
     initial begin
      forever #1 w_clk <= ~w_clk;
     end
    
endmodule
