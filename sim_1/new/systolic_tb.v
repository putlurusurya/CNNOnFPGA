module test;

 // Inputs
 reg clk;
 reg reset;
 reg [7:0] a1;
 reg [7:0] a2;
 reg [7:0] a3;
 reg [7:0] b1;
 reg [7:0] b2;
 reg [7:0] b3;


 wire [23:0] datain;
 wire [23:0] weightin;
 wire [47:0]  macouti;
 wire [47:0]  macoutj;
 assign datain={a1,a2,a3};
 assign weightin={b1,b2,b3};

 // Instantiate the Unit Under Test (UUT)
systolic_array uut (
  .clk(clk), 
  .reset(reset), 
  .datain(datain),
  .weightin(weightin),
  .macouti(macouti),
  .macoutj(macoutj)
 );

 initial begin
  // Initialize Inputs
  clk = 0;
  reset = 0;
  a1 = 0;
  a2 = 0;
  a3 = 0;
  b1 = 0;
  b2 = 0;
  b3 = 0;

  // Wait 100 ns for global reset to finish
  #5 reset = 1;
  #5 reset = 0;
  #5;  a1 = 1; a2 = 0; a3 = 0; b1 = 2; b2 = 0; b3 = 0;
  #10; a1 = 2; a2 = 4; a3 = 0; b1 = 4; b2 = 1; b3 = 0;
  #10; a1 = 3; a2 = 5; a3 = 7; b1 = 6; b2 = 5; b3 = 3;
  #10; a1 = 0; a2 = 6; a3 = 8; b1 = 0; b2 = 9; b3 = 7;
  #10; a1 = 0; a2 = 0; a3 = 9; b1 = 0; b2 = 0; b3 = 8;
  #10; a1 = 0; a2 = 0; a3 = 0; b1 = 0; b2 = 0; b3 = 0;
  #100;
  $stop;

 end
 
 initial begin
  forever #5 clk = ~clk;
 end
      
endmodule