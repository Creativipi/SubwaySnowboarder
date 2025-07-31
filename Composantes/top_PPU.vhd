----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.06.2025 00:03:12
-- Design Name: 
-- Module Name: top_PPU - Behavioral
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

entity top_PPU is
    Port ( i_command : in STD_LOGIC_VECTOR (31 downto 0);
           i_x : in STD_LOGIC_VECTOR (11 downto 0);
           i_y : in STD_LOGIC_VECTOR (11 downto 0);
           i_reset : in STD_LOGIC;
           i_clk : in STD_LOGIC;
           
           o_dataPixel : out STD_LOGIC_VECTOR (23 downto 0);
           o_dataValid : out STD_LOGIC);
end top_PPU;

architecture Behavioral of top_PPU is

component Controller is
  port (
    i_instruction : in STD_LOGIC_VECTOR (31 downto 0);
    i_clk : in STD_LOGIC;
    --Viewport
    o_ch_setoffset : out STD_LOGIC;
    o_ch_moveoffset : out STD_LOGIC;
    o_x_newoffset : out STD_LOGIC_VECTOR (9 downto 0);
    o_y_newoffset : out STD_LOGIC_VECTOR (9 downto 0);
    --BackMgmt
    o_BM_col : out STD_LOGIC_VECTOR (6 downto 0);
    o_BM_row : out STD_LOGIC_VECTOR (6 downto 0);
    o_BM_tile_id : out STD_LOGIC_VECTOR (4 downto 0);
    o_BM_flip_y : out STD_LOGIC;
    o_BM_ch_tile_id : out STD_LOGIC;
    o_BM_ch_flip_y : out STD_LOGIC;
    o_BM_ch_tileBack : out STD_LOGIC;
    
    o_BM_tile_write : out STD_LOGIC_VECTOR (4 downto 0);
    o_BM_write_enable_pix : out STD_LOGIC;
    o_BM_new_cc : out STD_LOGIC_VECTOR (3 downto 0);
    o_BM_pix_x : out STD_LOGIC_VECTOR (2 downto 0);
    o_BM_pix_y : out STD_LOGIC_VECTOR (2 downto 0);
    --ActorMgmt
    o_AM_newpos_x : out STD_LOGIC_VECTOR (9 downto 0);
    o_AM_newpos_y : out STD_LOGIC_VECTOR (9 downto 0);
    o_AM_act_id : out STD_LOGIC_VECTOR (2 downto 0);
    o_AM_tile_id : out STD_LOGIC_VECTOR (3 downto 0);

    o_AM_flip_x : out STD_LOGIC;
    o_AM_flip_y : out STD_LOGIC;
    o_AM_ch_setpos : out STD_LOGIC;
    o_AM_ch_movepos : out STD_LOGIC;
    o_AM_ch_tile_id : out STD_LOGIC;
    o_AM_ch_flip_x : out STD_LOGIC;
    o_AM_ch_flip_y : out STD_LOGIC;
    o_AM_ch_cc : out std_logic_vector (3 downto 0);
    o_AM_ch_x : out std_logic_vector (3 downto 0);
    o_AM_ch_y : out std_logic_vector (3 downto 0);
    o_AM_ch_we : out std_logic;
    o_AM_tile_write : out std_logic_vector (3 downto 0);
    --MuxBackActor
    o_MBA_act_en : out STD_LOGIC;
    --ColorConvertor
    o_CC_color_id : out STD_LOGIC_VECTOR (3 downto 0); --Peut-?tre mettre un vrai syst?me de palette
    o_CC_new_RBG : out STD_LOGIC_VECTOR (23 downto 0);
    o_CC_ch_color : out STD_LOGIC
    
  );
end component;

