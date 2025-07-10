----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.07.2025 14:42:45
-- Design Name: 
-- Module Name: ResetCounter - Behavioral
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

entity ResetCounter is
    Port ( i_reset : in STD_LOGIC;
           i_clk : in STD_LOGIC;
           o_count : out STD_LOGIC_VECTOR (3 downto 0));
end ResetCounter;

architecture Behavioral of ResetCounter is

    signal r_lastState : std_logic := '0';
    signal r_count : std_logic_vector(3 downto 0) := (others=> '0'); --"R" pour registre

begin

o_count <= r_count;

process(i_clk)
begin
    if(rising_edge(i_clk)) then
        
        if (i_reset = '0') then
            
            if (r_lastState = '1') then
                
                --Changement d'état
                r_lastState <= '0';
                
            else
            
                -- r_count--
                case r_count is
                when "0000" => -- 0
                    --Fait rien
                when "0001" => --  1
                    r_count <= "0000";
                when "0010" => --  2
                    r_count <= "0001";
                when "0011" => --  3
                    r_count <= "0010";
                when "0100" => --  4
                    r_count <= "0011";
                when "0101" => --  5
                    r_count <= "0100";
                when "0110" => --  6
                    r_count <= "0101";
                when "0111" => --  7
                    r_count <= "0110";
                when "1000" => --  8
                    r_count <= "0111";
                when "1001" => --  9
                    r_count <= "1000";
                when "1010" => -- 10
                    r_count <= "1001";
                when "1011" => -- 11
                    r_count <= "1010";
                when "1100" => -- 12
                    r_count <= "1011";
                when "1101" => -- 13
                    r_count <= "1100";
                when "1110" => -- 14
                    r_count <= "1101";
                when "1111" => -- 15
                    r_count <= "1110";
                when others => --Fait rien
            end case;
                
            end if;
        
        elsif(i_reset = '1') then
        
            if (r_lastState = '0') then
                
                --Changement d'état
                r_lastState <= '1';
                
            elsif (r_count /= "1111") then
            
                -- r_count++
                case r_count is
                when "0000" => -- 0
                    r_count <= "0001";
                when "0001" => --  1
                    r_count <= "0010";
                when "0010" => --  2
                    r_count <= "0011";
                when "0011" => --  3
                    r_count <= "0100";
                when "0100" => --  4
                    r_count <= "0101";
                when "0101" => --  5
                    r_count <= "0110";
                when "0110" => --  6
                    r_count <= "0111";
                when "0111" => --  7
                    r_count <= "1000";
                when "1000" => --  8
                    r_count <= "1000";
                when "1001" => --  9
                    r_count <= "1010";
                when "1010" => -- 10
                    r_count <= "1011";
                when "1011" => -- 11
                    r_count <= "1100";
                when "1100" => -- 12
                    r_count <= "1101";
                when "1101" => -- 13
                    r_count <= "1110";
                when "1110" => -- 14
                    r_count <= "1111";
                when "1111" => -- 15
                    r_count <= "1111";
                when others => --Fait rien
            end case;
                
            end if;
            
        end if;
    end if;
end process;


end Behavioral;
