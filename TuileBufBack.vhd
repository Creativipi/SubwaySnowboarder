----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.06.2025 00:00:57
-- Design Name: 
-- Module Name: TuileBufBack - Behavioral
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

entity TuileBufBack is
    Port ( i_tile_id : in STD_LOGIC_VECTOR (4 downto 0);
           i_flip_y : in STD_LOGIC;
           i_pix_x : in STD_LOGIC_VECTOR (2 downto 0);
           i_pix_y : in STD_LOGIC_VECTOR (2 downto 0);
           o_color_code : out STD_LOGIC_VECTOR (3 downto 0));
end TuileBufBack;

architecture Behavioral of TuileBufBack is

begin


end Behavioral;
