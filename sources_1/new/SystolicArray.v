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
    parameter array_size = 3,
    localparam data_size=8*array_size,
    localparam weight_size=8*array_size,
    localparam mac_size=16*array_size
    )
(
    input clk,
    input reset,
    input [data_size-1:0] datain,
    input [weight_size-1:0] weightin,
    output [mac_size-1:0] macouti,
    output [mac_size-1:0] macoutj

    );
    
    
    wire [7:0] data_wire [0:array_size][0:array_size];
    wire [7:0] weight_wire [0:array_size][0:array_size];
    wire [15:0] mac_wire [0:array_size-1][0:array_size-1];
    
    genvar i,j;
    
    generate
        for (i=0;i<array_size;i=i+1) begin
            for (j=0;j<array_size;j=j+1) begin
                
                    element e1(
                    .clk(clk),
                    .reset(reset),
                    .in_a(datain[(i+1)*8-1:i*8]),
                    .in_b(weightin[(j+1)*8-1:j*8]),
                    .out_c(mac_wire[i][j]),
                    .out_a(data_wire[i][j+1]),
                    .out_b(weight_wire[i+1][j])
                    );
                end
        end
    endgenerate 
    generate
        for(i=0;i<array_size;i=i+1)begin
            assign macouti[(i+1)*16-1:i*16]=mac_wire[i][array_size-1];
            assign macoutj[(i+1)*16-1:i*16]=mac_wire[array_size-1][i];
            
        end
    endgenerate
endmodule
