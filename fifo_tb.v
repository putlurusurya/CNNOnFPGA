module fifo_tb;

reg [7:0] data;
reg d,clk,rst,stall;
wire out;
integer i;

fifo_reg dut(.data(d),.clk(clk),.rst(rst),.stall(stall),.out(out));

initial begin
  clk=0;
     forever #1 clk = ~clk;  
end 

initial begin
data <= 8'b01101110;
rst <= 1;
#20;
rst <= 0;
for (i=0;i<8;i=i+1)
begin
	d <= data[i];
	#2;
end
end
endmodule

