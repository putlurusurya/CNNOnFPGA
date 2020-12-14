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
module max_pooling #(
    parameter data_size=8,
    parameter pool_size=2    
)(
    input clk,
    input enable,
    input [data_size*pool_size*pool_size-1:0] data,
    output reg [data_size-1:0] maxpool
    );
    
    reg gmax=8'b1111_1111;
    reg temp;
    always@(posedge clk)
    begin
    if(enable)
    begin
        maxpool<=max_value();
    end
    else
    begin
        maxpool<=0;
    end 
    end
endmodule


