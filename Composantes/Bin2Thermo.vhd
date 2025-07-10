----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.07.2025 14:22:14
-- Design Name: 
-- Module Name: Bin2Thermo - Behavioral
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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Bin2Thermo is
    Port ( i_bin : in STD_LOGIC_VECTOR (3 downto 0);
           o_thermo : out STD_LOGIC_VECTOR (14 downto 0));
end Bin2Thermo;

architecture Behavioral of Bin2Thermo is

begin

    with i_bin select o_thermo <=
      "000000000000000" when "0000",
      "000000000000001" when "0001",
      "000000000000011" when "0010",
      "000000000000111" when "0011",
      "000000000001111" when "0100",
      "000000000011111" when "0101",
      "000000000111111" when "0110",
      "000000001111111" when "0111",
      "000000011111111" when "1000",
      "000000111111111" when "1001",
      "000001111111111" when "1010",
      "000011111111111" when "1011",
      "000111111111111" when "1100",
      "001111111111111" when "1101",
      "011111111111111" when "1110",
      "111111111111111" when "1111",
      "000000000000000" when others;


end Behavioral;

