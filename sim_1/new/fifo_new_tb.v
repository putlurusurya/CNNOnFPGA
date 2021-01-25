`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.12.2020 20:35:59
// Design Name: 
// Module Name: fifo_new_tb
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


module new_fifo_tb();
    parameter fifo_depth = 256;
	parameter data_size = 8;
	parameter log_depth = 3;       // log2 of fifo_depth for tracking position of wptr and rptr
	parameter array_size = 9; 
	reg r_clk;
	reg w_clk;
	reg clear;
	reg [array_size-1:0]r_en;
	reg [array_size-1:0] w_en;
	reg [7:0] datain;
	wire [data_size*array_size-1:0] out;
	wire [array_size-1:0] empty;
	wire [array_size-1:0] full;

	fifo_array dut(
		.r_clk(r_clk),
        .w_clk(w_clk),
        .r_en(r_en),
        .w_en(w_en),
        .clear(clear),
        .full(full),
        .empty(empty),
        .in_bus(datain),
        .out_bus(out)
	);

	initial begin
		r_clk <= 0;
		w_clk <= 0;
		clear <= 1;
		#10;
		clear<=0;
		w_en <=9'b0_0000_0001;
		r_en <=9'b0_0000_0000;
		datain<=8'h01;
		#10;
		w_en <=9'b0_0000_0010;
		datain<=8'h02;
		#10;
		w_en <=9'b0_0000_0100;
		datain<=8'h03;
		#10;
		w_en <=9'b0_0000_1000;
		datain<=8'h04;
		#10;
		w_en <=9'b0_0001_0000;
		datain<=8'h05;
		#10;
		w_en <=9'b0_0010_0000;
		datain<=8'h06;
		#10;
		w_en <=9'b0_0100_0000;
		datain<=8'h07;
		#10;
		w_en <=9'b0_1000_0000;
		datain<=8'h08;
		#10;
		w_en <=9'b1_0000_0000;
		datain<=8'h09;
		#10;
		w_en <=9'b0_0000_0000;
		#10;
		
		r_en <=9'b0_0000_0001;
		#10;
        r_en <=9'b0_0000_0010;
		#10;
        r_en <=9'b0_0000_0100;
		#10;
        r_en <=9'b0_0000_1000;
		#10;
        r_en <=9'b0_0001_0000;
		#10;
        r_en <=9'b0_0010_0000;
		#10;
        r_en <=9'b0_0100_0000;
		#10;
        r_en <=9'b0_1000_0000;
		#10;
        r_en <=9'b1_0000_0000;
        #100;
        $stop;
		
		
	end
	
	initial begin
		forever #5 r_clk = ~r_clk;
	end
    initial begin
		forever #5 w_clk = ~w_clk;
	end
	
	
endmodule	
