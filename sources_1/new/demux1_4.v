// Code your design here
module demux1_4#(parameter size=8)(
  input [1:0] sel,
    input [7:0]d_in,
    output [size-1:0] d_out[3:0]);
  reg [size-1:0] d_out[3:0];
  always @(d_in or sel)
    begin
      case(sel)
        2'b00:
          begin
          d_out[0]=d_in;
          d_out[3:1]=0;
          end
        
        2'b01:
          begin
            d_out[0]=0;
            d_out[1]=d_in;
            d_out[3:2]=0;
          end
        
        2'b10:
          begin
            d_out[1:0]=0;
            d_out[2]=d_in;
            d_out[3]=0;
          end
        
        2'b11:
          begin
            d_out[2:0]=0;
            d_out[3]=d_in;
          end
          
      endcase
          
    end
endmodule