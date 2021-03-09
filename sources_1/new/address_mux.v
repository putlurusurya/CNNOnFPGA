`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2021 23:29:32
// Design Name: 
// Module Name: address_mux
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


module address_mux#(
    parameter array_size=9
)(
    input [14*array_size-1:0] in1,
    input [14*array_size-1:0] in2,
    input [14*array_size-1:0] in3,
    
    input [1:0] sel,
    output reg [14*array_size-1:0] out
    );
    always @* begin
        case(sel)
            2'b00:begin
                out<=in1;
            end
            2'b01:begin
                out<=in2;
            end
            2'b10:begin
                out<=in3;
            end
            default:begin
                out<=0;
            end
            
        endcase
    end
endmodule
