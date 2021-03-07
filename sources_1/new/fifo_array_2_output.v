`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.02.2021 09:14:33
// Design Name: 
// Module Name: fifo_array_2
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


module fifo_array_2#(
	parameter fifo_depth = 4096,
	parameter data_size = 16,
	parameter log_depth = 12,        // log2 of fifo_depth for tracking position of wptr and rptr
	parameter array_size = 9       // log2 of fifo_depth for tracking position of wptr and rptr
)(
	input r_clk,
	input w_clk,
	input [array_size-1:0] r_en,
	input [array_size-1:0] w_en,
	input clear,
	input [data_size*array_size-1:0] in_bus,
	output [data_size*array_size-1:0] out_bus,
	output [array_size-1:0] empty,
	output [array_size-1:0] full
);
        genvar i;
        generate
            for(i=0;i<array_size;i=i+1)begin
                fifo fifoarr(
                    .r_clk(r_clk),
                    .w_clk(w_clk),
                    .r_en(r_en[i]),
                    .w_en(w_en[i]),
                    .clear(clear),
                    .full(full[i]),
                    .empty(empty[i]),
                    .dataIn(in_bus[(i+1)*data_size-1:i*data_size]),
                    .dataOut(out_bus[(i+1)*data_size-1:i*data_size])
                     ); 
            end
        endgenerate

endmodule

