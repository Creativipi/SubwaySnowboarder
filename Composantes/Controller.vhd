----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.06.2025 00:00:57
-- Design Name: 
-- Module Name: Controller - Behavioral
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

entity Controller is
    Port ( i_instruction : in STD_LOGIC_VECTOR (31 downto 0);
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
           --ActorMgmt
           o_AM_act_id : out STD_LOGIC_VECTOR (2 downto 0);
           o_AM_newpos_x : out STD_LOGIC_VECTOR (9 downto 0);
           o_AM_newpos_y : out STD_LOGIC_VECTOR (9 downto 0);
           o_AM_tile_id : out STD_LOGIC_VECTOR (3 downto 0);
           o_AM_flip_x : out STD_LOGIC;
           o_AM_flip_y : out STD_LOGIC;
           o_AM_ch_setpos : out STD_LOGIC;
           o_AM_ch_movepos : out STD_LOGIC;
           o_AM_ch_tile_id : out STD_LOGIC;
           o_AM_ch_flip_x: out STD_LOGIC;
           o_AM_ch_flip_y : out STD_LOGIC;
           --MuxBackActor
           o_MBA_act_en : out STD_LOGIC;
           --ColorConvertor
           o_CC_color_id : out STD_LOGIC_VECTOR (3 downto 0); --Peut-�tre mettre un vrai syst�me de palette
           o_CC_new_RBG : out STD_LOGIC_VECTOR (23 downto 0);
           o_CC_ch_color : out STD_LOGIC
           );
           
           
end Controller;

architecture Behavioral of Controller is

    signal current_instruction : STD_LOGIC_VECTOR(31 downto 0);
    signal opcode : STD_LOGIC_VECTOR(3 downto 0);
    -- "0000" => MoveView
    -- "0001" => SetView
    -- "0010" => MoveActPos
    -- "0011" => SetActPos
    -- "0100" => SetActTile
    -- "0101" => SetBackTile
begin

process(i_clk)
    begin
        if rising_edge(i_clk) then
            current_instruction <= i_instruction;
        end if;
    end process;
    
    opcode <= current_instruction(31 downto 28);      -- ActorMgmt control TO VERIFY IN SECOND ITERATION

    -- Viewport
    o_ch_moveoffset <= '1' when opcode = "0000" else '0'; -- MoveView
    o_ch_setoffset  <= '1' when opcode = "0001" else '0'; -- SetView
    o_x_newoffset   <= current_instruction(23 downto 14) when opcode = "0000" or opcode = "0001" else (others => '0');
    o_y_newoffset   <= current_instruction(13 downto 4)  when opcode = "0000" or opcode = "0001" else (others => '0');

    -- BackMgmt
    o_BM_tile_id    <= current_instruction(27 downto 23) when opcode = "0101" else (others => '0');
    o_BM_ch_tile_id <= current_instruction(22) when opcode = "0101" else '0';
    o_BM_row        <= current_instruction(21 downto 15) when opcode = "0101" else (others => '0');
    o_BM_col        <= current_instruction(14 downto 8)  when opcode = "0101" else (others => '0');
    o_BM_ch_flip_y  <= current_instruction(1) when opcode = "0101" else '0';
    o_BM_flip_y     <= current_instruction(0) when opcode = "0101" else '0';

    -- ActorMgmt
    o_AM_act_id     <= current_instruction(27 downto 25) when opcode = "0010" or opcode = "0011" or opcode = "0100" else (others => '0');
    o_AM_ch_movepos <= current_instruction(24) when opcode = "0010" else '0';
    o_AM_ch_setpos  <= current_instruction(24) when opcode = "0011" else '0';
    o_AM_ch_tile_id <= current_instruction(24) when opcode = "0100" else '0';
    o_AM_newpos_x   <= current_instruction(23 downto 14) when opcode = "0010" or opcode = "0011" else (others => '0');
    o_AM_newpos_y   <= current_instruction(13 downto 4)  when opcode = "0010" or opcode = "0011" else (others => '0');
    o_AM_tile_id    <= current_instruction(23 downto 20) when opcode = "0100" else (others => '0');
    o_AM_ch_flip_x  <= current_instruction(3) when opcode = "0100" or opcode = "0011" or opcode = "0010" else '0';
    o_AM_ch_flip_y  <= current_instruction(1) when opcode = "0100" or opcode = "0011" or opcode = "0010" else '0';
    o_AM_flip_x     <= current_instruction(2) when opcode = "0100" or opcode = "0011" or opcode = "0010" else '0';
    o_AM_flip_y     <= current_instruction(0) when opcode = "0100" or opcode = "0011" or opcode = "0010" else '0';
    -- Others
    --o_MBA_act_en    <= '0'; -- if not yet used
    --o_CC_color_id   <= (others => '0');
    --o_CC_new_RBG    <= (others => '0');
    --o_CC_ch_color   <= '0';

end Behavioral;
