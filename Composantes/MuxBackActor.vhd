----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.06.2025 00:00:57
-- Design Name: 
-- Module Name: MuxBackActor - Behavioral
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

entity MuxBackActor is
    Port ( i_back_color_code : in STD_LOGIC_VECTOR (3 downto 0);
           i_act_color_code : in STD_LOGIC_VECTOR (3 downto 0);
           i_act_en : in STD_LOGIC;
           i_clk : in STD_LOGIC;
           o_color_code : out STD_LOGIC_VECTOR (3 downto 0));
end MuxBackActor;

architecture Behavioral of MuxBackActor is

begin

o_color_code <= i_back_color_code;


end Behavioral;
