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
    parameter array_size = 2 ,
    localparam data_size=8,
    localparam weight_size=8*array_size*array_size,
    localparam mac_size=8*array_size
    )
(
    input clk,
    input reset,
    input [data_size*array_size-1:0] datain,
    input [weight_size-1:0] weightin,
    output [mac_size-1:0] macout

    );
    
    wire [7:0] macwire [0:array_size][0:array_size-1];
    wire [7:0] data_wire [0:array_size-1][0:array_size];
    
    genvar i,j;
    
    generate 
        for(i=0;i<array_size;i=i+1)begin
        
            assign data_wire[i][0]=datain[(i+1)*data_size-1:i*data_size];
            assign macwire[0][i]=8'b00000000;
            
        end
    endgenerate
    
    generate
        for (i=0;i<array_size;i=i+1) begin
            for (j=0;j<array_size;j=j+1) begin
                
                    element e1(
                    .clk(clk),
                    .reset(reset),
                    .in_a(data_wire[i][j]),
                    .in_b(weightin[(i*array_size+j+1)*8-1:(i*array_size+j)*8]),
                    .in_c(macwire[i][j]),
                    .out_c(macwire[i+1][j]),
                    .out_a(data_wire[i][j+1])
                    );
                    
                end
        end
    endgenerate 
    
    generate 
        for(i=0;i<array_size;i=i+1)begin
        
            assign macout[(i+1)*data_size-1:i*data_size]=macwire[array_size][i];
            
        end
    endgenerate 
endmodule
