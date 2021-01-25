`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.12.2020 15:20:51
// Design Name: 
// Module Name: fifo_tb
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



module fifo_tb;
    parameter fifo_depth = 256;
	parameter data_size = 8;
	parameter log_depth = 8;       // log2 of fifo_depth for tracking position of wptr and rptr
	parameter array_size = 9; 
	reg s_clk;
	reg w_clk;
	reg clear;
	reg r_en;
	reg  w_en;
	reg [7:0] datain;
	wire [data_size-1:0] out;
	wire  empty;
	wire  full;
	
	fifo fifoarr(
            .r_clk(s_clk),
            .w_clk(w_clk),
            .r_en(r_en),
            .w_en(w_en),
            .clear(clear),
            .full(full),
            .empty(empty),
            .dataIn(datain),
            .dataOut(out)
             ); 
    initial begin
		s_clk <= 0;
		w_clk <= 0;
		clear <= 1;
		#10;
		w_en<=1;
		r_en<=0;
		clear<=0;
		datain<=8'h01;
		#10;
		w_en=0;
		r_en<=1;
	end
    
	initial begin
		forever #5 s_clk = ~s_clk;
	end
    initial begin
		forever #5 w_clk = ~w_clk;
	end
	
endmodule
