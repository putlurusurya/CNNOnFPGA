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
module reluArr#(
        parameter data_width = 16,
        parameter array_size = 9,
        localparam arr_width = data_width*array_size
    )(
        input clk,
        input [array_size-1:0] en,
        input [arr_width-1:0] in,
        output [arr_width-1:0] out0
    );
    
    genvar i;
    generate
        for(i=0;i<array_size;i=i+1)begin
            relufunc relu_arr (
                .clk(clk),
                .en (en[i]),
                .in (in[(i+1)*data_width-1:i*data_width]),
                .out(out0[(i+1)*data_width-1:i*data_width])
            );
        end
	endgenerate

endmodule 

module relufunc#(
    parameter data_width = 16
)(
    input clk,
    input en,
    input [data_width-1:0] in,
    output reg [data_width-1:0] out
);
    always@(posedge clk)begin
        if(en)begin
            out <= ($signed(in) > 0) ? in : 0;
        end
    end
endmodule