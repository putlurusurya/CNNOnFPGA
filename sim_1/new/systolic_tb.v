module systolic_tb;

 // Inputs
 reg clk;
 reg reset;
parameter array_size = 4 ;
localparam data_size=8;
localparam weight_size=8*array_size*array_size;
localparam mac_size=8*array_size;

 reg [data_size*array_size-1:0] datain;
 reg [weight_size-1:0] win;
 wire [mac_size-1:0]  macout;



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

        
        win=128'h100f_0e0d_0c0b_0a09_0807_0605_0403_0201;

        

        datain = 32'h0000_0001;

        #10;

        datain = 32'h0000_0200;
        
        #10;

        datain = 32'h0003_0000;
        
        #10;

        datain = 32'h0400_0000;
        
       
        
        #30;
        $finish;
 end
 
 initial begin
  forever #5 clk = ~clk;
 end
      
endmodule