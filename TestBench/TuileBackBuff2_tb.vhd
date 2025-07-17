library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_TuileBackBuff2 is
-- no ports
end entity;

architecture Behavioral of tb_TuileBackBuff2 is

    -- Component declaration for DUT
    component TuileBackBuff2
        Port(
            i_x         : in  STD_LOGIC_VECTOR(2 downto 0);
            i_y         : in  STD_LOGIC_VECTOR(2 downto 0);
            i_tile_id   : in  STD_LOGIC_VECTOR(4 downto 0);
            i_ch_x      : in  STD_LOGIC_VECTOR(2 downto 0);
            i_ch_y      : in  STD_LOGIC_VECTOR(2 downto 0);
            i_ch_cc     : in  STD_LOGIC_VECTOR(3 downto 0);
            i_ch_we     : in  std_logic;
            i_clk       : in  STD_LOGIC;
            i_flip_y    : in  STD_LOGIC;
            o_colorCode : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    -- Signals to connect to DUT
    signal s_i_x       : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    signal s_i_y       : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    signal s_i_tile_id : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
    signal s_i_ch_x    : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    signal s_i_ch_y    : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    signal s_i_ch_cc   : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal s_i_ch_we   : std_logic := '0';
    signal s_i_clk     : STD_LOGIC := '0';
    signal s_i_flip_y  : STD_LOGIC := '0';
    signal s_o_colorCode : STD_LOGIC_VECTOR(3 downto 0);

    constant clk_period : time := 10 ns;

begin
    -- Instantiate DUT
    uut: TuileBackBuff2
        port map (
            i_x => s_i_x,
            i_y => s_i_y,
            i_tile_id => s_i_tile_id,
            i_ch_x => s_i_ch_x,
            i_ch_y => s_i_ch_y,
            i_ch_cc => s_i_ch_cc,
            i_ch_we => s_i_ch_we,
            i_clk => s_i_clk,
            i_flip_y => s_i_flip_y,
            o_colorCode => s_o_colorCode
        );

    -- Clock generation process
    clk_process : process
    begin
        while true loop
            s_i_clk <= '0';
            wait for clk_period / 2;
            s_i_clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Initial values
        s_i_x <= "000";
        s_i_y <= "000";
        s_i_tile_id <= "00000";  -- tile 0

        wait for 20 ns;
        s_i_x <= "111";
        s_i_y <= "111";
        s_i_tile_id <= "00100";
        wait for 20 ns;

        -- End simulation
        wait;
    end process;

end Behavioral;
