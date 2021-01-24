// Code your design here
module demux_array#(
  parameter array_size = 9,
  parameter data_size = 8
)(input [data_size*array_size:0]d_in,
  output [data_size*array_size:0]d_out_1,
  output [data_size*array_size:0]d_out_2,
  output [data_size*array_size:0]d_out_3,
  output [data_size*array_size:0]d_out_4);
  
  
  genvar i;
  generate
    for(i=0;i<array_size;i++)
      begin
      demux1_4 uut(d_in[(i+1)*datasize-1:0],
                   sel[1:0],
                   d_out_1[(i+1)*datasize-1:0],
                   d_out_2[(i+1)*datasize-1:0],
                   d_out_3[(i+1)*datasize-1:0],
                   d_out_4[(i+1)*datasize-1:0]);
      end
  endgenerate
  endmodule
  