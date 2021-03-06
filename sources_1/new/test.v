
module test#(
	parameter fifo_depth = 256,
	parameter data_size = 8,
	parameter log_depth = 8        // log2 of fifo_depth for tracking position of wptr and rptr
)(
	input r_clk,
	input w_clk,
	input r_en,
	input w_en,
	input clear,
	input [data_size-1:0] dataIn,
	output reg [data_size-1:0] dataOut,
	output empty,
	output full
);
	reg [log_depth-1:0] rptr,wptr;
	reg [data_size-1:0] dataWr [fifo_depth-1:0];
	wire [data_size-1:0] dataRd [fifo_depth-1:0];
	integer j;
	genvar i;
	generate 
		for(i=0; i<fifo_depth; i=i+1) begin
			dff node(.clk(w_clk),.reset(clear),.en(w_en),.d(dataWr[i]),.q(dataRd[i]));
		end
	endgenerate
	
	assign full = ( (wptr == 3'b111) & (rptr == 3'b000) ? 1 : 0 );
	assign empty = ((wptr == rptr) ? 1 : 0);

	always@(posedge clear)
	begin
		rptr <= 0; wptr <= 0; dataOut <= 0;
	end

	always@(posedge w_clk)
	begin
		if(w_en & ~full & ~clear) begin
			dataWr[wptr] <= dataIn;
			wptr <= wptr + 1;
		end
	end	

	always@(posedge r_clk)
	begin
		if(r_en & ~empty & ~clear) begin
			dataOut <= dataRd[rptr];
			rptr <= rptr + 1;
		end
	end
endmodule

module dff#(
	parameter data_size = 8
)(
    input clk,
    input reset,
    input en,
    input [data_size-1:0] d,
    output reg [data_size-1:0] q
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 0;
        end
        else if (en) begin
            q <= d;
        end  
        else begin  
            q <= q;
        end  
    end
endmodule

