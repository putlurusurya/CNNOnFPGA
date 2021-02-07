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
    localparam mac_size=data_size*array_size,
    parameter dim_data_size=8
    )(
    input s_clk,
    input w_clk,
    input reset,
    input s_reset,
    input clear,
    input clear_o,
    input enable,
    output [mac_size-1:0] macout,
    
    input [array_size-1:0] r_en,
    output done
    );
    reg [weight_size-1:0] weightin=647'h000000000000000003000000000000000002000000000000000001000000000000000003000000000000000002000000000000000001000000000000000003000000000000000002000000000000000001;
    reg [19:0] initial_address=0;
    reg [dim_data_size-1:0] Weight_size=3;
    reg [dim_data_size-1:0] image_height=5;
    reg [dim_data_size-1:0] image_width=5;
    wire [data_size*array_size-1:0] dataout;
    wire [data_size-1:0] datain;
    wire [array_size-1:0] w_en;
    wire [array_size-1:0] full;
    wire [array_size-1:0] full_o;
    wire [array_size-1:0] empty;
    wire [array_size-1:0] empty_o;
    wire [mac_size-1:0] sigmoid;
    wire [mac_size-1:0] relu;
    wire [mac_size-1:0] d3;
    wire [mac_size-1:0] d4;
    wire [mac_size-1:0] relu_out;
    wire [mac_size-1:0] buffer_in;
    reg [array_size-1:0] relu_enable;
    reg [array_size-1:0] buffer_write_enable;
  
    systolic_array s_ar(
        .clk(s_clk),
        .reset(s_reset),
        .datain(dataout),
        .weightin(weightin),
        .macout(macout)
    );
    
    demux_array demux_arr(
        .sel(sel),
        .d_in(macout),
        .d_out_1(sigmoid),
        .d_out_2(relu),
        .d_out_3(d3),
        .d_out_4(d4)
    );
    
    reluArr(
        .clk(w_clk),
        .en(relu_enable),
        .in(relu),
        .out0(relu_out)
    );
    
    fifo_array_2 output_f_arr(
        .r_clk(w_clk),
        .w_clk(s_clk),
        .r_en(buffer_write_enable),
        .w_en(relu_enable),
        .clear(clear_o),
        .full(full_o),
        .empty(empty_o),
        .in_bus(relu_out),
        .out_bus(buffer_in)
         ); 
    
    fifo_array input_f_arr(
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
             
      fifo_fill_control_2 f_c(
        .clk(w_clk),
        .initial_address(initial_address),
        .write_enable_in(full),
        .enable(enable),
        .reset(reset),
        .weight_size(Weight_size),
        .image_height(image_height),
        .image_width(image_width),
        .bus(datain),
        .write_enable_out(w_en),
        .completed(done)
        );
        
endmodule
