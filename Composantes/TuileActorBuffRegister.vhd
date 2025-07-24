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

entity TuileActorBuffRegister is
    Port ( i_tile_id : in std_logic_vector (2 downto 0);
           matrix_16x16 : out std_logic_vector (1023 downto 0)
           );
end TuileActorBuffRegister;

architecture Behavioral of TuileActorBuffRegister is

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
        when "000" =>
            matrix_16x16 <= 
            bl & bl & wh & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl &
            bl & bl & wh & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl &
            bl & bl & wh & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl &
            bl & bl & wh & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl &
            bl & bl & wh & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl &
            bl & bl & wh & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl &
            bl & bl & wh & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl &
            bl & bl & wh & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & 
            bl & bl & wh & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl &     
            bl & bl & wh & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl &     
            bl & bl & wh & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl &     
            bl & bl & wh & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl &     
            bl & bl & wh & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl &     
            bl & bl & wh & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl &     
            bl & bl & wh & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl &     
            bl & bl & wh & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl & bl;   
             
        when others =>
            matrix_16x16 <= (others => '0');
    end case;       
end process;


end Behavioral;
