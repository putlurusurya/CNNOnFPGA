`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.12.2020 11:35:34
// Design Name: 
// Module Name: Dff
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


module dff#(
    parameter data_size = 8
)(
    input clk,
    input reset,
    input en,
    input[data_size-1:0] d,
    output reg [data_size-1:0] q
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 0;
        end
        else if (en) begin
            q <= d;
        end  
        else begin  
            q <= q;
        end  
    end
endmodule
