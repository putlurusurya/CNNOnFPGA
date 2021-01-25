`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.12.2020 15:14:22
// Design Name: 
// Module Name: top_module
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


module top_module#(
    parameter array_size = 9 ,
    localparam data_size=8,
    localparam weight_size=8*array_size*array_size,
    localparam mac_size=8*array_size,
    parameter dim_data_size=8
    )(
    input s_clk,
    input w_clk,
    input reset,
    input s_reset,
    input clear,
    input enable,
    output [mac_size-1:0] macout,
    input [19:0] initial_address,
    input [dim_data_size-1:0] Weight_size,
    input [dim_data_size-1:0] image_height,
    input [dim_data_size-1:0] image_width,
    input [weight_size-1:0] weightin,
    input [array_size-1:0] r_en,
    output [data_size*array_size-1:0] dataout,
    output [data_size-1:0] datain,
    output [array_size-1:0] w_en,
    output [array_size-1:0] full,
    output [array_size-1:0] empty,
    output done
    );

    wire [2:0] state;
    
    
    systolic_array s_ar(
        .clk(s_clk),
        .reset(s_reset),
        .datain(dataout),
        .weightin(weightin),
        .macout(macout)
    );
    
    fifo_array f_arr(
            .r_clk(s_clk),
            .w_clk(w_clk),
            .r_en(r_en),
            .w_en(w_en),
            .clear(clear),
            .full(full),
            .empty(empty),
            .in_bus(datain),
            .out_bus(dataout)
             ); 
             
      fifo_fill_control f_c(
        .clk(w_clk),
        .initial_address(initial_address),
        .enable(enable),
        .reset(reset),
        .weight_size(Weight_size),
        .image_height(image_height),
        .image_width(image_width),
        .bus(datain),
        .write_enable_out(w_en),
        .done(done),
        .state(state)
        
        );
        
endmodule
