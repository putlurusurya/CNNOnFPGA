
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

    parameter data_size=16;
    parameter array_size=9;
    parameter dim_data_size=16;
    localparam weight_size=data_size*array_size*array_size;
    localparam mac_size=data_size*array_size;
    reg s_clk;
    reg reset;
    reg w_clk;
    wire [mac_size-1:0] macout;

    wire [mac_size-1:0] relu_out;
    wire [mac_size-1:0] buffer_in;
    wire [mac_size-1:0] systolic_dataout;
    reg enable;

    wire [weight_size-1:0] weight_in;
    reg [array_size-1:0] r_en;
    reg weight_write_enable;
    wire w_done;
    reg clear;
    reg s_reset;
    reg w_reset;
    reg bias_reset;
    reg [array_size-1:0] bias_enable; 
    wire [array_size-1:0] bias_done;
    reg [array_size-1:0] relu_r_en;
    reg [array_size-1:0] relu_w_en;
    reg [array_size-1:0] relu_clear;
    reg  [array_size-1:0] buffer_fill_reset;
    reg [array_size-1:0] buffer_fill_enable;
    reg [array_size-1:0] maxpool_arr_r_en;
    reg [array_size-1:0] maxpool_arr_enable;
    reg [array_size-1:0] maxpool_fill_enable;
    wire [array_size*data_size-1:0] buffer_out;
    
    reg [array_size-1:0] is_empty;
    reg maxpool_fill_reset;
    wire maxpool_done;
    wire [mac_size-1:0] max_pool_output1;
    reg maxpool_clear;
    
    wire [array_size-1:0] buff_write_enable_out;
    wire [14*array_size-1:0] buffer_fill_address;
    wire [13:0] maxpool_addr_out;
    
    top_module4 uut(
        .s_clk(s_clk),
        .w_clk(w_clk),
        .relu_out(relu_out),
        .macout(macout),
        .reset(reset),
        .enable(enable),
        .r_en(r_en),
        .w_done(w_done),
        .clear(clear),
        .s_reset(s_reset),
        .w_reset(w_reset),
        .weight_write_enable(weight_write_enable),
        .weightin(weight_in),
        .bias_reset(bias_reset),
        .bias_enable(bias_enable),
        .bias_done(bias_done),
        .relu_r_en(relu_r_en),
        .relu_w_en(relu_w_en),
        .buffer_in(buffer_in),
        .relu_clear(relu_clear),
        .buffer_fill_reset(buffer_fill_reset),
        .buffer_fill_enable(buffer_fill_enable),
        .is_empty(is_empty),
        .systolic_dataout(systolic_dataout),
        .maxpool_fill_reset(maxpool_fill_reset),
        .maxpool_arr_r_en(maxpool_arr_r_en),
        .maxpool_done(maxpool_done),
        .maxpool_clear(maxpool_clear),
        .maxpool_arr_enable(maxpool_arr_enable),
        .max_pool_output1(max_pool_output1),
        .maxpool_fill_enable(maxpool_fill_enable),
        .buffer_out(buffer_out),
        .buff_write_enable_out(buff_write_enable_out),
        .buff_fill_address(buffer_fill_address),
        .maxpool_addr_out(maxpool_addr_out)
    );
    initial
    begin
            
            //weight_in<=647'h000000000000000003000000000000000002000000000000000001000000000000000003000000000000000002000000000000000001000000000000000003000000000000000002000000000000000001;
            reset <= 0;
            s_reset<=0;
            w_reset<=0;
            clear <=0;
            enable<=1;
            s_clk <= 1'b0;
            
            w_clk <= 1'b0;
            bias_reset<=0;
            maxpool_fill_reset<=0;
            maxpool_clear<=0;
            r_en <= 9'b000000000;
            relu_r_en <= 9'b000000000;
            relu_w_en <= 9'b000000000;
            relu_clear <= 9'b000000000;
            is_empty<=0;
            buffer_fill_reset <=0;
            buffer_fill_enable <= 9'b000000000;
            maxpool_fill_enable<=0;
            bias_enable<=0;
            weight_write_enable<=1;
            maxpool_arr_r_en<=0;
            #100;
            maxpool_fill_reset<=1;
            maxpool_clear<=1;
            maxpool_arr_enable<=0;
            relu_clear <= 9'h1ff;
            buffer_fill_reset <= 9'h1ff;
            w_reset<=1;
            bias_reset<=1;
            reset<=1;
            clear<=1;
            #800;
            r_en<=9'b000000001;
            
            s_reset<=1;
            #200;
            r_en<=9'b000000011;
            #200;
            r_en<=9'b000000111;
            #200;
            r_en<=9'b000001111;
            #200;
            r_en<=9'b000011111;
            #200;
            r_en<=9'b000111111;
            #200;
            r_en<=9'b001111111;
            #200;
            r_en<=9'b011111111;
            #200;
            r_en<=9'b111111111;
            
            #200;
            r_en<=9'h1ff;
            bias_enable<=9'h1ff;
            #200;
            
            buffer_fill_enable<=9'b000000001;
            #200;
            buffer_fill_enable<=9'b000000011;
            #200;
            buffer_fill_enable<=9'b000000111;
            #200;
            buffer_fill_enable<=9'b000001111;
            #200;
            buffer_fill_enable<=9'b000011111;
            #200;
            buffer_fill_enable<=9'b000111111;
            #200;
            buffer_fill_enable<=9'b001111111;
            #200;
            buffer_fill_enable<=9'b011111111;
            #200;
            buffer_fill_enable<=9'b111111111;
            #1800;
          
            maxpool_arr_enable<=9'h1ff;
            #10;
            maxpool_fill_enable<=9'h1ff;
            #10;
            maxpool_arr_r_en<=9'h1ff;
            
            
            
    end
     initial begin
      forever #100 s_clk <= ~s_clk;
     end
     
     initial begin
      forever #1 w_clk <= ~w_clk;
     end
    
endmodule
