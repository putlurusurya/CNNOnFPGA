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


module address_mux2#(
    parameter array_size=9
)(
    input [13:0] in1,
    input [13:0] in2,
    
    input  sel,
    output reg [13:0] out
    );
    always @* begin
        case(sel)
            0:begin
                out<=in1;
            end
            1:begin
                out<=in2;
            end
            default:begin
                out<=0;
            end
            
            
        endcase
    end
endmodule
