-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
-- Date        : Fri Dec 25 18:41:02 2020
-- Host        : LAPTOP-R5TEM1UP running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub -rename_top WeightDataROM -prefix
--               WeightDataROM_ InputDataROM_stub.vhdl
-- Design      : InputDataROM
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a200tfbg676-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity WeightDataROM is
  Port ( 
    clka : in STD_LOGIC;
    addra : in STD_LOGIC_VECTOR ( 19 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );

end WeightDataROM;

architecture stub of WeightDataROM is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clka,addra[19:0],douta[7:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "blk_mem_gen_v8_4_4,Vivado 2020.1";
begin
end;
