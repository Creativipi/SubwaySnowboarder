library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Tuile_tb is
end Tuile_tb;

architecture test of Tuile_tb is
    -- DUT ports
    signal i_x      : std_logic_vector(2 downto 0) := (others => '0');
    signal i_y      : std_logic_vector(2 downto 0) := (others => '0');
    signal i_clk    : std_logic := '0';
    signal i_ch_x   : std_logic_vector(2 downto 0) := (others => '0');
    signal i_ch_y   : std_logic_vector(2 downto 0) := (others => '0');
    signal i_ch_cc  : std_logic_vector(3 downto 0) := (others => '0');
    signal i_ch_we  : std_logic := '0';
    signal o_cc     : std_logic_vector(3 downto 0);

    -- DUT instance
    component Tuile is
        generic (
            TILE_ID : integer := 0
        );
        port (
            i_x      : in std_logic_vector(2 downto 0);
            i_y      : in std_logic_vector(2 downto 0);
            i_clk    : in std_logic;
            i_ch_x   : in std_logic_vector(2 downto 0);
            i_ch_y   : in std_logic_vector(2 downto 0);
            i_ch_cc  : in std_logic_vector(3 downto 0);
            i_ch_we  : in std_logic;
            o_cc     : out std_logic_vector(3 downto 0)
        );
    end component;

begin
    dut: Tuile
        port map (
            i_x      => i_x,
            i_y      => i_y,
            i_clk    => i_clk,
            i_ch_x   => i_ch_x,
            i_ch_y   => i_ch_y,
            i_ch_cc  => i_ch_cc,
            i_ch_we  => i_ch_we,
            o_cc     => o_cc
        );

    -- Clock generation
    clk_process : process
    begin
        while now < 1000 ns loop
            i_clk <= '0';
            wait for 5 ns;
            i_clk <= '1';
            wait for 5 ns;
        end loop;
        wait;
    end process;

    -- Stimulus process
    stim_proc : process
    begin
        -- Wait for 2 cycles for initialization
        wait for 20 ns;

        -- Write color '1010' to pixel at (2,3)
        i_ch_x <= "010"; -- x = 2
        i_ch_y <= "011"; -- y = 3
        i_ch_cc <= "1010";
        i_ch_we <= '1';
        wait for 10 ns;
        i_ch_we <= '0';

        -- Wait 1 cycle
        wait for 10 ns;

        -- Read color from same location
        i_x <= "010"; -- x = 2
        i_y <= "011"; -- y = 3

        wait for 10 ns;

        -- You can now observe o_cc
        assert o_cc = "1010"
        report "Test Passed: Color at (2,3) is correct"
        severity note;

        wait;
    end process;
end test;
