`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.12.2020 12:16:26
// Design Name: 
// Module Name: FIFO
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

//Synchronous FIFO

module FIFObuffer( 
    input Clk, // Clock Input
    input   [31:0] dataIn, // Data in
    input RD, // Read enable
    input WR, // Write enable
    input EN, // FIFO enable
    output reg [31:0] dataOut,//Data out 
    input Rst,// Reset
    output EMPTY, // Fifo empty indicator
    output FULL // Fifo full indicator
); 

reg [2:0]  Count = 0; 
reg [31:0] FIFO [0:7]; 
reg [2:0]  readCounter = 0;
reg [2:0]  writeCounter = 0; 

assign EMPTY = (Count==0)? 1'b1:1'b0; 
assign FULL = (Count==8)? 1'b1:1'b0; 

always @ (posedge Clk) 
begin 
     if (EN==0); 
     else begin 
      if (Rst) begin 
       readCounter = 0; 
       writeCounter = 0; 
      end 
      else if (RD ==1'b1 && Count!=0) begin 
       dataOut  = FIFO[readCounter]; 
       readCounter = readCounter+1; 
      end 
      else if (WR==1'b1 && Count<8) begin
       FIFO[writeCounter]  = dataIn; 
       writeCounter  = writeCounter+1; 
      end 
      else; 
     end 
     if (writeCounter==8) 
      writeCounter=0; 
     else if (readCounter==8) 
      readCounter=0; 
     else;
     if (readCounter > writeCounter) begin 
      Count=readCounter-writeCounter;
     end 
     else if (writeCounter > readCounter) 
      Count=writeCounter-readCounter;
     else;

end 

endmodule
