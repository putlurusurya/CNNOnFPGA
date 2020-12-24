module systolic_tb;

 // Inputs
 reg clk;
 reg reset;


 reg [15:0] datain;
 reg [31:0] win;
 wire [15:0]  macout;



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
        reset = 0;
        clk = 1'b0;
        
        #20;
         reset = 1;

        
        win=32'h01020304;
        

        

        datain = 16'h0004;

        #10;

        datain = 16'h0302;
        
        #10;
        
        datain = 16'h0600;
        
        #10;
     
        datain=0;

        #30;
 end
 
 initial begin
  forever #5 clk = ~clk;
 end
      
endmodule