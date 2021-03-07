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
        input [array_size-1:0] wea,
        input [14*array_size-1:0] addra,
        input [13:0] addrb,
        input [data_size*array_size-1:0] dina,
        output  [array_size*data_size-1:0] bus2
    );

    genvar i;
    generate
        for(i=0;i<array_size;i=i+1)begin
            buffer_memory_blocks buffer (
              .clka(w_clk),          
              .wea(wea[i]),      
              .addra(addra[(i+1)*14-1:i*14]),  
              .dina(dina[(i+1)*data_size-1:i*data_size]),   
              .clkb(r_clk),          
              .addrb(addrb),  
              .doutb(bus2[(i+1)*data_size-1:i*data_size])  
            );
        end
    endgenerate
    
   
    
endmodule
