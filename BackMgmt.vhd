----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.06.2025 00:00:57
-- Design Name: 
-- Module Name: BackMgmt - Behavioral
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

entity BackMgmt is
    Port ( i_view_x : in STD_LOGIC_VECTOR (9 downto 0);
           i_view_y : in STD_LOGIC_VECTOR (9 downto 0);
           i_col : in STD_LOGIC_VECTOR (6 downto 0);
           i_row : in STD_LOGIC_VECTOR (6 downto 0);
           i_tile_id : in STD_LOGIC_VECTOR (4 downto 0);
           i_flip_y : in STD_LOGIC;
           i_ch_tile_id : in STD_LOGIC;
           i_ch_flip : in STD_LOGIC;
           i_clk : in STD_LOGIC;
           o_tile_id : out STD_LOGIC_VECTOR (4 downto 0);
           o_flip_y : out STD_LOGIC;
           o_pix_x : out STD_LOGIC_VECTOR (2 downto 0);
           o_pix_y : out STD_LOGIC_VECTOR (2 downto 0));
end BackMgmt;

architecture Behavioral of BackMgmt is

begin


end Behavioral;
