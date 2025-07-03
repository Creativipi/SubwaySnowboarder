----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/26/2025 02:18:20 PM
-- Design Name: 
-- Module Name: TuileBufBack_tb - Behavioral
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

entity TuileBufBack_tb is
--  Port ( );
end TuileBufBack_tb;

architecture Behavioral of TuileBufBack_tb is

    component TuileBufBack is
    port (
        i_tile_id : in STD_LOGIC_VECTOR (4 downto 0);
        i_flip_y : in STD_LOGIC;
        i_pix_x : in STD_LOGIC_VECTOR (2 downto 0);
        i_pix_y : in STD_LOGIC_VECTOR (2 downto 0);
        o_color_code : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;
    
    signal i_tile_id_sim : STD_LOGIC_VECTOR (4 downto 0);
    signal i_flip_y_sim : STD_LOGIC;
    signal i_pix_x_sim : STD_LOGIC_VECTOR (2 downto 0);
    signal i_pix_y_sim : STD_LOGIC_VECTOR (2 downto 0);
    signal o_color_code_sim : STD_LOGIC_VECTOR (3 downto 0);

begin

    TuileBufBack_0 : component TuileBufBack
    port map(
        i_tile_id => i_tile_id_sim,
        i_flip_y => i_flip_y_sim,
        i_pix_x => i_pix_x_sim,
        i_pix_y => i_pix_y_sim,
        o_color_code => o_color_code_sim
    );
    
    tb : process
    begin
        i_tile_id_sim <= "00000"; i_flip_y_sim <= '0'; i_pix_x_sim <= "000"; i_pix_y_sim <= "000";
        wait for 10 ns;
        i_tile_id_sim <= "00000"; i_flip_y_sim <= '1'; i_pix_x_sim <= "000"; i_pix_y_sim <= "000";
        wait for 10 ns;
        i_tile_id_sim <= "00000"; i_flip_y_sim <= '0'; i_pix_x_sim <= "001"; i_pix_y_sim <= "000";
        wait for 10 ns;
        i_tile_id_sim <= "00000"; i_flip_y_sim <= '1'; i_pix_x_sim <= "001"; i_pix_y_sim <= "000";
        wait for 10 ns;
        i_tile_id_sim <= "00000"; i_flip_y_sim <= '0'; i_pix_x_sim <= "000"; i_pix_y_sim <= "001";
        wait for 10 ns;
        i_tile_id_sim <= "00000"; i_flip_y_sim <= '1'; i_pix_x_sim <= "000"; i_pix_y_sim <= "001";
        wait for 10 ns;
        i_tile_id_sim <= "00000"; i_flip_y_sim <= '0'; i_pix_x_sim <= "001"; i_pix_y_sim <= "001";
        wait for 10 ns;
        i_tile_id_sim <= "00000"; i_flip_y_sim <= '1'; i_pix_x_sim <= "001"; i_pix_y_sim <= "001";
        wait for 10 ns;
        i_tile_id_sim <= "00000"; i_flip_y_sim <= '0'; i_pix_x_sim <= "111"; i_pix_y_sim <= "111";
        wait for 10 ns;
        i_tile_id_sim <= "00000"; i_flip_y_sim <= '1'; i_pix_x_sim <= "111"; i_pix_y_sim <= "111";
        wait for 10 ns;
        i_tile_id_sim <= "00001"; i_flip_y_sim <= '0'; i_pix_x_sim <= "000"; i_pix_y_sim <= "000";
        wait for 10 ns;
        i_tile_id_sim <= "00001"; i_flip_y_sim <= '1'; i_pix_x_sim <= "000"; i_pix_y_sim <= "000";
        wait for 10 ns;
        i_tile_id_sim <= "00001"; i_flip_y_sim <= '0'; i_pix_x_sim <= "001"; i_pix_y_sim <= "000";
        wait for 10 ns;
        i_tile_id_sim <= "00001"; i_flip_y_sim <= '1'; i_pix_x_sim <= "001"; i_pix_y_sim <= "000";
        wait for 10 ns;
        i_tile_id_sim <= "00001"; i_flip_y_sim <= '0'; i_pix_x_sim <= "000"; i_pix_y_sim <= "001";
        wait for 10 ns;
        i_tile_id_sim <= "00001"; i_flip_y_sim <= '1'; i_pix_x_sim <= "000"; i_pix_y_sim <= "001";
        wait for 10 ns;
        i_tile_id_sim <= "00001"; i_flip_y_sim <= '0'; i_pix_x_sim <= "001"; i_pix_y_sim <= "001";
        wait for 10 ns;
        i_tile_id_sim <= "00001"; i_flip_y_sim <= '1'; i_pix_x_sim <= "001"; i_pix_y_sim <= "001";
        wait for 10 ns;
        i_tile_id_sim <= "00001"; i_flip_y_sim <= '0'; i_pix_x_sim <= "111"; i_pix_y_sim <= "111";
        wait for 10 ns;
        i_tile_id_sim <= "00001"; i_flip_y_sim <= '1'; i_pix_x_sim <= "111"; i_pix_y_sim <= "111";
        wait for 10 ns;
        i_tile_id_sim <= "00010"; i_flip_y_sim <= '0'; i_pix_x_sim <= "000"; i_pix_y_sim <= "000";
        wait for 10 ns;
        i_tile_id_sim <= "00010"; i_flip_y_sim <= '1'; i_pix_x_sim <= "000"; i_pix_y_sim <= "000";
        wait for 10 ns;
        i_tile_id_sim <= "00010"; i_flip_y_sim <= '0'; i_pix_x_sim <= "001"; i_pix_y_sim <= "000";
        wait for 10 ns;
        i_tile_id_sim <= "00010"; i_flip_y_sim <= '1'; i_pix_x_sim <= "001"; i_pix_y_sim <= "000";
        wait for 10 ns;
        i_tile_id_sim <= "00010"; i_flip_y_sim <= '0'; i_pix_x_sim <= "000"; i_pix_y_sim <= "001";
        wait for 10 ns;
        i_tile_id_sim <= "00010"; i_flip_y_sim <= '1'; i_pix_x_sim <= "000"; i_pix_y_sim <= "001";
        wait for 10 ns;
        i_tile_id_sim <= "00010"; i_flip_y_sim <= '0'; i_pix_x_sim <= "001"; i_pix_y_sim <= "001";
        wait for 10 ns;
        i_tile_id_sim <= "00010"; i_flip_y_sim <= '1'; i_pix_x_sim <= "001"; i_pix_y_sim <= "001";
        wait for 10 ns;
        i_tile_id_sim <= "00010"; i_flip_y_sim <= '0'; i_pix_x_sim <= "111"; i_pix_y_sim <= "111";
        wait for 10 ns;
        i_tile_id_sim <= "00010"; i_flip_y_sim <= '1'; i_pix_x_sim <= "111"; i_pix_y_sim <= "111";
        wait for 10 ns;
    end process;
    
end Behavioral;
