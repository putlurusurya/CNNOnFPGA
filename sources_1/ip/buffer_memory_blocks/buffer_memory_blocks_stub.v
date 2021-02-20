// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
// Date        : Fri Feb 19 21:20:44 2021
// Host        : LAPTOP-R5TEM1UP running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               g:/CNNSONFPGA/Project/Project.srcs/sources_1/ip/buffer_memory_blocks/buffer_memory_blocks_stub.v
// Design      : buffer_memory_blocks
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a200tfbg676-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_4,Vivado 2020.1" *)
module buffer_memory_blocks(clka, ena, wea, addra, dina, clkb, enb, addrb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,wea[0:0],addra[13:0],dina[15:0],clkb,enb,addrb[13:0],doutb[15:0]" */;
  input clka;
  input ena;
  input [0:0]wea;
  input [13:0]addra;
  input [15:0]dina;
  input clkb;
  input enb;
  input [13:0]addrb;
  output [15:0]doutb;
endmodule
