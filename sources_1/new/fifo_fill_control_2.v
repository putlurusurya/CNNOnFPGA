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
    parameter data_size=16,
    parameter array_size=9,
    parameter dim_data_size=16
)(
    input clk,
    input [13:0] initial_address,
    input enable,
    input [array_size-1:0] write_enable_in,
    input reset,
    input [dim_data_size-1:0] weight_size,
    input [dim_data_size-1:0] image_height,
    input [dim_data_size-1:0] image_width,
    input [7:0] offset,
    output reg [13:0] c_address,
    output reg [array_size-1:0] write_enable_out,
    output reg completed
        );
    reg [2:0] state;
    reg [array_size-1:0] done;
    reg [13:0] t_address [array_size-1:0];
    wire [13:0] address;
    reg [array_size-1:0] write_enable;
    reg [array_size-1:0] data1_d1;
    reg [array_size-1:0] one;
    reg [array_size-1:0] offset_ref;
    

    
    
    assign address=c_address;
    
    integer row [array_size-1:0];
    integer iter [array_size-1:0];
  
    integer i,j;
    
    localparam init=3'b000;
    localparam row_iter=3'b001;
    localparam row_change=3'b010;
    localparam finish=3'b011;
    localparam stay=3'b100;    
    
   
    
     always@(posedge clk)    
     begin
      data1_d1 <= write_enable;       
      write_enable_out <= data1_d1;    
     end
    integer r;
    always @(posedge clk or negedge reset) begin
        if(!reset)begin 
            state<=init;
            done<=0;
            write_enable_out<=0;
            c_address<=0;
            completed<=0;
            one<=1;
            offset_ref<=0;
            

        end
        else if(enable)begin
            case(state)
                
                init:begin
                    for(i=0;i<array_size;i=i+1)begin
                        if(i>=offset)begin
                            if(i<=offset+weight_size*weight_size-1)begin
                                offset_ref[i]<=1;
                            end
                            r=(i-offset)%weight_size;
                            if(i==offset)begin
                                t_address[i] <= initial_address;
                            end
                            else if(r==0)begin
                                t_address[i] <= initial_address + ((i-offset)/weight_size)*image_width ;  
                            end
                            else begin
                                t_address[i] <= initial_address + (((i-offset)-r)/weight_size)*image_width + (r);
                            end
                        end
                    end
                    write_enable<=0;
                    state<=row_iter;
                    j<=offset;
                    for(i=0;i<array_size;i=i+1)begin
                        row[i]<=0;
                        iter[i]<=0;
                    end
                end
                
                row_iter:begin
                    if(done[j])begin
                        write_enable<=0;
                    end
                    if(write_enable_in[j]==0 && !done[j])begin
                        if(row[j]==image_width-weight_size)begin
                            c_address<=t_address[j]+row[j];
                            write_enable<=one<<j;
                            row[j]<=0;
                            if(iter[j]==image_height-weight_size)begin
                                done[j]<=1;
                                
                            end
                            else begin
                                t_address[j]<=t_address[j]+image_width;
                                iter[j]<=iter[j]+1;
                            end
                        end
                        else begin
                            c_address<=t_address[j]+row[j];
                            write_enable<=one<<j;
                            row[j]<=row[j]+1;
                        end
                    end
                    else begin
                        if(j==offset+weight_size*weight_size-1)begin
                            if(done==offset_ref)begin
                                write_enable<=0;
                                state<=finish;
                            end 
                            else
                                write_enable<=0;
                                j<=offset;
                        end
                        else begin
                            write_enable<=0;
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