`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.12.2020 13:03:57
// Design Name: 
// Module Name: fifo_fill_control_2
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


module fifo_fill_control_2#(
    parameter data_size=8,
    parameter array_size=9,
    parameter dim_data_size=8
)(
    input clk,
    input [19:0] initial_address,
    input enable,
    input [array_size-1:0] write_enable_in,
    input reset,
    input [dim_data_size-1:0] weight_size,
    input [dim_data_size-1:0] image_height,
    input [dim_data_size-1:0] image_width,
    output [data_size-1:0] bus,
    output reg [array_size-1:0] write_enable_out,
    output reg completed,
    output reg [2:0] state
        );
    reg [array_size-1:0] done;
    reg [19:0] c_address;
    reg [19:0] t_address [array_size-1:0];
    wire [19:0] address;
    reg [array_size-1:0] write_enable;
    reg [array_size-1:0] data1_d1;
    
    
    assign address=c_address;
    
    integer row [array_size-1:0];
    integer iter [array_size-1:0];
    integer i,j;
    
    localparam init=3'b000;
    localparam row_iter=3'b001;
    localparam row_change=3'b010;
    localparam finish=3'b011;
    localparam stay=3'b100;    
    
    InputDataROM InputROM (
      .clka(clk),    // input wire clka
      .addra(c_address),  // input wire [19 : 0] addra
      .douta(bus)  // output wire [7 : 0] douta
    );
    
     always@(posedge clk)    
     begin
      data1_d1 <= write_enable;       
      write_enable_out <= data1_d1;    
     end

    always @(posedge clk or negedge reset) begin
        if(!reset)begin 
            state<=init;
            done<=0;
            for(i=0;i<array_size;i=i+1)begin
                if(i==0)begin
                    t_address[i] <= initial_address;
                end
                else if(i%weight_size==0)begin
                    t_address[i] <= t_address[i-weight_size] + image_width;  
                end
                else begin
                    t_address[i]<=t_address[i-1]+1;
                end
            end
        end
        else if(enable)begin
            case(state)
                
                init:begin
                    for(i=0;i<array_size;i=i+1)begin
                        row[i]<=0;
                        iter[i]<=0;
                    end
                    
                    write_enable<=9'b0_0000_0000;
                    state<=row_iter;
                    j<=0;
                end
                
                row_iter:begin
                    if(done[j])begin
                        write_enable<=9'b0_0000_0000;
                    end
                    if(write_enable_in[j]==0 && !done[j])begin
                        if(row[j]==image_width-weight_size)begin
                            c_address<=t_address[j]+row[j];
                            write_enable<=9'b0_0000_0001<<j;
                            row[j]<=0;
                            if(iter[j]==image_height-weight_size+1)begin
                                done[j]<=1;
                                
                            end
                            else begin
                                t_address[j]<=t_address[j]+image_width;
                                iter[j]<=iter[j]+1;
                            end
                        end
                        else begin
                            c_address<=t_address[j]+row[j];
                            write_enable<=9'b0_0000_0001<<j;
                            row[j]<=row[j]+1;
                        end
                    end
                    else begin
                        if(j==array_size-1)begin
                            if(done==9'b1_1111_1111)begin
                                state<=finish;
                            end 
                            else
                                j<=0;
                        end
                        else begin
                            j<=j+1;
                        end
                    end
                    
                end
                
                finish:begin
                    completed <=1;
                end
            endcase
        end
    end
endmodule
