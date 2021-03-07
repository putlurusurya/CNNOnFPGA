`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.02.2021 10:40:52
// Design Name: 
// Module Name: buffer_fill_array
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


module buffer_fill_array#(
    parameter dimdata_size=16,
    parameter array_size=9
)(
        input w_clk,
        input [array_size-1:0] enable,
        input [array_size-1:0] reset,
        input [13:0] initial_address,
        input [dimdata_size-1:0] output_featuremapsize,
        input [array_size-1:0] is_empty,
        output [14*array_size-1:0] c_address,
        output [array_size-1:0] write_enable,
        output [array_size-1:0] done
    );
    genvar i;
    generate
        for(i=0;i<array_size;i=i+1)begin
            output_fill of(
                .w_clk(w_clk),
                .enable(enable[i]),
                .reset(reset[i]),
                .initial_address(initial_address),
                .output_featuremapsize(output_featuremapsize),
                .is_empty(is_empty[i]),
                .c_address(c_address[(i+1)*14-1:i*14]),
                .write_enable(write_enable[i]),
                .done(done[i])
            );
        end
    endgenerate
endmodule
