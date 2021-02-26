`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.02.2021 10:44:32
// Design Name: 
// Module Name: Buffer_fill_control
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

module output_fill #(
    parameter dimdata_size=16
)(
	input w_clk,
	input enable,
	input reset,
	input initial_address,
	input [dimdata_size-1:0] output_featuremapsize,
	input is_empty,
	output reg [13:0] c_address,
	output reg write_enable,
	output reg done
	);

    reg [1:0]state;
	localparam init=2'b00;
	localparam calc=2'b01;
	localparam finish=2'b10;

			
        always @(posedge w_clk or negedge reset)begin
                if(~reset)
                    begin
                        write_enable <=0;
                        c_address<=initial_address;
                        state<=init;
                        done<=0;
                    end
                else if(enable && (~is_empty)) begin
                    case (state) 
                        init:begin
                            c_address<=initial_address;
                            write_enable<=1;
                            state<=calc;
                            done<=0;
                        end
                        calc:begin
                            c_address<=c_address+1;
                            write_enable<=1;
                            if(c_address-initial_address==output_featuremapsize)begin
                                state<=finish;
                            end
                        end
                        finish:begin
                            write_enable<=0;
                            done=1;
                        end
                    endcase
                end
                    
        end
        
endmodule