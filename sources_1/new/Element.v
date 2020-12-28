`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.11.2020 14:25:34
// Design Name: 
// Module Name: Element
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

module element
#(
    parameter data_size=8
    )
(   input clk,
    input reset,
    input wire signed [data_size-1:0] in_a,
    input wire signed [data_size-1:0] in_b,
    input wire signed [data_size-1:0] in_c,
    output reg signed [data_size-1:0] out_c,
    output reg signed [data_size-1:0] out_a,
    input pause
    );
         
         always @(posedge clk or negedge reset)begin
            if(!reset) begin
              out_a<=8'b00000000;
              out_c<=8'b00000000;
            end
            else if (pause) begin
               out_c<=out_c;
               out_a<=out_a;
            end
            else begin  
              out_c<=in_c+in_a*in_b;
              out_a<=in_a;
            end
         end
         
endmodule



