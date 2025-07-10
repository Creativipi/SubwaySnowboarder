----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.07.2025 14:07:06
-- Design Name: 
-- Module Name: Right8BitShifter - Behavioral
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

entity Right8BitShifter is
    Port ( i_in : in STD_LOGIC_VECTOR (7 downto 0);
           i_shift : in STD_LOGIC;
           o_out : out STD_LOGIC_VECTOR (7 downto 0));
end Right8BitShifter;

architecture Behavioral of Right8BitShifter is

begin

o_out(7) <= i_in(7) AND NOT(i_shift);
o_out(6) <= (i_in(6) AND NOT(i_shift)) OR (i_in(7) AND i_shift);
o_out(5) <= (i_in(5) AND NOT(i_shift)) OR (i_in(6) AND i_shift);
o_out(4) <= (i_in(4) AND NOT(i_shift)) OR (i_in(5) AND i_shift);
o_out(3) <= (i_in(3) AND NOT(i_shift)) OR (i_in(4) AND i_shift);
o_out(2) <= (i_in(2) AND NOT(i_shift)) OR (i_in(3) AND i_shift);
o_out(1) <= (i_in(1) AND NOT(i_shift)) OR (i_in(2) AND i_shift);
o_out(0) <= (i_in(0) AND NOT(i_shift)) OR (i_in(1) AND i_shift);

end Behavioral;
