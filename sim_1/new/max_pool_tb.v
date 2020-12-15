`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.12.2020 10:24:10
// Design Name: 
// Module Name: max_pooling
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

// 2x2 max pooling


module max_pool_tb;

	// Inputs
	
	reg [15:0] input1;
	reg [15:0] input2;
	reg [15:0] input3;
	reg [15:0] input4;
	reg clk;
	reg enable;
    
	// Outputs
	wire [15:0] output1;
	wire maxPoolingDone;
	
	reg [15:0] array[0:15];
	

	// Instantiate the Unit Under Test (UUT)
	maxPooling uut (
		.input1(input1), 
		.input2(input2), 
		.input3(input3), 
		.input4(input4), 
		.clk(clk), 
		.out(output1), 
		.maxPoolingDone(maxPoolingDone)
	);
	reg array_image[15:0];
	initial 
	begin
		// Initialize Inputs
		input1 = 0;
		input2 = 0;
		input3 = 0;
		input4 = 0;
		clk = 0;
		#10;
		input1 = 16'b1110000000000011;
		input2 = 16'b1111111111111111;
		input3 = 16'b1111111111111110;
		input4 = 16'b1111111111111100;
		#10;
		input1 = 16'b0000000000000001;
		input2 = 16'b0000000000000100;
		input3 = 16'b0000000000000011;
		input4 = 16'b1111111111111110;
		#10;
		input1 = 16'b0000000000000001;
		input2 = 16'b0000000000000100;
		input3 = 16'b0000000000001010;
		input4 = 16'b1111111111111011;
		#10
		input1 = 16'b0000000000000000;
		input2 = 16'b1111111111111111;
		input3 = 16'b0000000000000000;
		input4 = 16'b0000000000000000;
	
		#30;
	end
initial begin
	forever #5 clk = ~clk;	
end
	
      
endmodule


