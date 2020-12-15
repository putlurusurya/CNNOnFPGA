`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.12.2020 13:05:44
// Design Name: 
// Module Name: maxpool
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
module maxPooling#(
    parameter data_size=8
)(
    input clk,
	input [data_size-1:0] input1,
	input [data_size-1:0] input2,
	input [data_size-1:0] input3,
	input [data_size-1:0] input4,
	input enable,
    output reg signed [data_size-1:0] output1,
	output reg maxPoolingDone
    );
	
	reg [data_size-1:0] initialMax = 8'b10000000;
	reg [data_size-1:0] tempOutput;
	
	always @ (posedge clk) begin
		if(enable) begin
			if($signed(initialMax) < $signed(input1)) begin
				if($signed(input2) < $signed(input1)) begin
					if($signed(input3) < $signed(input1)) begin
						if($signed(input4) < $signed(input1)) begin
							output1 <= input1;
							maxPoolingDone <= 1;
						end
						else begin
							output1 <= input4;
							maxPoolingDone <= 1;
						end
					end
					else begin
						if($signed(input3) < $signed(input4)) begin
							output1 <= input4;
							maxPoolingDone <= 1;
						end
						else begin
							output1 <= input3;
							maxPoolingDone <= 1;
						end
					end
				end
				else begin
					if($signed(input3) < $signed(input2)) begin
						if($signed(input4) < $signed(input2)) begin
							output1 <= input2;
							maxPoolingDone <= 1;
						end
						else begin
							output1 <= input4;
							maxPoolingDone <= 1;
						end
					end
					else begin
						if($signed(input3) < $signed(input4)) begin
							output1 <= input4;
							maxPoolingDone <= 1;
						end
						else begin
							output1 <= input3;
							maxPoolingDone <= 1;
						end
					end
				end
			end
			else begin
				output1 <= initialMax;
				maxPoolingDone <= 1;
			end
		end
		else begin
			output1 <= 0;
			maxPoolingDone <= 0;
		end
	end


endmodule
