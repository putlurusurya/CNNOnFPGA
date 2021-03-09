`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.03.2021 01:12:12
// Design Name: 
// Module Name: mux
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


module mux#(
    parameter array_size=9
)(
    input [array_size-1:0] in1,
    input [array_size-1:0] in2,
    output reg [array_size-1:0] out,
    input sel

    );
    
    always @* begin
        if(sel) begin
            out<=in2;
        end
        else begin
            out<=in1;
        end
    end
endmodule
