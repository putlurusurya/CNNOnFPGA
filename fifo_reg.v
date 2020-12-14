module fifo_reg(data,clk,rst,stall,out);

input data;
input clk,rst,stall;
output out;
wire Q1,QB1,Q2,QB2,Q3,QB3,QB4;
d_ff D1(.D(data),.clk(clk),.rst(rst),.q(Q1),.qb(QB1));
d_ff D2(.D(Q1),.clk(clk),.rst(rst),.q(Q2),.qb(QB2));
d_ff D3(.D(Q2),.clk(clk),.rst(rst),.q(Q3),.qb(QB3));
d_ff D4(.D(Q3),.clk(clk),.rst(rst),.q(out),.qb(QB4));

endmodule

module d_ff(D,clk,rst,q,qb);

input D,clk,rst;
output reg q,qb;

always @(posedge clk)
begin
	if(rst==1'b1)
	begin
		q <= 1'b0;
		qb <= ~q;
	end
	else
	begin
		q = D;
		qb = ~q;
	end
end

endmodule
