`timescale 1ns / 1ps								
//////////////////////////////////////////////////////////////////////////////////								
// Company: 								
// Engineer: 								
// 								
// Create Date: 14.02.2021 15:17:21								
// Design Name: 								
// Module Name: weight_fill_control								
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
								
								
								
module weight_fill_control#(								
    parameter data_size=16,								
    parameter array_size=9,								
    parameter dim_data_size=16								
)(								
    input clk,								
    input [13:0] initial_address,								
    input enable,								
    input reset,								
    input [dim_data_size-1:0] weight_size,								
    input [dim_data_size-1:0] number_filters,								
    output reg [data_size*array_size*array_size-1:0] weight_out,								
    output reg done								
    );								
    								
    reg [2:0] state;								
    reg [2:0] state1;								
    reg [2:0] state2;								
    reg [13:0] c_address;								
    reg [13:0] c_address1;								
    reg [13:0] c_address2;								
    integer ncount;								
    integer ecount;								
    wire [data_size-1:0] bus;								
    reg [data_size-1:0] bus1;								
    reg [array_size*data_size-1:0] temp_weights;								
    localparam init=3'b000;								
    localparam iter=3'b001;								
    localparam store=3'b010;								
    localparam delay1=3'b100;								
    localparam delay2=3'b110;								
    localparam finish=3'b101;								
    localparam shift=3'b011;								
        weightRom weightRom (								
            .clka(clk),   								
            .addra(c_address), 							
            .douta(bus)  								
        );								
    always @(posedge clk or negedge reset) begin								
        bus1<=bus;								
        if(!reset)begin 								
            state<=init;								
            c_address<=initial_address;								
            done<=0;								
            ncount<=0;								
            ecount<=0;								
            temp_weights<=0;								
        end								
        else if(enable) begin								
            case (state)								
                init:begin								
                        weight_out<=0;								
                        c_address<=initial_address+(number_filters-1)*weight_size*weight_size+weight_size*weight_size-1;								
                        state<=iter;  								
                    end								
                 iter:begin								
                        								
                        c_address2<=initial_address+(number_filters-1-ncount)*weight_size*weight_size+weight_size*weight_size-1-ecount;								
                        								
                        state<=delay1;								
                    end								
                 delay1:begin								
                        c_address1<=c_address2;								
                        state<=delay2;								
                 end								
                 delay2:begin								
                        temp_weights[data_size-1:0]<=bus1;								
                        c_address<=c_address1;								
                        ncount<=ncount+1;								
                        state<=store;								
                 end								
                 store:begin								
                        if(ncount==number_filters+1)begin								
                            								
                            weight_out[array_size*data_size-1:0]<=temp_weights;								
                            state<=shift;								
                            ecount<=ecount+1;								
                        end								
                        else begin								
                            temp_weights<=temp_weights<<data_size;								
                            state<=iter;								
                        end								
                 end								
                 shift:begin								
                        if(ecount==weight_size*weight_size)begin								
                          								
                            state<=finish;								
                        end								
                        else begin								
                            weight_out<=weight_out<<array_size*data_size;								
                            state<=iter;								
                            ncount<=0;								
                            temp_weights<=0;								
                        end								
                 end								
                 finish:begin								
                        								
                        done<=1;								
                 end								
                    								
            endcase								
        end    								
    end								
    								
endmodule								
