`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.02.2021 16:12:28
// Design Name: 
// Module Name: for_test
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


module for_test#(
        parameter array_size=9,
        parameter data_size=8
)(
    input r_clk,
    input [array_size-1:0] enb,
    output reg [data_size-1:0]bus
    
    );
    reg [data_size*array_size-1:0] doutb=72'h010203040506070809;
    integer j;
    always@(posedge r_clk)begin
        for(j=0;j<array_size;j=j+1)begin
            
            if(enb[j]==1)begin
                doutb<=doutb>>j*data_size;
                bus<=doutb[data_size-1:0];
            end
        end
    end
endmodule
