----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/26/2025 11:20:11 AM
-- Design Name: 
-- Module Name: TuileBackBuffRegister - Behavioral
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

entity TuileBackBuffRegister is
    Port ( i_tile_id : in std_logic_vector (4 downto 0);
           matrix_8x8 : out std_logic_vector (255 downto 0)
           );
end TuileBackBuffRegister;

architecture Behavioral of TuileBackBuffRegister is

constant wh : std_logic_vector (3 downto 0) := "0000"; -- White
constant bl : std_logic_vector (3 downto 0) := "0001"; -- Black
constant ye : std_logic_vector (3 downto 0) := "0010"; -- Yellow
constant dg : std_logic_vector (3 downto 0) := "0011"; -- Dark Green
constant oa : std_logic_vector (3 downto 0) := "0100"; -- Orange
constant bu : std_logic_vector (3 downto 0) := "0101"; -- Blue
constant ge : std_logic_vector (3 downto 0) := "0110"; -- Green
constant lo : std_logic_vector (3 downto 0) := "0111"; -- Light Brown
constant br : std_logic_vector (3 downto 0) := "1000"; -- Brown
constant lg : std_logic_vector (3 downto 0) := "1001"; -- Light Gray
constant gr : std_logic_vector (3 downto 0) := "1010"; -- Gray
constant lb : std_logic_vector (3 downto 0) := "1011"; -- Light Blue
constant sb : std_logic_vector (3 downto 0) := "1100"; -- Sky Blue
constant sa : std_logic_vector (3 downto 0) := "1101"; -- Salmon
constant pi : std_logic_vector (3 downto 0) := "1110"; -- Pink
constant pu : std_logic_vector (3 downto 0) := "1111"; -- Purple

begin

