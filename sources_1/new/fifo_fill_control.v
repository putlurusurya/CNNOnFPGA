`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.12.2020 17:20:58
// Design Name: 
// Module Name: fifo_fill_control  
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


module fifo_fill_control#(
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
    output reg done,
    output reg [2:0] state
        );
    
    reg [19:0] c_address;
    reg [19:0] t_address;
    wire [19:0] address;
    reg [array_size-1:0] write_enable;
    reg [array_size-1:0] data1_d1;
    
    
    assign address=c_address;
    
    integer row;
    integer column;
    integer iter;
    integer delay;

    localparam row_iter=3'b010;
    localparam row_change=3'b001;
    localparam column_change=3'b011;
    localparam init=3'b000;
    localparam finish=3'b100;
    localparam stay=3'b101;
    
    
    
    
    InputDataROM InputROM (
      .clka(clk),    // input wire clka
      .addra(address),  // input wire [19 : 0] addra
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
            t_address<=initial_address;
            done<=0;
            delay<=0;
        end
        else if(enable) begin
        case (state)
                init:begin
                    row<=0;
                    column<=0;
                    iter<=0;
                    write_enable<=9'b0_0000_0000;
                    state<=row_iter;
                    
                end
                row_iter:begin
                    
                    if(row==0)begin
                        c_address<=t_address;  
                        write_enable<=9'b0_0000_0001;
                        row<=row+1;
                        state<=row_iter;
                    end
                    else if((row)%weight_size==0)begin
                        c_address<=t_address+(row/weight_size)*image_width;
                        write_enable<=9'b0_0000_0001<<(row);
                        if(row==(weight_size*weight_size))begin
                            if(column==image_width-weight_size)begin
                                if(iter==image_height-weight_size)begin
                                    
                                    state<=finish;
                                end
                                else 
                                    state<=row_change;
                            end
                            else begin
                                t_address<=t_address+1;
                                column<=column+1;
                                row<=0;
                                state=row_iter;
                            end
                        end
                        else begin
                            row<=row+1;
                            state<=row_iter;
                        end
                    end
                    else begin
                        c_address<=c_address+1;
                        write_enable<=9'b0_0000_0001<<(row);
                        row<=row+1;
                        state<=row_iter;
                    end
                end
                row_change:begin
                    t_address<=t_address+weight_size;
                    column<=0;
                    row<=0;
                    state<=row_iter;
                    iter<=iter+1;
                end
                stay:begin
                    
                end
                finish:begin
                    done<=1;
                end
            endcase
            end
   
    
    end
   
    
endmodule


