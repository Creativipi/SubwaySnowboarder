library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TileRenderer_tb is
end TileRenderer_tb;

architecture sim of TileRenderer_tb is

    signal i_view_x      : std_logic_vector(9 downto 0) := (others => '0');
    signal i_view_y      : std_logic_vector(9 downto 0) := (others => '0');
    signal i_col         : std_logic_vector(6 downto 0) := (others => '0');
    signal i_row         : std_logic_vector(6 downto 0) := (others => '0');
    signal i_tile_id     : std_logic_vector(4 downto 0) := (others => '0');
    signal i_flip_y      : std_logic := '0';
    signal i_ch_tile_id  : std_logic := '0';
    signal i_ch_flip_y    : std_logic := '0';
    signal i_clk         : std_logic := '0';
    signal i_ch_x        : std_logic_vector(2 downto 0) := (others => '0');
    signal i_ch_y        : std_logic_vector(2 downto 0) := (others => '0');
    signal i_ch_cc       : std_logic_vector(3 downto 0) := (others => '0');
    signal i_ch_we_tileBack : std_logic := '0';
    signal i_ch_we       : std_logic := '0';
    signal i_tile_id_write : std_logic_vector (4 downto 0) := "00000";

    signal o_colorCode   : std_logic_vector(3 downto 0);

    component TileRenderer
        port (
            i_view_x      : in std_logic_vector(9 downto 0);
            i_view_y      : in std_logic_vector(9 downto 0);
            i_col         : in std_logic_vector(6 downto 0);
            i_row         : in std_logic_vector(6 downto 0);
            i_tile_id     : in std_logic_vector(4 downto 0);
            i_flip_y      : in std_logic;
            i_ch_tile_id  : in std_logic;
            i_ch_flip_y    : in std_logic;
            i_clk         : in std_logic;
            i_ch_x        : in std_logic_vector(2 downto 0);
            i_ch_y        : in std_logic_vector(2 downto 0);
            i_ch_cc       : in std_logic_vector(3 downto 0);
            i_ch_we       : in std_logic;
            i_ch_we_tileBack : in std_logic;
            i_tile_id_write : in STD_logic_vector (4 downto 0);
            o_colorCode   : out std_logic_vector(3 downto 0)
        );
    end component;

begin
    uut: TileRenderer
        port map (
            i_view_x      => i_view_x,
            i_view_y      => i_view_y,
            i_col         => i_col,
            i_row         => i_row,
            i_tile_id     => i_tile_id,
            i_flip_y      => i_flip_y,
            i_ch_tile_id  => i_ch_tile_id,
            i_ch_flip_y    => i_ch_flip_y,
            i_clk         => i_clk,
            i_ch_x        => i_ch_x,
            i_ch_y        => i_ch_y,
            i_ch_cc       => i_ch_cc,
            i_ch_we       => i_ch_we,
            i_ch_we_tileBack => i_ch_we_tileBack,
            i_tile_id_write => i_tile_id_write,
            o_colorCode   => o_colorCode
        );

    -- Clock generation
    clk_process : process
    begin
        while true loop
            i_clk <= '0';
            wait for 5 ns;
            i_clk <= '1';
            wait for 5 ns;
        end loop;
        wait;
    end process;

    -- Stimulus
    stim_proc : process
    begin

        -- Step 1: Assign tile (tile_id=1) at map position (0,0)
        i_row <= (others => '0');  -- row 0
        i_col <= (others => '0');  -- col 0
        i_tile_id <= "00010";      -- tile_id = 1
        i_ch_tile_id <= '1';
        i_ch_we_tileBack <= '1';
        
        wait for 20 ns;
        i_ch_tile_id <= '0';
        i_ch_we_tileBack <= '0';
        
        --i_view_x <= "0000000100";
        --i_view_y <= "0000000000";

--        -- Step 2: Write color 1010 to pixel (3, 4) in tile_id = 1
        --i_tile_id <= "00001";
        i_tile_id_write <= "00010";
        i_ch_x <= "011";
        i_ch_y <= "100";
        i_ch_cc <= "1011";
        i_ch_we <= '1';
        wait for 10 ns;
        i_ch_we <= '0';

        -- Step 3: Set view to pixel (3, 4) which is inside tile at (0,0)
        i_view_x <= std_logic_vector(to_unsigned(3, 10));
        i_view_y <= std_logic_vector(to_unsigned(4, 10));
        wait for 30 ns;
        

--        assert o_colorCode = "1010"
--        report "? Pixel rendered correctly."
--        severity note;

--        -- Flip test
--        i_flip_y <= '1';
--        i_ch_flip_y <= '1';
--        wait for 10 ns;
--        i_ch_flip_y <= '0';

--        -- Read again at flipped x = 7 - 3 = 4
--        i_view_x <= std_logic_vector(to_unsigned(4, 10)); -- flip_x = 4
--        wait for 20 ns;

--        -- Expect same pixel to be visible at x=4 with flip_y = 1
--        assert o_colorCode = "1010"
--        report "? Flip Y test passed"
--        severity note;
        
--        wait for 10 ns;

        wait;
    end process;

end sim;
