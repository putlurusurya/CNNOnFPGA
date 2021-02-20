`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.02.2021 12:20:05
// Design Name: 
// Module Name: maxpool_array_tb
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


module maxpool_array_tb();
    parameter data_size=16;
    parameter array_size=9;
    reg r_clk;
    reg w_clk;
    reg [array_size-1:0] r_en;

    wire [4*array_size-1:0] full;
    wire [4*array_size-1:0] empty;
    reg [data_size*array_size-1:0] data_in;
    reg [4*array_size-1:0] sel;
    reg clear;
    reg [array_size-1:0] enable;
    wire [data_size*array_size-1:0] output1;
    wire [array_size-1:0] maxPoolingDone;
    
    maxpool_array uut(
        .r_clk(r_clk),
        .w_clk(w_clk),
        .r_en(r_en),
        .full(full),
        .empty(empty),
        .data_in(data_in),
        .sel(sel),
        .clear(clear),
        .maxPoolingDone(maxPoolingDone),
        .output1(output1),
        .enable(enable)
    );
    initial begin
        r_clk<=0;
        w_clk<=0;
        clear<=0;
        r_en<=0;
        enable<=0;
        sel<=0;
        
        data_in<=144'h000100020003000400050006000700080009;
        #20
        clear<=1;
        #1000
        sel<=36'h111111111;
        #1000
        sel<=36'h222222222;
        #1000
        sel<=36'h444444444;
        #1000
        sel<=36'h888888888;
        #1000
        sel<=0;
        r_en<=9'h1ff;
        enable<=9'h1ff;
        
    end
    initial begin
        forever #10 r_clk<=~r_clk;
    end
    initial begin
        forever #1 w_clk<=~w_clk;
    end

endmodule
