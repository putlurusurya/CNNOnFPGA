`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.03.2021 11:44:20
// Design Name: 
// Module Name: Add_excess
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


module Add_excess#(
    parameter data_size=16,
    parameter dimdata_size=16
)(
    input clk,
    input enable,
    input reset,
    input [13:0] add_initial_address1,
    input [13:0] add_initial_address2,
    output reg [13:0] add_address,
    input [dimdata_size-1:0] size,
    input [13:0] store_initial_address,
    output reg [13:0] store_address,
    output reg write_enable,
    input [data_size-1:0] datain,
    output reg [data_size-1:0] dataout,
    output reg done
    );
    reg [2:0] state;
    localparam init=3'b000;
    localparam addrcalc=3'b001;
    localparam delay1=3'b010;
    localparam delay2=3'b011;
    localparam delay3=3'b100;
    localparam delay4=3'b101;
    localparam add=3'b110;
    localparam finish=3'b111;
    integer count;
    reg [data_size-1:0] op1;
    reg [data_size-1:0] op2;
    always@(posedge clk or negedge reset)begin
        if(~reset)begin
            state<=init;
            dataout<=0;
            write_enable<=0;
            store_address<=store_initial_address;
            add_address<=add_initial_address1;
            count<=0;
            op1<=0;
            op2<=0;
        end
        else if(enable)begin
            case(state)
                init: begin
                    state<=addrcalc;
                    write_enable<=0;
                    count<=0;
                end
                addrcalc:begin
                    add_address<=add_initial_address1+count;
                    state<=delay1;
                end
                delay1:begin
                    state<=delay2;
                end
                delay2:begin
                    op1<=datain;
                    add_address<=add_initial_address2+count;
                    state<=delay3;
                end
                delay3:begin
                    state<=delay4;
                end
                delay4:begin
                    op2<=datain;
                    store_address<=store_initial_address+count;
                    state<=add;
                end
                add:begin
                    dataout<=op1+op2;
                    write_enable<=1;
                    if(count==size-1)begin
                        state<=finish;
                    end
                    else begin
                        count<=count+1;
                        state<=addrcalc;
                    end
                end
                finish:begin
                    done<=1;
                end
                
            endcase
        end
    end
endmodule
