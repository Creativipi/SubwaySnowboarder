----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.06.2025 22:53:33
-- Design Name: 
-- Module Name: TB_Viewport - Behavioral
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

entity TB_ViewPort is
--  (Pas de ports)
end TB_ViewPort;

architecture Behavioral of TB_ViewPort is

    COMPONENT ViewPort
        PORT(
          i_x : in STD_LOGIC_VECTOR (9 downto 0); --X en entrée
          i_y : in STD_LOGIC_VECTOR (8 downto 0); --Y en entrée
          i_ch_setoffset : in STD_LOGIC; --Est-ce que l'on veut définir un offset?
          i_ch_moveoffset : in STD_LOGIC; --Est-ce que l'on veut décaler l'offset?
          i_x_newoffset : in STD_LOGIC_VECTOR (9 downto 0); --Nouvelle position x
          i_y_newoffset : in STD_LOGIC_VECTOR (9 downto 0); --Nouvelle position y
          i_clk : in STD_LOGIC;
          o_x_offseted : out STD_LOGIC_VECTOR (9 downto 0); --X en sortie, décalé
          o_y_offseted : out STD_LOGIC_VECTOR (9 downto 0) --Y en sortie, décalé
          );
    end COMPONENT;  
    
    signal t_x : STD_LOGIC_VECTOR (9 downto 0) := (others => '0'); --X en entrée
    signal t_y : STD_LOGIC_VECTOR (8 downto 0) := (others => '0'); --Y en entrée
    signal t_ch_setoffset : STD_LOGIC := '0'; --Est-ce que l'on veut définir un offset?
    signal t_ch_moveoffset : STD_LOGIC := '0'; --Est-ce que l'on veut décaler l'offset?
    signal t_x_newoffset : STD_LOGIC_VECTOR (9 downto 0) := (others => '0'); --Nouvelle position x
    signal t_y_newoffset : STD_LOGIC_VECTOR (9 downto 0) := (others => '0'); --Nouvelle position y
    signal t_clk : STD_LOGIC;
    signal t_o_x_offseted : STD_LOGIC_VECTOR (9 downto 0); --X en sortie, décalé
    signal t_o_y_offseted : STD_LOGIC_VECTOR (9 downto 0); --Y en sortie, décalé
    
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
        
    Test_Bench: ViewPort
        PORT MAP(
            i_x => t_x,
            i_y => t_y,
            i_ch_setoffset => t_ch_setoffset,
            i_ch_moveoffset => t_ch_moveoffset,
            i_x_newoffset => t_x_newoffset,
            i_y_newoffset => t_y_newoffset,
            i_clk => t_clk,
            o_x_offseted => t_o_x_offseted,
            o_y_offseted => t_o_y_offseted
        );

    tb : PROCESS
    BEGIN

       --> Cette partie est pour vérifier sans offset
         wait for c_Period/2; t_x <= "0000000001";
         wait for c_Period; t_y <= "000000001";
         wait for c_Period; t_x <= "0000000010"; t_y <= "000000001";
         
         
       --> Cette partie est pour vérifier move
         wait for c_Period*2; t_x_newoffset <= "1000000100"; t_y_newoffset <= "1000000100";
         wait for c_Period; t_ch_moveoffset <= '1';
         wait for c_Period*2; t_ch_moveoffset <= '0'; t_x_newoffset <= "1000000000"; t_y_newoffset <= "1000000000";

       --> Cette partie est pour vérifier set
         wait for c_Period; t_ch_setoffset <= '1';
         wait for c_Period*2; t_ch_setoffset <= '0';

       --> Cette partie est pour vérifier l'overflow
         wait for c_Period*2; t_x <= "1000000001"; t_y <= "100000010"; t_x_newoffset <= "0000000000"; t_y_newoffset <= "1100000000";
         wait for c_Period; t_ch_setoffset <= '1';
         wait for c_Period; t_ch_setoffset <= '0';
         
         
         WAIT; -- will wait forever
    END PROCESS;

end Behavioral;
