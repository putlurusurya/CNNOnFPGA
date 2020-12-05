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
    input wire [data_size-1:0] in_a,
    input wire [data_size-1:0] in_b,
    output reg [2*data_size:0] out_c,
    output reg [data_size-1:0] out_a,
    output reg [data_size-1:0] out_b
    );
         
         always @(posedge clk)begin
            if(reset) begin
              out_a=0;
              out_b=0;
              out_c=0;
            end
            else begin  
              out_c=out_c+in_a*in_b;
              out_a=in_a;
              out_b=in_b;
            end
         end
         
endmodule



