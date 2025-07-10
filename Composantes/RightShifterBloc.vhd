----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.07.2025 14:12:46
-- Design Name: 
-- Module Name: RightShifterBloc - Behavioral
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

entity RightShifterBloc is
    Port ( i_in : in STD_LOGIC_VECTOR (7 downto 0);
           i_select : in STD_LOGIC_VECTOR (3 downto 0);
           o_out : out STD_LOGIC_VECTOR (7 downto 0));
end RightShifterBloc;



architecture Behavioral of RightShifterBloc is

component Bin2Thermo is
  port ( 
    i_bin : in STD_LOGIC_VECTOR (3 downto 0);
    o_thermo : out STD_LOGIC_VECTOR (14 downto 0)
  );
end component;

component Right8BitShifter is
  port ( 
    i_in : in STD_LOGIC_VECTOR (7 downto 0);
    i_shift : in STD_LOGIC;
    o_out : out STD_LOGIC_VECTOR (7 downto 0)
  );
end component;

signal s_thermo : std_logic_vector(14 downto 0);
signal s_out_0 : std_logic_vector(7 downto 0);
signal s_out_1 : std_logic_vector(7 downto 0);
signal s_out_2 : std_logic_vector(7 downto 0);
signal s_out_3 : std_logic_vector(7 downto 0);
signal s_out_4 : std_logic_vector(7 downto 0);
signal s_out_5 : std_logic_vector(7 downto 0);
signal s_out_6 : std_logic_vector(7 downto 0);

begin

Bin2Thermo_0 : component Bin2Thermo
     port map(
      i_bin => i_select,
      o_thermo => s_thermo
    );



 
Right8BitShifter_0 : component Right8BitShifter
     port map(
      i_in => i_in,
      i_shift => s_thermo(0),
      o_out => s_out_0
    );
    
Right8BitShifter_1 : component Right8BitShifter
     port map(
      i_in => s_out_0,
      i_shift => s_thermo(1),
      o_out => s_out_1
    );
    
Right8BitShifter_2 : component Right8BitShifter
     port map(
      i_in => s_out_1,
      i_shift => s_thermo(2),
      o_out => s_out_2
    );
    
Right8BitShifter_3 : component Right8BitShifter
     port map(
      i_in => s_out_2,
      i_shift => s_thermo(3),
      o_out => s_out_3
    );

Right8BitShifter_4 : component Right8BitShifter
     port map(
      i_in => s_out_3,
      i_shift => s_thermo(4),
      o_out => s_out_4
    );

Right8BitShifter_5 : component Right8BitShifter
     port map(
      i_in => s_out_4,
      i_shift => s_thermo(5),
      o_out => s_out_5
    );

Right8BitShifter_6 : component Right8BitShifter
     port map(
      i_in => s_out_5,
      i_shift => s_thermo(6),
      o_out => s_out_6
    );

Right8BitShifter_7 : component Right8BitShifter
     port map(
      i_in => s_out_6,
      i_shift => s_thermo(7),
      o_out => o_out
    );



end Behavioral;
