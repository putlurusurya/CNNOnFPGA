`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.12.2020 09:46:27
// Design Name: 
// Module Name: Fifo_ddf
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


module Fifo_ddf#(
    parameter data_size=8,
    parameter array_size=4,
    parameter fifo_depth=8,
    localparam fifo_width=array_size*data_size
)(
    input clk,
    input reset,
    input [array_size-1:0] en,
    input weightIn,
    input weightOut
);

    

    wire [array_size*fifo_depth-1:0] enable;  
    wire [array_size*fifo_depth-1:0] datain;  
    wire [array_size*fifo_depth-1:0] dataout;   
    dff dffArray[array_size*fifo_depth-1:0] (  
        .clk(clk),
        .reset(reset),
        .en(enable),
        .d(datain),
        .q(dataout)
    );

    assign datain[fifo_width-1:0] = weightIn;  
    assign weightOut = dataout[fifo_width*fifo_depth-1:fifo_width*(fifo_depth-1)];  
    
    generate
        genvar i;
        for (i=1; i<fifo_depth; i=i+1) begin 
            assign datain[fifo_width*(i+1)-1:fifo_width*i] = dataout[fifo_width*i-1:fifo_width*(i-1)];
        end  
    endgenerate

    generate
        genvar j;
        for (i=0; i<array_size; i=i+1) begin 
            for (j=0; j<fifo_depth; j=j+1) begin 
                assign enable[j*fifo_depth+i] = en[i]; 
            end  
        end 
    endgenerate
endmodule