component Viewport is
  port (
    i_x : in STD_LOGIC_VECTOR (9 downto 0); --X en entr?e
    i_y : in STD_LOGIC_VECTOR (8 downto 0); --Y en entr?e
    i_ch_setoffset : in STD_LOGIC; --Est-ce que l'on veut d?finir un offset?
    i_ch_moveoffset : in STD_LOGIC; --Est-ce que l'on veut d?caler l'offset?
    i_x_newoffset : in STD_LOGIC_VECTOR (9 downto 0); --Nouvelle position x
    i_y_newoffset : in STD_LOGIC_VECTOR (9 downto 0); --Nouvelle position y
    i_clk : in STD_LOGIC;
    o_x_offseted : out STD_LOGIC_VECTOR (9 downto 0); --X en sortie, d?cal?
    o_y_offseted : out STD_LOGIC_VECTOR (9 downto 0) --Y en sortie, d?cal?
  );
end component;

component TileRenderer is
Port (     i_view_x : in STD_LOGIC_VECTOR (9 downto 0); -- position x du pixel ? voir
           i_view_y : in STD_LOGIC_VECTOR (9 downto 0); -- position y du pixel ? voir
           
           i_col : in STD_LOGIC_VECTOR (6 downto 0); -- prochaine tuile ? changer
           i_row : in STD_LOGIC_VECTOR (6 downto 0); -- prochaine tuile ? changer
           i_tile_id : in STD_LOGIC_VECTOR (4 downto 0); -- tuile qui change
           i_flip_y : in STD_LOGIC; -- valeur du flip
           i_ch_tile_id : in STD_LOGIC; -- change la tuile?
           i_ch_flip_y : in STD_LOGIC; -- change le flip?
           i_clk : in STD_LOGIC; -- la clock
           i_ch_x : in std_logic_vector( 2 downto 0);
           i_ch_y : in std_logic_vector( 2 downto 0);
           i_ch_cc : in std_logic_vector (3 downto 0);
           i_ch_we : in std_logic;
           i_ch_we_tileBack : in std_logic;
           i_tile_id_write : in STD_LOGIC_VECTOR (4 downto 0);
           
           -- Info du pixel qu'on regarde
           o_colorCode : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component TileRendererActor is
Port (     i_view_x : in STD_LOGIC_VECTOR (9 downto 0);
           i_view_y : in STD_LOGIC_VECTOR (9 downto 0);
           i_act_id : in STD_LOGIC_VECTOR (2 downto 0);
           i_newpos_x : in STD_LOGIC_VECTOR (9 downto 0);
           i_newpos_y : in STD_LOGIC_VECTOR (9 downto 0);
           i_tile_id : in STD_LOGIC_VECTOR (3 downto 0);
           i_flip_x : in STD_LOGIC;
           i_flip_y : in STD_LOGIC;
           i_ch_setpos : in STD_LOGIC;
           i_ch_movepos : in STD_LOGIC;
           i_ch_tile_id : in STD_LOGIC;
           i_ch_flipX : in STD_LOGIC;
           i_ch_flipY : in STD_LOGIC;
           i_ch_x : in std_logic_vector(3 downto 0);
           i_ch_y : in std_logic_vector(3 downto 0);
           i_ch_cc : in std_logic_vector (3 downto 0);
           i_ch_we : in std_logic;
           i_clk : in STD_LOGIC;
           --o_flip_x : out STD_LOGIC;
           --o_flip_y : out STD_LOGIC;
           --o_pix_x : out STD_LOGIC_VECTOR (3 downto 0);
           --o_pix_y : out STD_LOGIC_VECTOR (3 downto 0);
           
           i_tile_id_write : in std_logic_vector (3 downto 0);
           o_tile_id : out STD_LOGIC_VECTOR (3 downto 0);
           o_is_actor_present : out std_logic;
           o_colorCode : out STD_LOGIC_VECTOR (3 downto 0));
end component;


component MuxBackActor is
  port (
    i_back_color_code : in STD_LOGIC_VECTOR (3 downto 0);
    i_act_color_code : in STD_LOGIC_VECTOR (3 downto 0);
    i_act_en : in STD_LOGIC;
    i_is_actor_present : in std_logic;
    o_color_code : out STD_LOGIC_VECTOR (3 downto 0)
  );
end component;

component ColorConvertor is
  port (
    i_color_code : in STD_LOGIC_VECTOR (3 downto 0);
    i_color_id : in STD_LOGIC_VECTOR (3 downto 0);
    i_new_RBG : in STD_LOGIC_VECTOR (23 downto 0);
    i_ch_color : in STD_LOGIC;
    i_clk : in STD_LOGIC;
    o_RBG : out STD_LOGIC_VECTOR (23 downto 0)
  );
end component;

    --Sorties Controller
    --Viewport
    signal Cont_ch_setoffset : STD_LOGIC;
    signal Cont_ch_moveoffset : STD_LOGIC;
    signal Cont_x_newoffset : STD_LOGIC_VECTOR (9 downto 0);
    signal Cont_y_newoffset : STD_LOGIC_VECTOR (9 downto 0);
    --BackMgmt
    signal Cont_BM_col : STD_LOGIC_VECTOR (6 downto 0);
    signal Cont_BM_row : STD_LOGIC_VECTOR (6 downto 0);
    signal Cont_BM_tile_id : STD_LOGIC_VECTOR (4 downto 0);
    signal Cont_BM_flip_y : STD_LOGIC;
    signal Cont_BM_ch_tile_id : STD_LOGIC;
    signal Cont_BM_ch_flip : STD_LOGIC;
    signal Cont_BM_ch_tileBack : std_logic;
    
    signal CONT_BM_tile_write : STD_LOGIC_VECTOR (4 downto 0);
    signal CONT_BM_write_enable_pix : STD_LOGIC;
    signal CONT_BM_new_cc : STD_LOGIC_VECTOR (3 downto 0);
    signal CONT_BM_new_pix_x : STD_LOGIC_VECTOR (2 downto 0);
    signal CONT_BM_new_pix_y : STD_LOGIC_VECTOR (2 downto 0);
    --ActorMgmt
    signal Cont_AM_act_id : STD_LOGIC_VECTOR (2 downto 0);
    signal Cont_AM_newpos_x : STD_LOGIC_VECTOR (9 downto 0);
    signal Cont_AM_newpos_y : STD_LOGIC_VECTOR (9 downto 0);
    signal Cont_AM_tile_id : STD_LOGIC_VECTOR (3 downto 0);
    signal Cont_AM_flip_x : STD_LOGIC;
    signal Cont_AM_flip_y : STD_LOGIC;
    signal Cont_AM_ch_setpos : STD_LOGIC;
    signal Cont_AM_ch_movepos : STD_LOGIC;
    signal Cont_AM_ch_tile_id : STD_LOGIC;
    signal Cont_AM_ch_flip_X : STD_LOGIC;
    signal Cont_AM_ch_flip_Y : STD_LOGIC;
    signal CONT_AM_ch_x : std_logic_vector (3 downto 0);
    signal CONT_AM_ch_y : std_logic_vector (3 downto 0);
    signal CONT_AM_ch_cc : std_logic_vector (3 downto 0);
    signal CONT_AM_ch_we : std_logic;
    signal CONT_AM_tile_id_write : std_logic_vector (3 downto 0);
    -- TileRenderActor Inputs
    signal TRA_NewPosX : STD_LOGIC_VECTOR (9 downto 0);
    signal TRA_NewPosY : STD_LOGIC_VECTOR (9 downto 0);
    signal TRA_act_id : std_logic_vector (2 downto 0);
    signal TRA_i_tile_id_write : std_logic_vector (3 downto 0);
    
    --MuxBackActor
    signal Cont_MBA_act_en : STD_LOGIC;
    --ColorConvertor
    signal Cont_CC_color_id : STD_LOGIC_VECTOR (3 downto 0); --Peut-?tre mettre un vrai syst?me de palette
    signal Cont_CC_new_RBG : STD_LOGIC_VECTOR (23 downto 0);
    signal Cont_CC_ch_color : STD_LOGIC;
    
    --Sorties TestPatternGenerator
    signal TPG_rstn : std_logic;
    signal TPG_axis_tuser : std_logic; -- start of frame
    signal TPG_axis_tlast : std_logic; -- end of frame
    signal TPG_axis_tvalid : std_logic; -- outputting valid data
    signal TPG_x : std_logic_vector (9 downto 0);
    signal TPG_y : std_logic_vector (8 downto 0);
    signal TPG_axis_tready : std_logic; -- input (1 when you are ready to render, 0 to stall the render)

    --Sorties Viewport
    signal View_x : std_logic_vector(9 downto 0);
    signal View_y : std_logic_vector(9 downto 0);
    
    --Sorties BackMgmt
    signal BM_tile_id : std_logic_vector(4 downto 0);
    signal BM_flip_y : std_logic;
    signal BM_pix_x : std_logic_vector(2 downto 0);
    signal BM_pix_y : std_logic_vector(2 downto 0);
    
    
    
    
    --Sortie TuileBufBack
    signal TBB_color_code : std_logic_vector(3 downto 0);
    
    --Sorties ActorMgmt
    signal AM_tile_id : STD_LOGIC_VECTOR (3 downto 0);
    signal AM_flip_x : STD_LOGIC;
    signal AM_flip_y : STD_LOGIC;
    signal AM_pix_x : STD_LOGIC_VECTOR (3 downto 0);
    signal AM_pix_y : STD_LOGIC_VECTOR (3 downto 0);
    signal AM_is_actor_present : STD_LOGIC;

    
    --Sortie TuileBufActor
    signal TBA_color_code : std_logic_vector(3 downto 0);
    
    --Sortie MuxBackAct
    signal MBA_color_code : std_logic_vector(3 downto 0);
    
    --Sortie ColorConvertor


begin

o_dataValid <= '1';

Controller_0: component Controller
     port map (
      i_instruction => i_command,
      i_clk => i_clk,
      --Viewport
      o_ch_setoffset => Cont_ch_setoffset,
      o_ch_moveoffset => Cont_ch_moveoffset,
      o_x_newoffset => Cont_x_newoffset,
      o_y_newoffset => Cont_y_newoffset,
      --BackMgmt
      o_BM_col => Cont_BM_col,
      o_BM_row => Cont_BM_row,
      o_BM_tile_id => Cont_BM_tile_id,
      o_BM_flip_y => Cont_BM_flip_y,
      o_BM_ch_tile_id => Cont_BM_ch_tile_id,
      o_BM_ch_flip_y => Cont_BM_ch_flip,
      o_BM_ch_tileBack => Cont_BM_ch_tileBack,
      
      o_BM_tile_write => CONT_BM_tile_write,
      o_BM_write_enable_pix => CONT_BM_write_enable_pix,
      o_BM_new_cc => CONT_BM_new_cc,
      o_BM_pix_x => CONT_BM_new_pix_x,
      o_BM_pix_y => CONT_BM_new_pix_y,
      --ActorMgmt
      o_AM_newpos_x => Cont_AM_newpos_x,
      o_AM_newpos_y => Cont_AM_newpos_y,
      o_AM_act_id => Cont_AM_act_id,
      o_AM_tile_id => Cont_AM_tile_id,
      o_AM_flip_x => Cont_AM_flip_x,
      o_AM_flip_y => Cont_AM_flip_y,
      o_AM_ch_setpos => Cont_AM_ch_setpos,
      o_AM_ch_movepos => Cont_AM_ch_movepos,
      o_AM_ch_tile_id => Cont_AM_ch_tile_id,
      o_AM_ch_flip_x => Cont_AM_ch_flip_X,
      o_AM_ch_flip_y => Cont_AM_ch_flip_Y,
      o_AM_ch_cc => Cont_AM_ch_cc,
      o_AM_ch_x => Cont_AM_ch_x,
      o_AM_ch_y => Cont_AM_ch_y,
      o_AM_ch_we => CONT_AM_ch_we,
      o_AM_tile_write => CONT_AM_tile_id_write,
      --MuxBackActor
      o_MBA_act_en => Cont_MBA_act_en,
      --ColorConvertor
      o_CC_color_id => Cont_CC_color_id, --Peut-?tre mettre un vrai syst?me de palette
      o_CC_new_RBG => Cont_CC_new_RBG,
      o_CC_ch_color => Cont_CC_ch_color
    );
    
Viewport_0: component Viewport
     port map (
      i_x => i_x(9 downto 0),
      i_y => i_y(8 downto 0),
      i_ch_setoffset => Cont_ch_setoffset,
      i_ch_moveoffset => Cont_ch_moveoffset,
      i_x_newoffset => Cont_x_newoffset,
      i_y_newoffset => Cont_y_newoffset,
      i_clk => i_clk,
      o_x_offseted => View_x,
      o_y_offseted => View_y
    );
    
TileRenderer_0 : component TileRenderer
port map(
      i_view_x => View_x,
      i_view_y => View_y,
      i_col => Cont_BM_col,
      i_row => Cont_BM_row,
      i_tile_id => Cont_BM_tile_id,
      i_flip_y => Cont_BM_flip_y,
      i_ch_tile_id => Cont_BM_ch_tile_id,
      i_ch_flip_y => Cont_BM_ch_flip,
      i_clk => i_clk,
      i_ch_we_tileBack => Cont_BM_ch_tileBack,
      i_tile_id_write => CONT_BM_tile_write,
      i_ch_x => CONT_BM_new_pix_x,
      i_ch_y => CONT_BM_new_pix_y,
      i_ch_cc => CONT_BM_new_cc,
      i_ch_we => CONT_BM_write_enable_pix,
      o_colorCode => TBB_color_code
);

TileRendererActor_0 : component TileRendererActor
port map(
           i_view_x => i_x (9 downto 0),
           i_view_y => i_y (9 downto 0),
           i_act_id => Cont_AM_act_id,
           i_tile_id => Cont_AM_tile_id,
           i_newpos_x => Cont_AM_newpos_x,
           i_newpos_y => Cont_AM_newpos_y,
           i_flip_x => Cont_AM_flip_x,
           i_flip_y => Cont_AM_flip_y,
           i_ch_setpos => Cont_AM_ch_setpos,
           i_ch_movepos => Cont_AM_ch_movepos,
           i_ch_tile_id => Cont_AM_ch_tile_id,
           i_ch_flipX => Cont_AM_ch_flip_X,
           i_ch_flipY => Cont_AM_ch_flip_Y,
           i_ch_x => CONT_AM_ch_x,
           i_ch_y => CONT_AM_ch_y,
           i_ch_we => CONT_AM_ch_we,
           i_ch_cc => CONT_AM_ch_cc,
           i_clk => i_clk,
           i_tile_id_write => CONT_AM_tile_id_write,
           o_tile_id => AM_tile_id,
           o_is_actor_present => AM_is_actor_present,
           o_colorCode => TBA_color_code
);
    
MuxBackActor_0 : component MuxBackActor
     port map(
      i_back_color_code => TBB_color_code,
      i_act_color_code => TBA_color_code,
      i_act_en => Cont_MBA_act_en,
      i_is_actor_present => AM_is_actor_present,
      o_color_code => MBA_color_code
    );
    
ColorConvertor_0 : component ColorConvertor
     port map(
      i_color_code => MBA_color_code,
      i_color_id => Cont_CC_color_id,
      i_new_RBG => Cont_CC_new_RBG,
      i_ch_color => Cont_CC_ch_color,
      i_clk => i_clk,
      o_RBG => o_dataPixel
    );

end Behavioral;
