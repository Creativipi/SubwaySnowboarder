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
           o_pix_y : out STD_LOGIC_VECTOR (2 downto 0));
end BackMgmt;

architecture Behavioral of BackMgmt is
    signal s_view_col : integer range 0 to 127;
    signal s_view_pix_x : std_logic_vector (2 downto 0);
    signal s_view_row : integer range 0 to 127;
    signal s_view_pix_y : std_logic_vector (2 downto 0);

    -- 1D array version: 128 x 128 = 16384
    type tile_map_t is array (0 to 16383) of std_logic_vector(5 downto 0);
    signal tile_map : tile_map_t := (others => (others => '0'));
    
    signal s_view_index : std_logic_vector (13 downto 0);
    signal s_write_index : std_logic_vector (13 downto 0);

    attribute ram_style : string;
    attribute ram_style of tile_map : signal is "block";
begin

        s_view_index(13 downto 7) <= i_view_y(9 downto 3);
        s_view_index(6 downto 0) <= i_view_x(9 downto 3);

        o_tile_id <= tile_map(to_integer(unsigned(s_view_index)))(5 downto 1);
        o_flip_y  <= tile_map(to_integer(unsigned(s_view_index)))(0);
        o_pix_x <= i_view_x(2 downto 0);
        o_pix_y <= i_view_y(2 downto 0);

    process(i_clk)
        variable current_tile : std_logic_vector(5 downto 0);
        variable x, y : integer;
        variable write_index : std_logic_vector (13 downto 0);
    begin
        if rising_edge(i_clk) then
            -- write_index(13 downto 7) := i_row;
            -- write_index(6 downto 0) := i_col;
            write_index := i_row & i_col;
            current_tile := tile_map(to_integer(unsigned(write_index)));
            if i_ch_flip_y = '1' then
                current_tile(0) := i_flip_y;
            end if;
            if i_ch_tile_id = '1' then
                current_tile(5 downto 1) := i_tile_id;
            end if;
            tile_map(to_integer(unsigned(write_index))) <= current_tile;  
        end if;  
    end process;
        
end Behavioral;

