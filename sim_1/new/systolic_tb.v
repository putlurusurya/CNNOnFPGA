module systolic_tb;

 // Inputs
 reg clk;
 reg reset;


 reg [31:0] datain;
 reg [31:0] win;
 wire [127:0]  macout;



 // Instantiate the Unit Under Test (UUT)
systolic_array uut (
  .clk(clk), 
  .reset(reset), 
  .datain(datain),
  .weightin(win),
  .macout(macout)
 );

initial
begin
  // Initialize Inputs
  clk = 0;



  // Wait 100 ns for global reset to finish
   reset = 1;
  #20 reset = 0;

    clk = 1'b0;
        datain = 32'h0000_0000;
        win = 32'h0000_0000;


        #10;

        win = 32'h0403_0201;
        datain = 32'h0100_0000;
 

        #10;

        win = 32'h0506_0708;
        datain = 32'h0203_0000;
        
        #10;
        
        win = 32'h090A_0B0C;
        datain = 32'h0405_0600;
        
        #10;
        
        datain = 32'h0708_090A;
        
        #10;
        
        datain = 32'h0B0C_0D00;
        
        #10;
        
        datain = 32'h0E0F_0000;
        
        #10;
        
        datain = 32'h1000_0000;


        #30;
 end
 
 initial begin
  forever #5 clk = ~clk;
 end
      
endmodule