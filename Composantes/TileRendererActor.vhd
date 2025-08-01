----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/13/2025 12:05:46 PM
-- Design Name: 
-- Module Name: TileRenderer - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
 
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
 
entity TileRendererActor is
Port (     i_view_x : in STD_LOGIC_VECTOR (9 downto 0);
           i_view_y : in STD_LOGIC_VECTOR (9 downto 0);
           i_act_id : in STD_LOGIC_VECTOR (2 downto 0);
           i_tile_id : in std_logic_vector (3 downto 0);
           i_newpos_x : in STD_LOGIC_VECTOR (9 downto 0);
           i_newpos_y : in STD_LOGIC_VECTOR (9 downto 0);
           i_flip_x : in STD_LOGIC;
           i_flip_y : in STD_LOGIC;
           i_ch_setpos : in STD_LOGIC;
           i_ch_movepos : in STD_LOGIC;
           i_ch_tile_id : in STD_LOGIC;
           i_ch_flipX : in STD_LOGIC;
           i_ch_flipY : in STD_LOGIC;
           i_clk : in STD_LOGIC;
           i_ch_we : in std_logic;
           i_ch_x : in std_logic_vector(3 downto 0);
           i_ch_y : in std_logic_vector(3 downto 0);
           i_ch_cc : in std_logic_vector(3 downto 0);
           i_tile_id_write : in std_logic_vector (3 downto 0);
           o_tile_id : out STD_LOGIC_VECTOR (3 downto 0);
           o_is_actor_present : out std_logic;
           o_colorCode : out STD_LOGIC_VECTOR (3 downto 0));
end TileRendererActor;
 
architecture Behavioral of TileRendererActor is
    signal s_flip_x : std_logic;
    signal s_flip_y : std_logic;
    signal s_pix_x : std_logic_vector (3 downto 0);
    signal s_pix_y : std_logic_vector (3 downto 0);
    signal s_pix_x_flipped : std_logic_vector (3 downto 0);
    signal s_pix_y_flipped : std_logic_vector (3 downto 0);
    signal s_tile_id : std_logic_vector (3 downto 0);
begin
    actorMgmt_inst : entity work.ActorMgmt
        port map (
            i_view_x => i_view_x,
            i_view_y => i_view_y,
            i_act_id => i_act_id, 
            i_newpos_x => i_newpos_x,
            i_newpos_y => i_newpos_y,
            i_tile_id => i_tile_id,
            i_flip_x => i_flip_x,
            i_flip_y => i_flip_y,
            i_ch_setpos => i_ch_setpos,
            i_ch_tile_id => i_ch_tile_id,
            i_ch_flipX => i_ch_flipX,
            i_ch_flipY => i_ch_flipY,
            i_clk => i_clk,
            o_tile_id => s_tile_id, 
            o_flip_x => s_flip_x,
            o_flip_y => s_flip_y,
            o_pix_x => s_pix_x,
            o_pix_y => s_pix_y,
            o_is_actor_present => o_is_actor_present,
            i_ch_x => i_ch_x,
            i_ch_y => i_ch_y,
            i_ch_cc => i_ch_cc,
            i_ch_we => i_ch_we,
            i_tile_id_write => i_tile_id_write
        );
    s_pix_x_flipped <= std_logic_vector(to_unsigned(15 - to_integer(unsigned(s_pix_x)), 4))
                   when s_flip_x = '1'
                   else s_pix_x;
                   
    s_pix_y_flipped <= std_logic_vector(to_unsigned(15 - to_integer(unsigned(s_pix_y)), 4))
                   when s_flip_y = '1'
                   else s_pix_y;
    uut_tuileBuffActor : entity work.TuileBuffActor
    port map (
        i_x => s_pix_x_flipped,
        i_y => s_pix_y_flipped,
        i_tile_id => s_tile_id,
        i_ch_x => i_ch_x,
        i_ch_y => i_ch_y,
        i_ch_cc => i_ch_cc,
        i_ch_we => i_ch_we,
        i_clk => i_clk,
        i_tile_id_write => i_tile_id_write,
        o_colorCode => o_colorCode
    );
 
 
end Behavioral;