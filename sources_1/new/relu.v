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
module reluArr(en, in, out);

	parameter DATA_WIDTH = 16;
	parameter ARR_INPUTS = 16;
	
	localparam ARR_WIDTH = DATA_WIDTH*ARR_INPUTS;

	input en;
	input [ARR_WIDTH-1:0] in;
	output wire [ARR_WIDTH-1:0] out;

	reluMux muxArr[ARR_INPUTS-1:0] (
        .en (en),
		.in (in),
		.out(out)
	);

endmodule 
module reluMux(en, in, out);

    parameter DATA_WIDTH = 16;

    input en;
    input signed [DATA_WIDTH-1:0] in;
    output wire signed [DATA_WIDTH-1:0] out;

    assign out = (in > 0 || en) ? in : 0;

endmodule