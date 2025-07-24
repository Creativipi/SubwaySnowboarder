----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.07.2025 13:59:45
-- Design Name: 
-- Module Name: TB_MuxBackActor - Behavioral
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

entity TB_MuxBackActor is
--  Port ( );
end TB_MuxBackActor;

architecture Behavioral of TB_MuxBackActor is

COMPONENT MuxBackActor
        PORT(
           i_back_color_code : in STD_LOGIC_VECTOR (3 downto 0);
           i_act_color_code : in STD_LOGIC_VECTOR (3 downto 0);
           i_act_en : in STD_LOGIC;
           o_color_code : out STD_LOGIC_VECTOR (3 downto 0)
          );
    end COMPONENT; 

    signal t_back_color_code : std_logic_vector(3 downto 0) := (others => '0');
    signal t_act_color_code : std_logic_vector(3 downto 0) := (others => '0');
    signal t_act_en : std_logic := '1';
    signal t_color_code : std_logic_vector(3 downto 0) := (others => '0');

    constant c_Period      : time :=  20 ns;  -- 50 MHz  -- frequence de l'horloge
    constant c_delai_commandes   : time :=  1 us;  -- delai entre commandes du bouton

begin

    Test_Bench: MuxBackActor
        PORT MAP(
            i_back_color_code => t_back_color_code,
            i_act_color_code => t_act_color_code,
            i_act_en => t_act_en,
            o_color_code => t_color_code
        );

    tb : PROCESS
    BEGIN

       --> Cette partie est pour vérifier que le nombre de shift est respecté
         wait for c_delai_commandes/4;
         wait for c_Period; t_act_color_code <= "0001"; t_back_color_code <= "1111";
         wait for c_Period; t_act_color_code <= "0010";
         wait for c_Period; t_act_color_code <= "0011";
         wait for c_Period; t_act_color_code <= "0100";
         wait for c_Period; t_act_color_code <= "0101";
         wait for c_Period; t_act_color_code <= "0110";
         wait for c_Period; t_act_color_code <= "0111";
         wait for c_Period; t_act_color_code <= "1111";
         wait for c_Period; t_back_color_code <= "1001";
         wait for c_Period; t_back_color_code <= "1010";
         wait for c_Period; t_act_color_code <= "1000";
         wait for c_Period; t_act_color_code <= "1011";
         wait for c_Period * 2 ; t_act_en <= '0';
         wait for c_Period; t_back_color_code <= "1100";
         wait for c_Period; t_back_color_code <= "1101";
         wait for c_Period; t_back_color_code <= "1110"; t_act_color_code <= "1111";
         wait for c_Period; t_back_color_code <= "1111";
         
         
         WAIT; -- will wait forever
    END PROCESS;

end Behavioral;
