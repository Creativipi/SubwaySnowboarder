----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.06.2025 22:53:33
-- Design Name: 
-- Module Name: TB_ColorConvertor - Behavioral
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

entity TB_ColorConvertor is
-- Pas de ports
end TB_ColorConvertor;

architecture Behavioral of TB_ColorConvertor is

    COMPONENT ColorConvertor
        PORT(
          i_color_code : in STD_LOGIC_VECTOR (3 downto 0);
          i_color_id : in STD_LOGIC_VECTOR (3 downto 0);
          i_new_RBG : in STD_LOGIC_VECTOR (23 downto 0);
          i_ch_color : in STD_LOGIC;
          i_clk : in STD_LOGIC;
          o_RBG : out STD_LOGIC_VECTOR (23 downto 0)
          );
    end COMPONENT;
    
    signal t_color_code : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal t_color_id : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal t_new_RBG : STD_LOGIC_VECTOR (23 downto 0) := (others => '0');
    signal t_ch_color : STD_LOGIC := '0';
    signal t_clk : STD_LOGIC := '0';
    
    signal t_o_RBG : STD_LOGIC_VECTOR (23 downto 0) := (others => '0');
    
    constant c_Period      : time :=  20 ns;  -- 50 MHz  -- frequence de l'horloge Dummyclock
    constant c_delai_commandes   : time :=  10 us;  -- delai entre commandes du bouton

begin
       
    sim_clk_p:  process -- Clock
       begin
          t_clk <= '1';  -- init
          loop
             wait for c_Period / 2;
             t_clk <= not t_clk; -- invert clock value
          end loop;
       end process;

    Test_Bench: ColorConvertor
        PORT MAP(
            i_color_code => t_color_code,
            i_color_id => t_color_id,
            i_new_RBG => t_new_RBG,
            i_ch_color => t_ch_color,
            i_clk => t_clk,
            o_RBG => t_o_RBG
        );
       
    tb : PROCESS
    BEGIN

       --> Cette partie est pour vérifier les permier codes déjà enregistrés
         wait for c_Period; t_color_code <= "0001";
         wait for c_Period; t_color_code <= "0010";
         wait for c_Period; t_color_code <= "0011";
         wait for c_Period; t_color_code <= "0100";
         wait for c_Period; t_color_code <= "0101";
         wait for c_Period; t_color_code <= "0110";
         wait for c_Period; t_color_code <= "0111";
         wait for c_Period; t_color_code <= "1000";
         wait for c_Period; t_color_code <= "1001";
         wait for c_Period; t_color_code <= "1010";
         wait for c_Period; t_color_code <= "1011";
         wait for c_Period; t_color_code <= "1100";
         wait for c_Period; t_color_code <= "1101";
         wait for c_Period; t_color_code <= "1110";
         wait for c_Period; t_color_code <= "1111";
         
       --> Cette partie est pour vérifier l'écriture      
         wait for c_Period*2; t_color_code <= "0000"; t_color_id <= "0001"; t_new_RBG <= "001100001100000000110000"; --Un genre de bleu fort
         wait for c_delai_commandes; t_color_code <= "0001";
         wait for c_delai_commandes; t_ch_color <= '1';
         wait for c_delai_commandes; t_ch_color <= '0';
         wait for c_delai_commandes; t_new_RBG <= "001100000011000011000000"; --Un genre de vert fort
         wait for c_delai_commandes; t_color_code <= "0000"; t_color_id <= "0000";
         wait for c_delai_commandes; t_ch_color <= '1';
         wait for c_delai_commandes; t_new_RBG <= "110000000011000000110000"; --Un genre de rouge fort
         wait for c_delai_commandes; t_ch_color <= '0';
         
       --> Cette partie est pour valider les changements fait
         wait for c_Period; t_color_code <= "0001";
         wait for c_Period; t_color_code <= "0010";
         wait for c_Period; t_color_code <= "0011";
         wait for c_Period; t_color_code <= "0100";
         wait for c_Period; t_color_code <= "0101";
         wait for c_Period; t_color_code <= "0110";
         wait for c_Period; t_color_code <= "0111";
         wait for c_Period; t_color_code <= "1000";
         wait for c_Period; t_color_code <= "1001";
         wait for c_Period; t_color_code <= "1010";
         wait for c_Period; t_color_code <= "1011";
         wait for c_Period; t_color_code <= "1100";
         wait for c_Period; t_color_code <= "1101";
         wait for c_Period; t_color_code <= "1110";
         wait for c_Period; t_color_code <= "1111";
         
         
         WAIT; -- will wait forever
    END PROCESS;

end Behavioral;
