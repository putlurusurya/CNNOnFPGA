`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.02.2021 14:46:53
// Design Name: 
// Module Name: BufferRamArray
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


module BufferRamArray#(
        parameter array_size = 9,
        parameter data_size =16    
    )(
        input w_clk,
        input r_clk,
        input [array_size-1:0] ena,
        input [array_size-1:0] enb,
        input [array_size-1:0] wea,
        input [14*array_size-1:0] addra,
        input [13:0] addrb,
        input [data_size*array_size-1:0] dina,
        output reg [data_size-1:0] bus1,
        output reg [array_size*data_size-1:0] bus2,
        input output_sel
    );
    reg [data_size*array_size-1:0] doutb;
    genvar i;
    generate
        for(i=0;i<array_size;i=i+1)begin
            buffer_memory_blocks buffer (
              .clka(w_clk),    
              .ena(ena[i]),      
              .wea(wea[i]),      
              .addra(addra[(i+1)*14-1:i*14]),  
              .dina(dina),   
              .clkb(r_clk),    
              .enb(enb[i]),      
              .addrb(addrb),  
              .doutb(doutb[(i+1)*data_size-1:i*data_size])  
            );
        end
    endgenerate
    
    reg [data_size*array_size-1:0] temp;
    integer j=0;

    always@(posedge r_clk)begin
        if(output_sel==0)begin
            for(j=0;j<array_size;j=j+1)begin
                temp<=doutb>>j*data_size;
                if(enb[j]==1)begin
                    bus1<=temp[data_size-1:0];
                end
            end
        end
        else begin
            bus2<=doutb;
        end
    end
    
endmodule
