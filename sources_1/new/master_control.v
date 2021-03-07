`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.02.2021 18:14:42
// Design Name: 
// Module Name: master_control
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


module master_control#(
    parameter array_size = 9 ,
    parameter data_size=16,
    parameter weight_size=data_size*array_size*array_size,
    parameter mac_size=data_size*array_size,
    parameter dimdata_size=16
    )(
    
    input clk,
    input reset,  
    input enable,
    
    input [7:0] initial_instruction_address,
    input [dimdata_size-1:0] number_instrs,
    
    //Set1 Fifo fill control and fifo signals

    output reg [array_size-1:0] fifo_r_en,
    output reg fifo_clear,
    
    output reg [13:0] fifo_initial_address,
    output reg fifo_fill_enable,
    output reg fifo_fill_reset,
    output reg [dimdata_size-1:0] image_height,
    output reg [dimdata_size-1:0] image_width,
    output reg [7:0] fifo_offset,
    input  fifo_fill_done,
    
    //systolic array control signals
    output reg s_reset,
    
    //weight fill contrl signals
    output reg [14:0] weight_initial_address,
    output reg w_reset,
    output reg weight_write_enable,
    output reg [dimdata_size-1:0] Weight_size,
    output reg [dimdata_size-1:0] number_filters,
    input w_done,
    
    //Bias adder signals
    output reg bias_reset,
    output reg [array_size-1:0] bias_enable,
    input [array_size-1:0] bias_done,
    
    //demux
    output reg [3:0] demux_sel,
    
    //relu array
    output reg [array_size-1:0] relu_enable,
    
    
    //buffer fill
    output reg [array_size-1:0] buffer_fill_enable,
    output reg [array_size-1:0] buffer_fill_reset,
    
    output reg [13:0] buffer_fill_initial_address,
    output reg [dimdata_size-1:0] output_featuremapsize,
    input [array_size-1:0] buffer_fill_done,
    
    //maxpoolfill
    output reg maxpool_fill_reset,
    output reg  maxpool_fill_enable,
    input  maxpool_done,
    output reg [13:0] maxpool_fill_initial_address,
    
    //maxpool array
    output reg maxpool_clear,
    output reg [array_size-1:0] maxpool_arr_r_en,
    output reg [array_size-1:0] maxpool_arr_enable,
    
    output reg done
    
    

    );
    
    reg [7:0] instruction_address;
    wire [63:0] instruction;
    wire [63:0] c_instruction;
    
    integer count;
    integer icount;
    integer pcount;
    
    reg [5:0] state;
    localparam instruction_read=6'b000000;
    localparam instruction_fetch=6'b100001;
    localparam weight_fill=6'b000001;
    localparam fifo_fill=6'b000010;
    localparam conv=6'b000011;
    localparam maxpool_fill=6'b000100;
    localparam maxpooling=6'b000101;
    localparam fifo_cl=6'b100000;
    localparam finish=6'b111111;
    
    
    integer s_offset;
    integer i;
    
    instructions_memory im (
      .a(instruction_address),     
      .spo(instruction)  
    );

    always@(posedge clk or negedge reset)begin
        if(~reset)begin
            instruction_address<=initial_instruction_address;
            icount<=0;
            state<=instruction_fetch;
            done<=0;
            s_reset<=0;
            w_reset<=0;
            bias_reset<=0;
            buffer_fill_reset<=0;
            maxpool_fill_reset<=0;
            maxpool_clear<=0;
        end
        else if(enable)begin
            
            case(state)
                instruction_fetch:begin
                    if(icount==number_instrs)begin
                        state<=finish;
                    end
                    instruction_address<=initial_instruction_address+icount;
                    state<=instruction_read;
                    icount<=icount+1;
                    //instruction<=c_instruction;
                end
                instruction_read:begin
                        
                    
                    if(instruction[4:0]==5'b00001)begin
                        state<=weight_fill;
                        w_reset<=0;
                    end
                    else if(instruction[4:0]==5'b00010)begin
                        fifo_fill_reset<=0;
                        state<=fifo_fill;
                    end
                    else if(instruction[4:0]==5'b10000)begin
                        fifo_clear<=0;
                       fifo_fill_enable<=1; 
                        state<=fifo_cl;
                    end
                    else if(instruction[4:0]==5'b00011)begin
                        s_reset<=0;
                        count<=0;
                       fifo_r_en<=0;
                       buffer_fill_reset<=0;
                       buffer_fill_enable<=0;
                        pcount<=0;
                        bias_reset<=0;
                        state<=conv;
                    end
                    else if(instruction[4:0]==5'b00100)begin
                        state<=maxpool_fill;
                        maxpool_arr_r_en<=0;
                        maxpool_arr_enable<=0;
                        maxpool_clear<=0;
                        maxpool_fill_reset<=0;
                    end
                end
                fifo_cl:begin
                    fifo_clear<=1;
                    state<=instruction_fetch;
                end
                weight_fill:begin
                    w_reset<=1;
                    
                    weight_initial_address<=instruction[19:5];
                    weight_write_enable<=1;
                    Weight_size<=instruction[35:20];
                    number_filters<=instruction[51:36];
                    
                    if(w_done)begin
                        state<=instruction_fetch;
                    end
                end
                fifo_fill:begin
                    fifo_fill_reset<=1;
                    fifo_clear<=1;
                    fifo_initial_address<=instruction[18:5];
                    image_height<=instruction[34:19];
                    image_width<=instruction[50:35];
                    fifo_offset<=instruction[57:51];
                    if(fifo_fill_done)begin
                        state<=instruction_fetch;
                    end
                end
                conv:begin
                    s_reset<=1;
                    bias_reset<=1;
                    demux_sel<=instruction[8:5];
                    buffer_fill_reset<=9'h1ff;
                    buffer_fill_initial_address<=0;
                    output_featuremapsize<=9;
                    if(count<Weight_size*Weight_size-fifo_offset)begin
                        fifo_r_en[count]=1;
                        count<=count+1;
                    end
                    else if(count==Weight_size*Weight_size)begin
                        bias_enable<=9'h1ff;
                        relu_enable<=9'h1ff;
                        count<=count+1;
                    end
                    else if(pcount<number_filters)begin
                        buffer_fill_enable[pcount]<=1;
                        
                        pcount<=pcount+1;
                    end
                    else if(buffer_fill_done==9'h1ff)begin
                        state<=instruction_fetch;
                    end
                end
                maxpool_fill:begin
                    maxpool_fill_initial_address<=instruction[18:5];
                    maxpool_clear<=1;
                    maxpool_fill_reset<=1;
                    
                    maxpool_fill_enable<=1;
                    
                    if(maxpool_done==1)begin
                        for(i=0;i<array_size;i=i+1)begin
                            if(i<number_filters)begin
                                maxpool_arr_r_en[i]<=1;
                                maxpool_arr_enable[i]<=1;
                            end
                        end
                    end
                end
                finish:begin
                    done<=1;
                end
            endcase
        end
    end
    
    
    
endmodule
