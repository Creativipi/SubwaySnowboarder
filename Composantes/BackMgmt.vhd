----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.06.2025 00:00:57
-- Design Name: 
-- Module Name: BackMgmt - Behavioral
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

entity BackMgmt is
    Port ( i_view_x : in STD_LOGIC_VECTOR (9 downto 0); -- position x du pixel à voir
           i_view_y : in STD_LOGIC_VECTOR (9 downto 0); -- position y du pixel à voir
           i_ch_we_tileBack : in STD_LOGIC;
           i_col : in STD_LOGIC_VECTOR (6 downto 0); -- prochaine tuile à changer
           i_row : in STD_LOGIC_VECTOR (6 downto 0); -- prochaine tuile à changer
           i_tile_id : in STD_LOGIC_VECTOR (4 downto 0); -- tuile qui change
           i_flip_y : in STD_LOGIC; -- valeur du flip
           i_ch_tile_id : in STD_LOGIC; -- change la tuile?
           i_ch_flipY : in STD_LOGIC; -- change le flip?
           i_clk : in STD_LOGIC; -- la clock
           
           -- Info du pixel qu'on regarde
           o_tile_id : out STD_LOGIC_VECTOR (4 downto 0); 
           o_flip_y : out STD_LOGIC;
           o_pix_x : out STD_LOGIC_VECTOR (2 downto 0);
           o_pix_y : out STD_LOGIC_VECTOR (2 downto 0));
end BackMgmt;

architecture Behavioral of BackMgmt is
    signal s_view_index : std_logic_vector (13 downto 0);
    signal r_view_x, r_view_y : std_logic_vector(9 downto 0);

    type tile_id_array_t is array (0 to 16383) of std_logic_vector(4 downto 0);
    type flip_y_array_t is array (0 to 16383) of std_logic;

    signal tile_id_map : tile_id_array_t := (others => (others => '0'));
    signal flip_y_map  : flip_y_array_t  := (others => '0');

    attribute ram_style : string;
    attribute ram_style of tile_id_map : signal is "block";
    attribute ram_style of flip_y_map  : signal is "block";
begin

    s_view_index(13 downto 7) <= i_view_y(9 downto 3);
    s_view_index(6 downto 0) <= i_view_x(9 downto 3);

    o_tile_id <= tile_id_map(to_integer(unsigned(s_view_index)));
    o_flip_y  <= flip_y_map(to_integer(unsigned(s_view_index)));

    o_pix_x <= i_view_x(2 downto 0);
    o_pix_y <= i_view_y(2 downto 0);

    process(i_clk)
    variable write_index : std_logic_vector (13 downto 0);
    begin
    if rising_edge(i_clk) then
        if (i_ch_we_tileBack = '1') then
            write_index := i_row & i_col;

            if i_ch_tile_id = '1' then
                tile_id_map(to_integer(unsigned(write_index))) <= i_tile_id;
            end if;

            if i_ch_flipY = '1' then
                flip_y_map(to_integer(unsigned(write_index))) <= i_flip_y;
            end if;
        end if;
    end if;
end process;

end Behavioral;