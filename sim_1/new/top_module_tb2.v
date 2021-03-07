`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.03.2021 00:01:40
// Design Name: 
// Module Name: top_module_tb2
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


module top_module_tb2(

    );

    parameter data_size=16;
    parameter array_size=9;
    parameter dim_data_size=16;
    localparam weight_size=data_size*array_size*array_size;
    localparam mac_size=data_size*array_size;
    
    reg s_clk;
    reg reset;
    reg w_clk;
    reg enable;
    
    
    wire [mac_size-1:0] max_pool_output1;
    
    
    reg [7:0] initial_instruction_address;
    reg [dim_data_size-1:0] number_instrs;
    
    top_module uut(
        .s_clk(s_clk),
        .w_clk(w_clk),
        
        .reset(reset),
        .enable(enable),
        
        .initial_instruction_address(initial_instruction_address),
        .number_instrs(number_instrs),
        
        .max_pool_output1(max_pool_output1)
        );
    integer count=0;
    initial begin
        s_clk<=0;
        w_clk<=0;
        enable<=1;
        reset<=0;
        initial_instruction_address<=0;
        number_instrs<=5;
        #200;
        reset<=1;
        #60000;
        
    end
    initial begin
      forever begin
          #100 ;
          s_clk <= ~s_clk;
          count<=count+1;
      end
     end
     
     initial begin
      forever #1 w_clk <= ~w_clk;
     end

endmodule
