module test;

 // Inputs
 reg clk;
 reg reset;


 reg [31:0] datain;
 reg [31:0] win;
 wire [63:0]  macouti;
 wire [63:0]  macoutj;


 // Instantiate the Unit Under Test (UUT)
systolic_array uut (
  .clk(clk), 
  .reset(reset), 
  .datain(datain),
  .weightin(win),
  .macouti(macouti),
  .macoutj(macoutj)
 );

 initial begin
  // Initialize Inputs
  clk = 0;



  // Wait 100 ns for global reset to finish
  #5 reset = 1;
  #5 reset = 0;

    clk = 1'b0;
        datain = 32'h0000_0000;
        win = 32'h0000_0000;


        #10;

        //win = 32'h0404_0404;
        win = 32'h0403_0201;
 

        #10;

        //win = 32'h0303_0303;
        win = 32'h0403_0201;

        #10;

        //win = 32'h0202_0202;
        win = 32'h0403_0201;

        #10;

        //win = 32'h0101_0101;
        win = 32'h0403_0201;


        #10

        datain = 32'h0000_0000;
        
        #10;

        datain = 32'h0000_0401;

        #10;

        datain = 32'h0008_0502;

        #10;

        datain = 32'h0C09_0603;

        #10;

        datain = 32'h0D0A_0700;

        #10;

        datain = 32'h0E0B_0000;

        #10;

        datain = 32'h0F00_0000;
        

        #10;

        datain = 32'h0000_0000;

        #30;

       win = 32'h0F0B_0703;

        #10;

        win = 32'h0E0A_0602;

        #10;

        win = 32'h0D09_0501;

        #10;

        win = 32'h0C08_0400;
      
        #10;

        datain = 32'h0000_0001;
       

        #10;

        datain = 32'h0000_0502;

        #10;

        datain = 32'h0009_0603;

        #10;

        datain = 32'h0D0A_0704;

        #10;

        datain = 32'h0E0B_0800;

        #10;

        datain = 32'h0F0C_0000;

        #10;

        datain = 32'h1000_0000;

        #10;

        datain = 32'h0000_0015;

        #10;

        datain = 32'h0000_1D00;

        #10;

        datain = 32'h0021_0000;

        #10;

        datain = 32'h0400_0000;

        #10;

        datain = 32'h0000_0000;
       

        #30;

    
        win = 32'h000C_030A;

        #10;

        win = 32'h00AA_0B02;

        #10;

        win = 32'h000C_010A;

        #10;

        win = 32'h0000_0000;
    

        #10;

        datain = 32'h0000_0000;
    

        #10;

        datain = 32'h0000_AA00;

        #10;

        datain = 32'h00DD_BB00;

        #10;

        datain = 32'h01EE_CC00;

        #10;

        datain = 32'h01FF_0000;

        #10;

        datain = 32'h0900_0000;
    

        #10;

        datain = 32'h0000_0000;

        #30;
 end
 
 initial begin
  forever #5 clk = ~clk;
 end
      
endmodule