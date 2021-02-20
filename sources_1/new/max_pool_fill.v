`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.02.2021 09:03:07
// Design Name: 
// Module Name: max_pool_fill
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

module max_pool_fill#(
	parameter matrix_size = 24,
	parameter add_size = 20
)(
	input [add_size-1:0] add_in,
	input clk,
	input reset,
	output reg [add_size-1:0] add_out,
	output reg done
);

	reg [add_size-1:0] start_add;
	reg [add_size-1:0] x,y;
	reg [1:0] cnt = 0;
	reg [add_size-1:0] track;
	
	
	
	always@(posedge clk)
	begin
	    if(~reset)begin
		x <= 0;
		y <=0;
		cnt <=0;
		done <= 0;
		track <= 0;
		start_add <= add_in;
		end
		else if(~done)
		begin
			add_out = start_add + (matrix_size * (x + cnt[1])) + y + cnt[0] ;
			if(cnt == 2'b11)
			begin
				y = (y+1) % (matrix_size-1);
				if(y == 0)
					x = (x+1)% (matrix_size-1);
			end
			cnt = cnt + 1;
			track = track +1;
		end
		if(track == (matrix_size-1)*(matrix_size-1)*4)
			done = 1;
	end
endmodule
		
		
		
		
		
