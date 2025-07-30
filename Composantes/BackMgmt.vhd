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

entity BackMgmt is
    Port ( 
        i_view_x : in STD_LOGIC_VECTOR (9 downto 0); -- position x du pixel à voir
        i_view_y : in STD_LOGIC_VECTOR (9 downto 0); -- position y du pixel à voir
        i_ch_we_tileBack : in STD_LOGIC;
        i_col : in STD_LOGIC_VECTOR (6 downto 0); -- prochaine tuile à changer
        i_row : in STD_LOGIC_VECTOR (6 downto 0); -- prochaine tuile à changer
        i_tile_id : in STD_LOGIC_VECTOR (4 downto 0); -- tuile qui change
        i_flip_y : in STD_LOGIC; -- valeur du flip
        i_ch_tile_id : in STD_LOGIC; -- change la tuile?
        i_ch_flip_y : in STD_LOGIC; -- change le flip?
        i_clk : in STD_LOGIC; -- la clock

        -- Info du pixel qu'on regarde
        o_tile_id : out STD_LOGIC_VECTOR (4 downto 0); 
        o_flip_y : out STD_LOGIC;
        o_pix_x : out STD_LOGIC_VECTOR (2 downto 0);
        o_pix_y : out STD_LOGIC_VECTOR (2 downto 0)
    );
end BackMgmt;

architecture Behavioral of BackMgmt is

    -- Packed format: [5] = flip_y, [4:0] = tile_id
    type tile_data_array_t is array (0 to 16383) of std_logic_vector(7 downto 0);
    signal tile_data_map : tile_data_array_t := (others => (others => '0'));

    attribute ram_style : string;
    attribute ram_style of tile_data_map : signal is "block";
    

begin
    -- Write process
    process(i_clk)
        variable write_index : std_logic_vector(13 downto 0);
        variable new_data    : std_logic_vector(7 downto 0);
        variable tile_data : std_logic_vector (7 downto 0);
        variable s_view_index : std_logic_vector (13 downto 0);
    begin
        if rising_edge(i_clk) then
            if (i_ch_we_tileBack = '1') then
                write_index := i_row & i_col;
                --new_data := tile_data_map(to_integer(unsigned(write_index)));
                new_data := (others => '0');
                new_data(4 downto 0) := i_tile_id;
                new_data(5) := i_flip_y;
                new_data(6) := '0';
                new_data(7) := '0';

                -- Update tile_id if required
--                if i_ch_tile_id = '1' then
--                    new_data(4 downto 0) := i_tile_id;
--                end if;

--                -- Update flip_y if required
--                if i_ch_flip_y = '1' then
--                    new_data(5) := i_flip_y;
--                end if;

                -- Write back to BRAM
                tile_data_map(to_integer(unsigned(write_index))) <= new_data;
            end if;
            s_view_index := i_view_y(9 downto 3) & i_view_x(9 downto 3);
            tile_data := tile_data_map(to_integer(unsigned(s_view_index)));
            o_tile_id <= tile_data(4 downto 0);
            o_flip_y  <= tile_data(5);
            o_pix_x   <= i_view_x(2 downto 0);
            o_pix_y   <= i_view_y(2 downto 0);
        end if;
    end process;

end Behavioral;