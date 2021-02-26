`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.02.2021 09:28:10
// Design Name: 
// Module Name: Bias_adder
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


module Bias_adder#(
        parameter data_size=16,
        parameter array_size=9
    )(  
        input clk,
        input mode,
        input reset,
        input [array_size-1:0] enable,
        input [array_size*data_size-1:0] macout,
        input [array_size*data_size-1:0] biases,
        output [array_size*data_size-1:0] added_output,
        output [array_size-1:0] done
    );
        reg [array_size*data_size-1:0] sum;
        reg [array_size*data_size-1:0] op_2;
        
        genvar i;
        wire [data_size-1:0] out;
        generate
            for(i=0;i<array_size;i=i+1) begin
               
               adder add(
                    .enable(enable[i]),
                    .a(macout[(i+1)*data_size-1:i*data_size]),
                    .b(op_2[(i+1)*data_size-1:i*data_size]),
                    .out(added_output[(i+1)*data_size-1:i*data_size]),
                    .done(done[i])
               );
            end
        endgenerate
        always@(posedge clk or negedge reset)begin
            if(~reset)begin
                sum<=0;
            end
            else if(enable)begin
                if(mode)begin
                    op_2<=biases;
                end
                else begin
                    sum<=added_output;
                    op_2<=sum;
                end
            end
        end
    
endmodule
module adder#(
    parameter data_size=16
)(
    input enable,
    input signed [data_size-1:0] a,
    input signed[data_size-1:0] b,
    output reg signed [data_size-1:0]out,
    output reg done
);
    always @* begin
        if(enable) begin
            out = a+b;
            done = 1;
        end
        else begin
            out = 0;
            done = 0;
        end
    end
endmodule
