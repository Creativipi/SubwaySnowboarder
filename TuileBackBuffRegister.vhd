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

begin

process(i_tile_id)
begin

    case i_tile_id is
        when "00000" =>
            matrix_8x8 <= 
            "0000" & "0000" & "0000" & "0000" & "0000" & "0000" & "0000" & "0000" &
            "0000" & "0000" & "0000" & "0000" & "0000" & "0000" & "0000" & "0000" &
            "0000" & "0000" & "0000" & "0000" & "0000" & "0000" & "0000" & "0000" &
            "0000" & "0000" & "0000" & "0000" & "0000" & "0000" & "0000" & "0000" &
            "0000" & "0000" & "0000" & "0000" & "0000" & "0000" & "0000" & "0000" &
            "0000" & "0000" & "0000" & "0000" & "0000" & "0000" & "0000" & "0000" &
            "0000" & "0000" & "0000" & "0000" & "0000" & "0000" & "0000" & "0000" &
            "0000" & "0000" & "0000" & "0000" & "0000" & "0000" & "0000" & "0000";
            
        when "00001" =>
            matrix_8x8 <= 
            "0001" & "0001" & "0001" & "0001" & "0001" & "0001" & "0001" & "0001" &
            "0001" & "0001" & "0001" & "0001" & "0001" & "0001" & "0001" & "0001" &
            "0001" & "0001" & "0001" & "0001" & "0001" & "0001" & "0001" & "0001" &
            "0001" & "0001" & "0001" & "0001" & "0001" & "0001" & "0001" & "0001" &
            "0001" & "0001" & "0001" & "0001" & "0001" & "0001" & "0001" & "0001" &
            "0001" & "0001" & "0001" & "0001" & "0001" & "0001" & "0001" & "0001" &
            "0001" & "0001" & "0001" & "0001" & "0001" & "0001" & "0001" & "0001" &
            "0001" & "0001" & "0001" & "0001" & "0001" & "0001" & "0001" & "0001";
            
        when others =>
            matrix_8x8 <= (others => '0');
    end case;       
end process;


end Behavioral;
