
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
    wire  [mac_size-1:0] macout;
    wire  [mac_size-1:0] relu_out;
    reg enable;
    wire [weight_size-1:0] weight_in;
    reg [array_size-1:0] r_en;
    reg weight_write_enable;
    wire done;
    wire w_done;
    reg clear;
    reg s_reset;
    reg w_reset;
    
   
    top_module1 uut(
        .s_clk(s_clk),
        .w_clk(w_clk),
        .relu_out(relu_out),
        .macout(macout),
        .reset(reset),
        .enable(enable),
        .r_en(r_en),
        .done(done),
        .w_done(w_done),
        .clear(clear),
        .s_reset(s_reset),
        .w_reset(w_reset),
        .weight_write_enable(weight_write_enable),
        .weightin(weight_in)
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
            r_en <= 9'b000000000;
            weight_write_enable<=1;
            #10;
            w_reset<=1;
            
            reset<=1;
            clear<=1;
            #28500;
            r_en<=9'b000000001;;
            s_reset<=1;
            #2;
            r_en<=9'b000000011;
            #2;
            r_en<=9'b000000111;
            #2;
            r_en<=9'b000001111;
            #2;
            r_en<=9'b000011111;
            #2;
            r_en<=9'b000111111;
            #2;
            r_en<=9'b001111111;
            #2;
            r_en<=9'b011111111;
            #2;
            r_en<=9'b111111111;
            #2;
            r_en<=9'h1ff;
            
    end
     initial begin
      forever #1 s_clk <= ~s_clk;
     end
     
     initial begin
      forever #100 w_clk <= ~w_clk;
     end
    
endmodule
