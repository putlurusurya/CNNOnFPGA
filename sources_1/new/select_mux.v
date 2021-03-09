`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2021 20:07:34
// Design Name: 
// Module Name: select_mux
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


module select_mux#(
    parameter array_size = 9 ,
    parameter data_size=16,
    parameter weight_size=data_size*array_size*array_size,
    parameter mac_size=data_size*array_size,
    parameter dimdata_size=16
    )(
    input [data_size-1:0] in1,
    input [data_size*array_size-1:0] in2,
    input [dimdata_size-1:0] sel,
    output reg [data_size-1:0] out
    );
    reg [array_size*data_size-1:0] temp;
    always @* begin
        if(sel==array_size)begin
            out<=in1;
        end
        else begin
            temp<=in2>>data_size*sel;
            out<=temp[data_size-1:0];
        end
    end
endmodule
