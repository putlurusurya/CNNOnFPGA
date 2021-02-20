`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.02.2021 14:48:00
// Design Name: 
// Module Name: Block_Ram_Test_tb
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


module Block_Ram_Test_tb(

    );
    reg clka;
    reg clkb;
    reg ena;
    reg enb;
    reg enb1;
    reg [15:0] addra;
    reg [15:0] addrb;
    reg [7:0] dina;
    reg [7:0] dina1;
    reg wea;
    wire [7:0] doutb;
   BlockRamTest your_instance_name (
  .clka(clka),    // input wire clka
  .ena(ena),      // input wire ena
  .wea(wea),      // input wire [0 : 0] wea
  .addra(addra),  // input wire [15 : 0] addra
  .dina(dina),    // input wire [7 : 0] dina
  .dina1(dina1),    // input wire [7 : 0] dina
  .clkb(clkb),    // input wire clkb
  .enb(enb),      // input wire enb
  .enb1(enb1),      // input wire enb
  .addrb(addrb),  // input wire [15 : 0] addrb
  // input wire [15 : 0] addrb
  .doutb(doutb)  // output wire [7 : 0] doutb
);
initial begin
    clka<=0;
    clkb<=0;
    ena<=1;
    wea<=1;
    dina<=1;
    dina1<=2;
    enb<=0;
    enb1<=0;
    addra<=0;
    addrb<=0;
    #10
    dina<=2;
    dina1<=3;
    addra<=1;
    #10
    dina<=3;
    dina1<=4;
    addra<=2;
    #10
    dina<=4;
    dina1<=5;
    addra<=3;
    #10
    dina<=5;
    dina1<=6;
    addra<=4;
    #10
    enb<=1;
    enb1<=0;
    #10
    addrb<=1;
    #10
    addrb<=2;
    #10
    addrb<=3;
    #10
    addrb<=4;
    #10
    enb<=0;
    enb1<=1;
    #10
    addrb<=1;
    #10
    addrb<=2;
    #10
    addrb<=3;
    #10
    addrb<=4;
    #10
    enb<=1;
    enb1<=1;
    #10
    addrb<=1;
    #10
    addrb<=2;
    #10
    addrb<=3;
    #10
    addrb<=4;
    
end
initial begin
  forever #5 clka <= ~clka;
 end
 initial begin
  forever #5 clkb <= ~clkb;
 end
    
endmodule
