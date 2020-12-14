`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.12.2020 12:12:39
// Design Name: 
// Module Name: SinglePortRam
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
//Single port Ram with async read and async write
module SinglePortRam #(
    parameter DATA_WIDTH = 8 ,
    parameter ADDR_WIDTH = 8 ,
    parameter FIFO_DEPTH = 16
)(
    input clk         , // Clock Input
    input [ADDR_WIDTH-1:0] address     , // Address Input
    inout [DATA_WIDTH-1:0] data        , // Data bi-directional
    input cs          , // Chip Select
    input we          , // Write Enable/Read Enable
    input oe            // Output Enable
); 

reg [DATA_WIDTH-1:0]   data_out ;
reg [DATA_WIDTH-1:0] mem [0:FIFO_DEPTH-1];

// output : When we = 0, oe = 1, cs = 1
assign data = (cs && oe && !we) ? data_out : 8'bz; 

// Write : When we = 1, cs = 1
always @ (address or data or cs or we)
begin : MEM_WRITE
   if ( cs && we ) begin
       mem[address] = data;
   end
end

// Read : When we = 0, oe = 1, cs = 1
always @ (address or cs or we or oe)
begin : MEM_READ
    if (cs && !we && oe)  begin
         data_out = mem[address];
    end
end

endmodule 
