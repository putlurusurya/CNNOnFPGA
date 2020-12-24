module new_fifo_tb();
	reg clk;
	reg reset;
	reg rd;
	reg wr;
	reg en;
	reg [7:0] inp;
	wire [7:0] out;
	wire empty;
	wire full;

	fifo dut(
		.clk(clk),
		.en(en),
		.rd(rd),
		.wr(wr),
		.reset(reset),
		.dataIn(inp),
		.dataOut(out),
		.empty(empty),
		.full(full)
	);

	initial begin
		clk = 0;
		en = 1; inp = 0; wr = 0; rd = 0;
		reset = 1;#20 reset = 0;
		wr = 1; 
		#30 inp = 4'b0011; #10 inp = 4'b0101;
		#10 inp = 4'b1011; #10 inp = 4'b0010;
		rd = 1;
		#10 inp = 4'b0000; #10 inp = 4'b0111;
		#10 inp = 4'b0101; #10 inp = 4'b1111;
		wr = 0;
		#10 inp = 4'b0110; #10 inp = 4'b0011;
		#5 reset = 1;
		#10 inp = 4'b0000; #10 inp = 4'b0111;
		#20 reset = 0; rd = 0; wr = 1;
		#10 inp = 4'b0101; #10 inp = 4'b1011;
		#10 inp = 4'b0010; #10 inp = 4'b0000;
		rd = 1; wr = 0;
		#10 inp = 4'b0111; #10 inp = 4'b0101;
		#10 inp = 4'b1111; #10 inp = 4'b0110;
	end
	
	initial begin
		forever #5 clk = ~clk;
	end

	initial
	$monitor("Clock : %b, input : %b, Output : %b",
			clk,inp,out);  // monitor output
	
endmodule	