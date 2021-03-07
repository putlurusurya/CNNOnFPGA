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
	parameter matrix_size = 3,
	parameter add_size = 14
)(
	input [add_size-1:0] add_in,
	input clk,
	input reset,
	input enable,
	output reg [add_size-1:0] add_out,
	output reg [3:0] sel,
	output reg done
);

	reg [add_size-1:0] x,y;
	reg [1:0] cnt = 0;
	reg [add_size-1:0] track;
	reg [3:0]delay1;
	reg [3:0]delay2;
	
	
	always@(posedge clk or negedge reset)
	begin
	    delay1<=delay2;
	    sel<=delay1;
	    if(~reset)begin
		x <= 0;
		y <= 0;
		cnt <= 0;
		done <= 0;
		track <= 0;
		add_out <= 0;
		sel <= 0;
		delay1 <= 0;
		delay2 <= 0;
		end
		else begin
		if(~done && enable)
		begin
		    
			add_out = add_in + (matrix_size * (x + cnt[1])) + y + cnt[0] ;
			delay2=4'b0001<<cnt;
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
	end
endmodule
		
		
		
		
		
