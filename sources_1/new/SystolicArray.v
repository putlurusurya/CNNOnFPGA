`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.11.2020 14:25:07
// Design Name: 
// Module Name: SystolicArray
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



module systolic_array#(
    parameter array_size = 4 ,
    localparam data_size=8*array_size,
    localparam weight_size=8*array_size,
    localparam mac_size=8*array_size*array_size
    )
(
    input clk,
    input reset,
    input [data_size-1:0] datain,
    input [weight_size-1:0] weightin,
    output [mac_size-1:0] macout

    );
    
    
    wire [7:0] data_wire [0:array_size][0:array_size];
    wire [7:0] weight_wire [0:array_size][0:array_size];
    
    genvar i,j;
    
    generate
        for (i=0;i<array_size;i=i+1) begin
            for (j=0;j<array_size;j=j+1) begin
                
                    element e1(
                    .clk(clk),
                    .reset(reset),
                    .in_a(datain[(i+1)*8-1:i*8]),
                    .in_b(weightin[(j+1)*8-1:j*8]),
                    .out_c(macout[(i*array_size+j+1)*8-1:(i*array_size+j)*8]),
                    .out_a(data_wire[i][j+1]),
                    .out_b(weight_wire[i+1][j])
                    );
                end
        end
    endgenerate 
endmodule
