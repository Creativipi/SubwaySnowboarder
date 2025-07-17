----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/13/2025 10:14:10 AM
-- Design Name: 
-- Module Name: Tuile - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Tuile is
    generic (
        TILE_ID : integer := 0
    );
    Port (
           i_x : in STD_LOGIC_VECTOR (2 downto 0);
           i_y : in STD_LOGIC_VECTOR (2 downto 0);
           i_clk : in STD_LOGIC;
           i_ch_x : in STD_LOGIC_VECTOR (2 downto 0);
           i_ch_y : in STD_LOGIC_VECTOR (2 downto 0);
           i_ch_cc : in STD_LOGIC_VECTOR (3 downto 0);
           i_ch_we : in STD_LOGIC;
           o_cc : out STD_LOGIC_VECTOR (3 downto 0));
end Tuile;

architecture Behavioral of Tuile is

    component TuileBackBuffRegister is
    Port ( i_tile_id : in std_logic_vector (4 downto 0);
           matrix_8x8 : out std_logic_vector (255 downto 0)
           );
    end component;
    

    type matrix_array_t is array (0 to 63) of std_logic_vector(3 downto 0);
    signal matrice8 : matrix_array_t := (others => (others => '0'));
    signal index : integer;
    signal initialMatrice : std_logic_vector (255 downto 0);
    signal matrixIsInitialized : std_logic := '0';
    
    function to_matrix_array(vec : std_logic_vector(255 downto 0)) return matrix_array_t is
    variable result : matrix_array_t;
    begin
        for i in 0 to 63 loop
            result(i) := vec((255 - i*4) downto (252 - i*4));
        end loop;
        return result;
    end function;
    
begin
    o_cc <= matrice8(TO_INTEGER(unsigned(i_y)) * 8 + TO_INTEGER(unsigned(i_x)));
    
    uut_tuileBackBuffRegister : component TuileBackBuffRegister
    Port map (
        i_tile_id => std_logic_vector(to_unsigned(TILE_ID, 5)),
        matrix_8x8 => initialMatrice
    );
    
    process(i_clk)
    begin
        if rising_edge(i_clk) then
            if matrixIsInitialized = '0' then
                matrice8 <= to_matrix_array(initialMatrice);
                matrixIsInitialized <= '1';
            elsif i_ch_we = '1' then
                matrice8(TO_INTEGER(unsigned(i_ch_y)) * 8 + TO_INTEGER(unsigned(i_ch_x))) <= i_ch_cc;
            end if;
        end if;
    end process;
    

end Behavioral;
