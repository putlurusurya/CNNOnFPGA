// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
// Date        : Mon Mar  8 14:32:42 2021
// Host        : LAPTOP-R5TEM1UP running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               g:/CNNSONFPGA/Project/Project.srcs/sources_1/ip/instructions_memory/instructions_memory_stub.v
// Design      : instructions_memory
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a200tfbg676-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "dist_mem_gen_v8_0_13,Vivado 2020.1" *)
module instructions_memory(a, spo)
/* synthesis syn_black_box black_box_pad_pin="a[7:0],spo[63:0]" */;
  input [7:0]a;
  output [63:0]spo;
endmodule
