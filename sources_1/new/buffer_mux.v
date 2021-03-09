`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2021 22:24:12
// Design Name: 
// Module Name: buffer_mux
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


module buffer_mux#(
    parameter array_size = 9 ,
    parameter data_size=16,
    parameter weight_size=data_size*array_size*array_size,
    parameter mac_size=data_size*array_size,
    parameter dimdata_size=16
    )(
    input [data_size*array_size-1:0] in1,
    input [data_size*array_size-1:0] in2,
    input [data_size*array_size-1:0] in3,
    input [data_size*array_size-1:0] in4,
    input [data_size*array_size-1:0] in5,
    input [2:0] sel,
    output reg [data_size*array_size-1:0] out
    );
    reg [array_size*data_size-1:0] temp;
    always @* begin
        case(sel)
            3'b000:begin
                out<=in1;
            end
            3'b001:begin
                out<=in2;
            end
            3'b010:begin
                out<=in3;
            end
            3'b011:begin
                out<=in4;
            end
            3'b100:begin
                out<=in5;
            end
            default:begin
                out<=0;
            end
        endcase
    end
endmodule