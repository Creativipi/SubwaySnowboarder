----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/26/2025 11:59:40 AM
-- Design Name: 
-- Module Name: backMgmt_tb - Behavioral
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

entity backMgmt_tb is
--  Port ( );
end backMgmt_tb;

architecture Behavioral of backMgmt_tb is
    component BackMgmt
        Port (
            i_view_x     : in  STD_LOGIC_VECTOR (9 downto 0);
            i_view_y     : in  STD_LOGIC_VECTOR (9 downto 0);
            i_col        : in  STD_LOGIC_VECTOR (6 downto 0);
            i_row        : in  STD_LOGIC_VECTOR (6 downto 0);
            i_tile_id    : in  STD_LOGIC_VECTOR (4 downto 0);
            i_flip_y     : in  STD_LOGIC;
            i_ch_tile_id : in  STD_LOGIC;
            i_ch_flip    : in  STD_LOGIC;
            i_clk        : in  STD_LOGIC;

            o_tile_id    : out STD_LOGIC_VECTOR (4 downto 0);
            o_flip_y     : out STD_LOGIC;
            o_pix_x      : out STD_LOGIC_VECTOR (2 downto 0);
            o_pix_y      : out STD_LOGIC_VECTOR (2 downto 0)
        );
    end component;
    
    signal i_view_x_sim     : STD_LOGIC_VECTOR(9 downto 0) := (others => '0');
    signal i_view_y_sim     : STD_LOGIC_VECTOR(9 downto 0) := (others => '0');
    signal i_col_sim        : STD_LOGIC_VECTOR(6 downto 0) := (others => '0');
    signal i_row_sim        : STD_LOGIC_VECTOR(6 downto 0) := (others => '0');
    signal i_tile_id_sim    : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
    signal i_flip_y_sim     : STD_LOGIC := '0';
    signal i_ch_tile_id_sim : STD_LOGIC := '0';
    signal i_ch_flip_sim    : STD_LOGIC := '0';
    signal i_clk_sim        : STD_LOGIC := '0';

    signal o_tile_id_sim : STD_LOGIC_VECTOR(4 downto 0);
    signal o_flip_y_sim  : STD_LOGIC;
    signal o_pix_x_sim   : STD_LOGIC_VECTOR(2 downto 0);
    signal o_pix_y_sim   : STD_LOGIC_VECTOR(2 downto 0);
begin
    uut: BackMgmt
        Port Map (
            i_view_x     => i_view_x_sim,
            i_view_y     => i_view_y_sim,
            i_col        => i_col_sim,
            i_row        => i_row_sim,
            i_tile_id    => i_tile_id_sim,
            i_flip_y     => i_flip_y_sim,
            i_ch_tile_id => i_ch_tile_id_sim,
            i_ch_flip    => i_ch_flip_sim,
            i_clk        => i_clk_sim,
            o_tile_id    => o_tile_id_sim,
            o_flip_y     => o_flip_y_sim,
            o_pix_x      => o_pix_x_sim,
            o_pix_y      => o_pix_y_sim
        );
        
    clk_process : process
    begin
        i_clk_sim <= '0';
        wait for 10 ns;
        i_clk_sim <= '1';
        wait for 10 ns;
    end process;
    
    stimulus : process
    begin
        wait for 20 ns;
        -- Enable write
        i_ch_tile_id_sim <= '1';
        i_ch_flip_sim <= '1';
        -- Change tile 0, 2
        i_col_sim <= "0000000";
        i_row_sim <= "0000010";
        i_tile_id_sim <= "11000";
        i_flip_y_sim <= '1';
        wait for 20 ns;
        -- Change tile 3, 2
        i_col_sim <= "0000011";
        i_row_sim <= "0000010";
        i_tile_id_sim <= "11111";
        i_flip_y_sim <= '0';
        wait for 20 ns;
        -- Disable write 
        i_ch_tile_id_sim <= '0';
        i_ch_flip_sim <= '0';
        -- View pixel (4, 4) of tile 0, 2
        i_view_x_sim <= "0000000100";
        i_view_y_sim <= "0000010100";
        wait for 20 ns;
        -- View pixel (1, 1) of tile 3, 2
        i_view_x_sim <= "0000011001";
        i_view_y_sim <= "0000010001";
        wait;
    end process;

end Behavioral;
