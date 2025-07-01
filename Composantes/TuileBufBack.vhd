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
use IEEE.NUMERIC_STD.ALL;

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

    signal selectedTile : std_logic_vector(255 downto 0);

begin

    process(i_tile_id, i_flip_y, i_pix_x, i_pix_y)
    variable temp_matrix : std_logic_vector(255 downto 0);
    variable borneDepart : integer;
    begin
        if (i_flip_y = '1') then
            temp_matrix(255 downto 240) := selectedTile(239 downto 224);
            temp_matrix(239 downto 224) := selectedTile(255 downto 240);
            temp_matrix(223 downto 208) := selectedTile(207 downto 192);
            temp_matrix(207 downto 192) := selectedTile(223 downto 208);
            temp_matrix(191 downto 176) := selectedTile(175 downto 160);
            temp_matrix(175 downto 160) := selectedTile(191 downto 176);
            temp_matrix(159 downto 144) := selectedTile(143 downto 128);
            temp_matrix(143 downto 128) := selectedTile(159 downto 144);
            temp_matrix(127 downto 112) := selectedTile(111 downto 196);
            temp_matrix(111 downto 96) := selectedTile(127 downto 112);
            temp_matrix(95 downto 80) := selectedTile(79 downto 64);
            temp_matrix(79 downto 64) := selectedTile(95 downto 80);
            temp_matrix(63 downto 48) := selectedTile(47 downto 32);
            temp_matrix(47 downto 32) := selectedTile(63 downto 48);
            temp_matrix(31 downto 16) := selectedTile(15 downto 0);
            temp_matrix(15 downto 0) := selectedTile(31 downto 16);
        else
            temp_matrix := selectedTile;
        end if;
        
        borneDepart := 255 - TO_INTEGER(unsigned(i_pix_y))*32 + TO_INTEGER(unsigned(i_pix_x))*4;
        o_color_code <= temp_matrix(borneDepart downto borneDepart - 3);
        
    end process;
    

end Behavioral;
