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

module demux1_4#(parameter size=8)(
    input [1:0] sel,
    input [size-1:0]d_in,
    output reg [size-1:0] d_out1,
    output reg [size-1:0] d_out2,
    output reg [size-1:0] d_out3,
    output reg [size-1:0] d_out4
    );

      always @(d_in or sel)
        begin
          case(sel)
            2'b00:
              begin
              d_out1=d_in;
              d_out2=0;
              d_out3=0;
              d_out4=0;
              end
            
            2'b01:
              begin
                d_out1=0;
                d_out2=d_in;
                d_out3=0;
                d_out4=0;
              end
            
            2'b10:
              begin
                d_out1=0;
                d_out2=0;
                d_out3=d_in;
                d_out4=0;
              end
            
            2'b11:
              begin
                d_out1=0;
                d_out2=0;
                d_out3=0;
                d_out4=d_in;
              end
          endcase   
    end
endmodule
