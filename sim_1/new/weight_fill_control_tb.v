`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.02.2021 18:36:28
// Design Name: 
// Module Name: weight_fill_control_tb
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


module weight_fill_control_tb();
    parameter data_size=16;
    parameter array_size=9;
    parameter dim_data_size=16;
    reg clk;
    reg [14:0] initial_address;
    reg enable;
    reg reset;
    reg [dim_data_size-1:0] weight_size;
    reg [dim_data_size-1:0] number_filters;
    wire [array_size*array_size*data_size-1:0] weight_out;
    wire done;
    
    weight_fill_control uut(
    .clk(clk),
    .initial_address(initial_address),
    .enable(enable),
    .reset(reset),
    .weight_size(weight_size),
    .done(done),
    .number_filters(number_filters),
    .weight_out(weight_out)
    );
        
    initial
    begin
            weight_size<=3;
            number_filters<=9;
            initial_address<=0;
            reset <= 0;
            enable<=1;
            clk <= 1'b0;
            #500;
            reset<=1;
    end
     
     initial begin
      forever #5 clk <= ~clk;
     end
endmodule
