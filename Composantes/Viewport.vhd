----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.06.2025 00:00:57
-- Design Name: 
-- Module Name: Viewport - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Viewport is
    Port ( i_x : in STD_LOGIC_VECTOR (9 downto 0); --X en entrée
           i_y : in STD_LOGIC_VECTOR (8 downto 0); --Y en entrée
           i_ch_setoffset : in STD_LOGIC; --Est-ce que l'on veut définir un offset?
           i_ch_moveoffset : in STD_LOGIC; --Est-ce que l'on veut décaler l'offset?
           i_x_newoffset : in STD_LOGIC_VECTOR (9 downto 0); --Nouvelle position x
           i_y_newoffset : in STD_LOGIC_VECTOR (9 downto 0); --Nouvelle position y
           i_clk : in STD_LOGIC;
           o_x_offseted : out STD_LOGIC_VECTOR (9 downto 0); --X en sortie, décalé
           o_y_offseted : out STD_LOGIC_VECTOR (9 downto 0) --Y en sortie, décalé
    );
end Viewport;

architecture Behavioral of Viewport is

    signal r_offset_x : std_logic_vector(9 downto 0) := (others=> '0'); --"R" pour registre
    signal r_offset_y : std_logic_vector(9 downto 0) := (others=> '0'); --"R" pour registre
    
begin

o_x_offseted <= std_logic_vector(unsigned(i_x) + unsigned(r_offset_x));
o_y_offseted <= std_logic_vector(unsigned(i_y) + unsigned(r_offset_y));


process(i_clk)
begin
    --if(i_rstn = '0') then
        --reset?
    if(rising_edge(i_clk)) then
        
        if (i_ch_setoffset = '1' and i_ch_moveoffset = '1') then
        -- ????? Juste au cas où ?????
        elsif(i_ch_setoffset = '1') then
        -- Set à la position fournie    
            r_offset_x <= i_x_newoffset;
            r_offset_y <= i_y_newoffset;
        
        elsif(i_ch_moveoffset = '1') then
        -- Move de la position fournie
            r_offset_x <= std_logic_vector(unsigned(i_x_newoffset) + unsigned(r_offset_x));
            r_offset_y <= std_logic_vector(unsigned(i_y_newoffset) + unsigned(r_offset_y));
            
        end if;
    end if;
end process;

end Behavioral;
