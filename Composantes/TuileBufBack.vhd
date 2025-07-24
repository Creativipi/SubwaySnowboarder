----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.06.2025 00:00:57
-- Design Name: 
-- Module Name: TuileBufBack - Behavioral
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

entity TuileBufBack is
    Port ( i_tile_id : in STD_LOGIC_VECTOR (4 downto 0);
           i_flip_y : in STD_LOGIC;
           i_pix_x : in STD_LOGIC_VECTOR (2 downto 0);
           i_pix_y : in STD_LOGIC_VECTOR (2 downto 0);
           o_color_code : out STD_LOGIC_VECTOR (3 downto 0));
end TuileBufBack;

architecture Behavioral of TuileBufBack is

    component TuileBackBuffRegister is
    port (
        i_tile_id : in std_logic_vector (4 downto 0);
        matrix_8x8 : out std_logic_vector (255 downto 0)
        );
    end component;
    
    function reverse_32bit_vector_by_blocks_of_4 (a: in std_logic_vector)
    return std_logic_vector is
        variable norm_a : std_logic_vector(31 downto 0);
        variable result: std_logic_vector(31 downto 0);
        variable i : integer := 31;
    begin
        for j in 0 to 31 loop
            norm_a(j) := a(a'LOW + j);
        end loop;
    
        while i >= 3 loop
            result(i downto i - 3) := norm_a(31 - i + 3 downto 31 - i);
            i := i - 4;
        end loop;
    return result;
    end;

    signal selectedTile : std_logic_vector(255 downto 0);
    signal selectedTile_reg : std_logic_vector(255 downto 0);
    signal temp_matrix : std_logic_vector(255 downto 0);

begin

    TuileBackBuffRegister_0 : component TuileBackBuffRegister
    port map(
        i_tile_id => i_tile_id,
        matrix_8x8 => selectedTile
    );
    
    temp_matrix(255 downto 224) <= reverse_32bit_vector_by_blocks_of_4(selectedTile(255 downto 224)) when i_flip_y = '1' else selectedTile(255 downto 224);
    temp_matrix(223 downto 192) <= reverse_32bit_vector_by_blocks_of_4(selectedTile(223 downto 192)) when i_flip_y = '1' else selectedTile(223 downto 192);
    temp_matrix(191 downto 160) <= reverse_32bit_vector_by_blocks_of_4(selectedTile(191 downto 160)) when i_flip_y = '1' else selectedTile(191 downto 160);
    temp_matrix(159 downto 128) <= reverse_32bit_vector_by_blocks_of_4(selectedTile(159 downto 128)) when i_flip_y = '1' else selectedTile(159 downto 128);
    temp_matrix(127 downto 96) <= reverse_32bit_vector_by_blocks_of_4(selectedTile(127 downto 96)) when i_flip_y = '1' else selectedTile(127 downto 96);
    temp_matrix(95 downto 64) <= reverse_32bit_vector_by_blocks_of_4(selectedTile(95 downto 64)) when i_flip_y = '1' else selectedTile(95 downto 64);
    temp_matrix(63 downto 32) <= reverse_32bit_vector_by_blocks_of_4(selectedTile(63 downto 32)) when i_flip_y = '1' else selectedTile(63 downto 32);
    temp_matrix(31 downto 0) <= reverse_32bit_vector_by_blocks_of_4(selectedTile(31 downto 0)) when i_flip_y = '1' else selectedTile(31 downto 0);
    
    o_color_code(3) <= temp_matrix(255 - TO_INTEGER(unsigned(i_pix_y & i_pix_x & "00")));
    o_color_code(2) <= temp_matrix(254 - TO_INTEGER(unsigned(i_pix_y & i_pix_x & "00")));
    o_color_code(1) <= temp_matrix(253 - TO_INTEGER(unsigned(i_pix_y & i_pix_x & "00")));
    o_color_code(0) <= temp_matrix(252 - TO_INTEGER(unsigned(i_pix_y & i_pix_x & "00")));
--    o_color_code <= temp_matrix(255 - TO_INTEGER(unsigned(i_pix_y & i_pix_x & "00")) downto 255 - TO_INTEGER(unsigned(i_pix_y & i_pix_x & "00")) - 3);

end Behavioral;
