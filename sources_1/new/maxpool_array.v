`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.02.2021 18:59:57
// Design Name: 
// Module Name: maxpool_array
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


module maxpool_array#(
        parameter data_size=16,
        parameter array_size=9
    )(
        input r_clk,
        input w_clk,
        input [array_size-1:0] r_en,
        output [4*array_size-1:0] full,
        output [4*array_size-1:0] empty,
        input [data_size*array_size-1:0] data_in,
        input [3:0] sel,
        input clear,
        input [array_size-1:0] enable,
        output [data_size*array_size-1:0] output1,
        output [array_size-1:0] maxPoolingDone
    );
    genvar i;
    
    wire [data_size*array_size-1:0] out1;
    wire [data_size*array_size-1:0] out2;
    wire [data_size*array_size-1:0] out3;
    wire [data_size*array_size-1:0] out4;

    wire [data_size*array_size-1:0] in1;
    wire [data_size*array_size-1:0] in2;
    wire [data_size*array_size-1:0] in3;
    wire [data_size*array_size-1:0] in4;
    
    generate
        for (i=0;i<array_size;i=i+1)begin
             demux1_4 demux0(
                   .d_in(data_in[(i+1)*data_size-1:i*data_size]),
                   .sel(sel),
                   .d_out1(in1[(i+1)*data_size-1:i*data_size]),
                   .d_out2(in2[(i+1)*data_size-1:i*data_size]),
                   .d_out3(in3[(i+1)*data_size-1:i*data_size]),
                   .d_out4(in4[(i+1)*data_size-1:i*data_size])
                   );
             fifo fifoarr1(
                    .r_clk(r_clk),
                    .w_clk(w_clk),
                    .r_en(r_en[i]),
                    .w_en(sel[0]),
                    .clear(clear),
                    .full(full[i*4]),
                    .empty(empty[i*4]),
                    .dataIn(in1[(i+1)*data_size-1:i*data_size]),
                    .dataOut(out1[(i+1)*data_size-1:i*data_size])
                     ); 
             fifo fifoarr2(
                    .r_clk(r_clk),
                    .w_clk(w_clk),
                    .r_en(r_en[i]),
                    .w_en(sel[1]),
                    .clear(clear),
                    .full(full[i*4+1]),
                    .empty(empty[i*4+1]),
                    .dataIn(in2[(i+1)*data_size-1:i*data_size]),
                    .dataOut(out2[(i+1)*data_size-1:i*data_size])
                     ); 
             fifo fifoarr3(
                    .r_clk(r_clk),
                    .w_clk(w_clk),
                    .r_en(r_en[i]),
                    .w_en(sel[2]),
                    .clear(clear),
                    .full(full[i*4+2]),
                    .empty(empty[i*4+2]),
                    .dataIn(in3[(i+1)*data_size-1:i*data_size]),
                    .dataOut(out3[(i+1)*data_size-1:i*data_size])
                     ); 
             fifo fifoarr4(
                    .r_clk(r_clk),
                    .w_clk(w_clk),
                    .r_en(r_en[i]),
                    .w_en(sel[3]),
                    .clear(clear),
                    .full(full[i*4+3]),
                    .empty(empty[i*4+3]),
                    .dataIn(in4[(i+1)*data_size-1:i*data_size]),
                    .dataOut(out4[(i+1)*data_size-1:i*data_size])
                     ); 
             maxPooling mpu(
                    .clk(r_clk),
                    .input1(out1[(i+1)*data_size-1:i*data_size]),
                    .input2(out2[(i+1)*data_size-1:i*data_size]),
                    .input3(out3[(i+1)*data_size-1:i*data_size]),
                    .input4(out4[(i+1)*data_size-1:i*data_size]),
                    .enable(enable[i]),
                    .output1(output1[(i+1)*data_size-1:i*data_size]),
                    .maxPoolingDone(maxPoolingDone[i])
                    );
            
        end
    endgenerate
    
endmodule
