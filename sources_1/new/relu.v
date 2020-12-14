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
	parameter no_relu = 8,
	localparam arr_width = data_width*no_relu
)(
	input en,
	input [arr_width-1:0] in,
	output wire [arr_width-1:0] out
);
	relufunc relu_arr[no_relu-1:0] (
        .en (en),
		.in (in),
		.out(out)
	);

endmodule 
module relufunc#(
    parameter data_width = 8
)(
    input en,
    input signed [data_width-1:0] in,
    output wire signed [data_width-1:0] out
);
    assign out = (in > 0 && en) ? in : 0;

endmodule