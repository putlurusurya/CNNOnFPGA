`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.02.2021 16:45:47
// Design Name: 
// Module Name: maxpool_fill_control_array
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


module maxpool_fill_control_array#(
	parameter matrix_size = 16,
	parameter add_size = 14,
	parameter array_size = 9
)(
	input [array_size*add_size-1:0] add_in,
	input clk,
	input reset,
	input [array_size-1:0] enable,
	output  [array_size*add_size-1:0] add_out,
	output  [4*array_size-1:0] sel,
	output  [array_size-1:0]done
);

    genvar i;
    generate
        for(i=0;i<array_size;i=i+1)begin
            max_pool_fill mpf(
                .clk(clk),
                .reset(reset),
                .enable(enable[i]),
                .add_out(add_out[(i+1)*add_size-1:i*add_size]),
                .add_in(add_in[(i+1)*add_size-1:i*add_size]),
                .sel(sel[4*(i+1)-1:i*4]),
                .done(done[i])
            );
        end
    endgenerate

endmodule
