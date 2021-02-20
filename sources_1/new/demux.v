`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.02.2021 08:13:16
// Design Name: 
// Module Name: demux
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

module demux1_4#(parameter size=16)(
    input [3:0] sel,
    input [size-1:0]d_in,
    output reg [size-1:0] d_out1,
    output reg [size-1:0] d_out2,
    output reg [size-1:0] d_out3,
    output reg [size-1:0] d_out4
    );

      always @(d_in or sel)
        begin
          case(sel)
            4'b0001:
              begin
              d_out1=d_in;
              d_out2=0;
              d_out3=0;
              d_out4=0;
              end
            
            4'b0010:
              begin
                d_out1=0;
                d_out2=d_in;
                d_out3=0;
                d_out4=0;
              end
            
            4'b0100:
              begin
                d_out1=0;
                d_out2=0;
                d_out3=d_in;
                d_out4=0;
              end
            
            4'b1000:
              begin
                d_out1=0;
                d_out2=0;
                d_out3=0;
                d_out4=d_in;
              end
            default:begin
                d_out1=0;
                d_out2=0;
                d_out3=0;
                d_out4=0;
                end
          endcase   
    end
endmodule
