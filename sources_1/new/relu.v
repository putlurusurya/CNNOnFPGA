`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.11.2020 21:06:46
// Design Name: 
// Module Name: relu
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
module reluArr#(
    parameter data_width = 8,
	parameter array_size = 9,
	localparam arr_width = data_width*array_size
)(
    input clk,
	input [array_size-1:0] en,
	input [arr_width-1:0] in,
	output [arr_width-1:0] out0
);
    
    genvar i;
    generate
    for(i=0;i<array_size;i=i+1)begin
        relufunc relu_arr[array_size-1:0] (
            .clk(clk),
            .en (en[i]),
            .in (in[(i+1)*data_width-1:i*data_width]),
            .out(out0[(i+1)*data_width-1:i*data_width])
        );
        end
	endgenerate
	
	

endmodule 
module relufunc#(
    parameter data_width = 8
)(
    input clk,
    input en,
    input signed [data_width-1:0] in,
    output reg signed [data_width-1:0] out
);
    always@(posedge clk)begin
        out <= (in > 0 && en) ? in : 0;
    end
endmodule