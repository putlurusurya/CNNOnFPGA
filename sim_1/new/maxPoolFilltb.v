`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.02.2021 09:04:52
// Design Name: 
// Module Name: maxPoolFilltb
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

module fill_tb();
	parameter add_size = 20;
	reg [add_size-1: 0] start_add;
	reg clk;
	reg reset;
	wire [add_size-1:0] add_out;
	wire done;

	max_pool_fillsdf node(.add_in(start_add),.clk(clk),.reset(reset),.add_out(add_out),.done(done));

	initial begin
		
		forever #5 clk <= ~clk;
	end
	initial begin
	    reset <=0;
		clk <= 0;
		#20
		start_add <= 20'b00000000000000000000;
		reset <= 1;
	end	
	
endmodule
