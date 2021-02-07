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
    reg enable;
    reg [weight_size-1:0] weight_in;
    reg [array_size-1:0] r_en;
   
    wire done;
    reg clear;
    reg s_reset;
    
   
    top_module uut(
        .s_clk(s_clk),
        .w_clk(w_clk),
        .macout(macout),
        .weightin(weight_in),
        .reset(reset),
        .enable(enable),
        .r_en(r_en),
        .done(done),
        .clear(clear),
        .s_reset(s_reset)
    );
    initial
    begin
            
            weight_in<=647'h000000000000000003000000000000000002000000000000000001000000000000000003000000000000000002000000000000000001000000000000000003000000000000000002000000000000000001;
            reset <= 0;
            s_reset<=0;
            clear <=1;
            enable<=1;
            s_clk <= 1'b0;
            w_clk <= 1'b0;
            r_en <= 9'b000000000;
            #10;
            reset<=1;
            clear<=0;
            #285;
            r_en<=9'b000000001;;
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
            
    end
     initial begin
      forever #100 s_clk <= ~s_clk;
     end
     
     initial begin
      forever #1 w_clk <= ~w_clk;
     end
    
endmodule
