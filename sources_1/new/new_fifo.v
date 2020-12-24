
module fifo(
	input clk,
	input en,
	input rd,
	input wr,
	input reset,
	input [7:0] dataIn,
	output reg [7:0] dataOut,
	output empty,
	output full
);
	reg [2:0] rptr,wptr;
	reg [7:0] dataWr [7:0];
	wire [7:0] dataRd [7:0];

	genvar i;
	generate 
		for(i=0; i<8; i=i+1) begin
			dff_ node(.clk(clk),.reset(reset),.en(en),.d(dataWr[i]),.q(dataRd[i]));
		end
	endgenerate
	
	assign full = ( (wptr == 3'b111) & (rptr == 3'b000) ? 1 : 0 );
	assign empty = (wptr == rptr) ? 1 : 0;

	always@(posedge clk or posedge reset)
	begin
		if(reset & en) begin
			rptr = 0; wptr = 0; dataOut = 0;
			dataWr[0] = 0; dataWr[1] = 0;
			dataWr[2] = 0; dataWr[3] = 0;	
			dataWr[4] = 0; dataWr[5] = 0;
			dataWr[6] = 0; dataWr[7] = 0;
		end
		if(wr & en & ~full & ~reset) begin
			dataWr[wptr] = dataIn;
			wptr = wptr + 1;
		end
		if(rd & en & ~empty & ~reset) begin
			dataOut = dataRd[rptr];
			rptr = rptr + 1;
		end
	end
endmodule

module dff_(
    input clk,
    input reset,
    input en,
    input [7:0] d,
    output reg [7:0] q
);

    always @(posedge clk) begin
        if (reset) begin
            q = 0;
        end
        else if (en) begin
            q = d;
        end  
        else begin  
            q = q;
        end  
    end
endmodule