process(i_tile_id)
begin
    case i_tile_id is
        when "00000" =>
            matrix_8x8 <= 
            wh & wh & wh & wh & wh & wh & wh & wh &
            wh & wh & wh & wh & wh & wh & wh & wh &
            wh & wh & wh & wh & wh & wh & wh & wh &
            wh & wh & wh & wh & wh & wh & wh & wh &
            wh & wh & wh & wh & wh & wh & wh & wh &
            wh & wh & wh & wh & wh & wh & wh & wh &
            wh & wh & wh & wh & wh & wh & wh & wh &
            wh & wh & wh & wh & wh & wh & wh & wh;
            
        when "00001" =>
            matrix_8x8 <= 
            wh & wh & sb & lb & lb & sb & wh & wh &
            wh & wh & sb & lb & lb & sb & sb & wh &
            wh & wh & sb & lb & lb & sb & wh & wh &
            wh & sb & lb & lb & lb & sb & wh & wh &
            wh & wh & sb & lb & lb & sb & wh & wh &
            wh & wh & sb & lb & lb & sb & sb & wh &
            wh & sb & sb & lb & lb & sb & wh & wh &
            wh & wh & sb & lb & lb & sb & wh & wh;
            
        when "00010" =>
            matrix_8x8 <= 
            wh & wh & pi & sa & sa & pi & wh & wh &
            wh & wh & pi & sa & sa & pi & wh & wh &
            wh & pi & pi & sa & sa & pi & wh & wh &
            wh & wh & pi & sa & sa & pi & wh & wh &
            wh & wh & pi & sa & sa & sa & pi & wh &
            wh & wh & pi & sa & sa & pi & wh & wh &
            wh & pi & pi & sa & sa & pi & wh & wh &
            wh & wh & pi & sa & sa & pi & wh & wh;
            
        when "00011" =>
            matrix_8x8 <= 
            wh & wh & wh & wh & wh & wh & wh & wh &
            wh & wh & wh & wh & wh & lg & lg & pi &
            wh & wh & wh & lg & lg & lg & lg & wh &
            wh & wh & lg & lg & lg & wh & gr & lg &
            wh & wh & lg & lg & gr & lg & lg & lg &
            wh & lg & wh & gr & wh & gr & lg & lg &
            wh & wh & wh & wh & lg & gr & lg & wh &
            wh & wh & wh & wh & wh & wh & wh & lg;
            
        when "00100" =>
            matrix_8x8 <= 
            lg & lg & wh & lg & lg & lg & lg & wh &
            wh & wh & wh & pi & wh & pi & wh & lg &
            wh & pi & wh & pi & pi & wh & pi & pi &
            lg & wh & lg & pi & gr & pi & lg & gr &
            pi & lg & lg & gr & gr & gr & gr & lg &
            gr & gr & gr & lg & gr & gr & lg & gr &
            wh & gr & gr & gr & pi & gr & gr & gr &
            wh & wh & wh & wh & gr & wh & gr & pi;
            
        when "00101" =>
            matrix_8x8 <= 
            wh & wh & wh & wh & wh & wh & wh & wh &
            lg & lg & wh & wh & wh & wh & wh & wh &
            gr & gr & gr & gr & wh & wh & wh & wh &
            pi & pi & lg & gr & gr & wh & wh & wh &
            pi & gr & gr & lg & lg & wh & wh & wh &
            gr & lg & gr & gr & lg & gr & wh & wh &
            gr & gr & pi & lg & pi & gr & wh & wh &
            gr & pi & pi & wh & wh & pi & wh & wh;
        when "00110" =>
            matrix_8x8 <= 
            wh & wh & wh & wh & wh & wh & wh & wh &
            wh & wh & wh & pi & lg & pi & lg & wh &
            wh & wh & pi & wh & lg & pi & wh & pi &
            wh & pi & lg & pi & lg & lg & lg & wh &
            wh & lg & wh & lg & lg & lg & lg & lg &
            lg & lg & lg & pi & lg & lg & wh & lg &
            wh & lg & pi & lg & gr & pi & lg & gr &
            lg & lg & lg & lg & lg & lg & gr & gr;
        when "00111" =>
            matrix_8x8 <= 
            lg & wh & lg & lg & pi & gr & gr & gr &
            wh & pi & gr & lg & gr & lg & gr & gr &
            lg & lg & lg & gr & gr & gr & lg & pi &
            lg & gr & gr & gr & gr & lg & gr & lg &
            lg & pi & gr & gr & gr & gr & lg & gr &
            lg & pi & gr & gr & lg & lg & gr & lg &
            wh & gr & wh & lg & gr & pi & gr & pi &
            wh & wh & gr & wh & wh & gr & wh & wh;
        when "01000" =>
            matrix_8x8 <= 
            pi & wh & pi & pi & pi & gr & wh & wh &
            lg & gr & pi & lg & gr & gr & gr & wh &
            gr & gr & gr & gr & gr & gr & gr & gr &
            lg & gr & lg & gr & gr & gr & gr & wh &
            lg & gr & gr & gr & lg & gr & wh & gr &
            gr & gr & gr & gr & gr & gr & gr & wh &
            wh & gr & lg & gr & pi & pi & pi & gr &
            wh & pi & wh & pi & pi & wh & wh & pi;
        when "01001" =>
            matrix_8x8 <= 
            wh & wh & sb & lb & lb & sb & wh & wh &
            wh & wh & sb & sb & lb & sb & wh & wh &
            wh & wh & wh & lb & lb & wh & wh & wh &
            wh & wh & wh & sb & lb & wh & wh & wh &
            wh & wh & sb & wh & sb & wh & wh & wh &
            wh & wh & wh & lb & sb & wh & wh & wh &
            wh & wh & wh & sb & wh & wh & wh & wh &
            wh & wh & wh & wh & wh & wh & wh & wh;
        when "01010" =>
            matrix_8x8 <= 
            wh & wh & pi & sa & pi & pi & wh & wh &
            wh & wh & pi & sa & sa & pi & wh & wh &
            wh & wh & pi & pi & sa & pi & wh & wh &
            wh & wh & wh & sa & pi & wh & wh & wh &
            wh & wh & wh & pi & pi & wh & wh & wh &
            wh & wh & wh & wh & sa & wh & wh & wh &
            wh & wh & wh & wh & wh & wh & wh & wh &
            wh & wh & wh & pi & wh & wh & wh & wh;
        when "01011" =>
            matrix_8x8 <= 
            bl & bl & bl & bl & bl & bl & bl & bl &
            bl & bl & bl & bl & bl & bl & bl & bl &
            bl & bl & bl & bl & bl & bl & bl & bl &
            bl & bl & bl & bl & bl & bl & bl & bl &
            bl & bl & bl & bl & bl & bl & bl & bl &
            bl & bl & bl & bl & bl & bl & bl & bl &
            bl & bl & bl & bl & bl & bl & bl & bl &
            bl & bl & bl & bl & bl & bl & bl & bl;
        when "01100" =>
            matrix_8x8 <= 
            ye & ye & ye & ye & dg & dg & dg & dg &
            ye & ye & ye & ye & dg & dg & dg & dg &
            ye & ye & ye & ye & dg & dg & dg & dg &
            ye & ye & ye & ye & dg & dg & dg & dg &
            ye & ye & ye & ye & dg & dg & dg & dg &
            ye & ye & ye & ye & dg & dg & dg & dg &
            ye & ye & ye & ye & dg & dg & dg & dg &
            ye & ye & ye & ye & dg & dg & dg & dg;
        when "01101" =>
            matrix_8x8 <= 
            oa & oa & oa & oa & bu & bu & bu & bu &
            oa & oa & oa & oa & bu & bu & bu & bu &
            oa & oa & oa & oa & bu & bu & bu & bu &
            oa & oa & oa & oa & bu & bu & bu & bu &
            oa & oa & oa & oa & bu & bu & bu & bu &
            oa & oa & oa & oa & bu & bu & bu & bu &
            oa & oa & oa & oa & bu & bu & bu & bu &
            oa & oa & oa & oa & bu & bu & bu & bu;
        when "01110" =>
            matrix_8x8 <= 
            ge & ge & ge & ge & pu & pu & pu & pu &
            ge & ge & ge & ge & pu & pu & pu & pu &
            ge & ge & ge & ge & pu & pu & pu & pu &
            ge & ge & ge & ge & pu & pu & pu & pu &
            ge & ge & ge & ge & pu & pu & pu & pu &
            ge & ge & ge & ge & pu & pu & pu & pu &
            ge & ge & ge & ge & pu & pu & pu & pu &
            ge & ge & ge & ge & pu & pu & pu & pu;
        when "01111" =>
            matrix_8x8 <= 
            lo & lo & lo & lo & br & br & br & br &
            lo & lo & lo & lo & br & br & br & br &
            lo & lo & lo & lo & br & br & br & br &
            lo & lo & lo & lo & br & br & br & br &
            lo & lo & lo & lo & br & br & br & br &
            lo & lo & lo & lo & br & br & br & br &
            lo & lo & lo & lo & br & br & br & br &
            lo & lo & lo & lo & br & br & br & br;
                    
            
        when others =>
            matrix_8x8 <= (others => '0');
    end case;       
end process;


end Behavioral;
