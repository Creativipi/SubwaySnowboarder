----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.06.2025 00:00:57
-- Design Name: 
-- Module Name: ColorConvertor - Behavioral
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

entity ColorConvertor is
    Port ( i_color_code : in STD_LOGIC_VECTOR (3 downto 0);
           i_color_id : in STD_LOGIC_VECTOR (3 downto 0);
           i_new_RBG : in STD_LOGIC_VECTOR (23 downto 0);
           i_ch_color : in STD_LOGIC;
           i_clk : in STD_LOGIC;
           o_RBG : out STD_LOGIC_VECTOR (23 downto 0));
end ColorConvertor;

architecture Behavioral of ColorConvertor is
    
    signal r_couleur_0 : std_logic_vector (23 downto 0) := X"fefefe";
    signal r_couleur_1 : std_logic_vector (23 downto 0) := X"050505";
    signal r_couleur_2 : std_logic_vector (23 downto 0) := X"e902ec";
    signal r_couleur_3 : std_logic_vector (23 downto 0) := X"4f2b9a";
    signal r_couleur_4 : std_logic_vector (23 downto 0) := X"f200a5";
    signal r_couleur_5 : std_logic_vector (23 downto 0) := X"19f000";
    signal r_couleur_6 : std_logic_vector (23 downto 0) := X"5219ac";
    signal r_couleur_7 : std_logic_vector (23 downto 0) := X"99477a";
    signal r_couleur_8 : std_logic_vector (23 downto 0) := X"864261";
    signal r_couleur_9 : std_logic_vector (23 downto 0) := X"99ac97";
    signal r_couleur_10 : std_logic_vector(23 downto 0) := X"6e816c";
    signal r_couleur_11 : std_logic_vector(23 downto 0) := X"90ffad";
    signal r_couleur_12 : std_logic_vector(23 downto 0) := X"b3ffda";
    signal r_couleur_13 : std_logic_vector(23 downto 0) := X"ff9093";
    signal r_couleur_14 : std_logic_vector(23 downto 0) := X"fdffe2";
    signal r_couleur_15 : std_logic_vector(23 downto 0) := X"593086";
    signal rbg_color : std_logic_vector(23 downto 0);
    
    
begin
          
process(i_clk)
begin
    --if(i_rstn = '0') then
        --reset?
    if(rising_edge(i_clk)) then
        if (i_ch_color = '1') then
        -- Changer la couleur
          case i_color_id is
                when "0000" => -- 0
                    r_couleur_0 <= i_new_RBG;
                when "0001" => --  1
                    r_couleur_1 <= i_new_RBG;
                when "0010" => --  2
                    r_couleur_2 <= i_new_RBG;
                when "0011" => --  3
                    r_couleur_3 <= i_new_RBG;
                when "0100" => --  4
                    r_couleur_4 <= i_new_RBG;
                when "0101" => --  5
                    r_couleur_5 <= i_new_RBG;
                when "0110" => --  6
                    r_couleur_6 <= i_new_RBG;
                when "0111" => --  7
                    r_couleur_7 <= i_new_RBG;
                when "1000" => --  8
                    r_couleur_8 <= i_new_RBG;
                when "1001" => --  9
                    r_couleur_9 <= i_new_RBG;
                when "1010" => -- 10
                    r_couleur_10 <= i_new_RBG;
                when "1011" => -- 11
                    r_couleur_11 <= i_new_RBG;
                when "1100" => -- 12
                    r_couleur_12 <= i_new_RBG;
                when "1101" => -- 13
                    r_couleur_13 <= i_new_RBG;
                when "1110" => -- 14
                    r_couleur_14 <= i_new_RBG;
                when "1111" => -- 15
                    r_couleur_15 <= i_new_RBG;
                when others => --Fait rien
            end case;
        end if;
    end if;
    
    -- Ce qui est envoy  selon l'entr e
    case i_color_code is
        when "0000" => -- 0
            o_RBG <= r_couleur_0;
        when "0001" => --  1
            o_RBG <= r_couleur_1;
        when "0010" => --  2
            o_RBG <= r_couleur_2;
        when "0011" => --  3
            o_RBG <= r_couleur_3;
        when "0100" => --  4
            o_RBG <= r_couleur_4;
        when "0101" => --  5
            o_RBG <= r_couleur_5;
        when "0110" => --  6
            o_RBG <= r_couleur_6;
        when "0111" => --  7
            o_RBG <= r_couleur_7;
        when "1000" => --  8
            o_RBG <= r_couleur_8;
        when "1001" => --  9
            o_RBG <= r_couleur_9;
        when "1010" => -- 10
            o_RBG <= r_couleur_10;
        when "1011" => -- 11
            o_RBG <= r_couleur_11;
        when "1100" => -- 12
            o_RBG <= r_couleur_12;
        when "1101" => -- 13
            o_RBG <= r_couleur_13;
        when "1110" => -- 14
            o_RBG <= r_couleur_14;
        when "1111" => -- 15
            o_RBG <= r_couleur_15;
        when others =>
            o_RBG <= r_couleur_0;
    end case;
    
    
end process;

end Behavioral;
