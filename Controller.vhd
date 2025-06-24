----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.06.2025 00:00:57
-- Design Name: 
-- Module Name: Controller - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Controller is
    Port ( i_instruction : in STD_LOGIC_VECTOR (31 downto 0);
           i_clk : in STD_LOGIC;
           --Viewport
           o_ch_setoffset : out STD_LOGIC;
           o_ch_moveoffset : out STD_LOGIC;
           o_x_newoffset : out STD_LOGIC_VECTOR (9 downto 0);
           o_y_newoffset : out STD_LOGIC_VECTOR (9 downto 0);
           --BackMgmt
           o_BM_col : out STD_LOGIC_VECTOR (6 downto 0);
           o_BM_row : out STD_LOGIC_VECTOR (6 downto 0);
           o_BM_tile_id : out STD_LOGIC_VECTOR (4 downto 0);
           o_BM_flip_y : out STD_LOGIC;
           o_BM_ch_tile_id : out STD_LOGIC;
           o_BM_ch_flip : out STD_LOGIC;
           --ActorMgmt
           o_AM_act_id : out STD_LOGIC_VECTOR (2 downto 0);
           o_AM_newpos_x : out STD_LOGIC_VECTOR (9 downto 0);
           o_AM_newpos_y : out STD_LOGIC_VECTOR (9 downto 0);
           o_AM_tile_id : out STD_LOGIC_VECTOR (3 downto 0);
           o_AM_flip_x : out STD_LOGIC;
           o_AM_flip_y : out STD_LOGIC;
           o_AM_ch_setpos : out STD_LOGIC;
           o_AM_ch_movepos : out STD_LOGIC;
           o_AM_ch_tile_id : out STD_LOGIC;
           o_AM_ch_flip : out STD_LOGIC;
           --MuxBackActor
           o_MBA_act_en : out STD_LOGIC;
           --ColorConvertor
           o_CC_color_id : out STD_LOGIC_VECTOR (3 downto 0); --Peut-être mettre un vrai système de palette
           o_CC_new_RBG : out STD_LOGIC_VECTOR (23 downto 0);
           o_CC_ch_color : out STD_LOGIC
           );
           
           
end Controller;

architecture Behavioral of Controller is

begin


end Behavioral;
