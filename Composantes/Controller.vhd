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
-- Description: Fully registered version with stable output timing for FPGA
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Controller is
    Port (
        i_instruction : in  STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
        i_clk         : in  STD_LOGIC := '0';

        -- Viewport
        o_ch_setoffset  : out STD_LOGIC := '0';
        o_ch_moveoffset : out STD_LOGIC := '0';
        o_x_newoffset   : out STD_LOGIC_VECTOR (9 downto 0) := (others => '0');
        o_y_newoffset   : out STD_LOGIC_VECTOR (9 downto 0) := (others => '0');

        -- BackMgmt
        o_BM_col         : out STD_LOGIC_VECTOR (6 downto 0) := (others => '0');
        o_BM_row         : out STD_LOGIC_VECTOR (6 downto 0) := (others => '0');
        o_BM_tile_id     : out STD_LOGIC_VECTOR (4 downto 0) := (others => '0');
        o_BM_flip_y      : out STD_LOGIC := '0';
        o_BM_ch_tile_id  : out STD_LOGIC := '0';
        o_BM_ch_flip_y    : out STD_LOGIC := '0';
        o_BM_ch_tileBack : out STD_LOGIC := '0';
        
        o_BM_tile_write : out STD_LOGIC_VECTOR (4 downto 0) := "00000";
        o_BM_write_enable_pix : out STD_LOGIC := '0';
        o_BM_new_cc : out STD_LOGIC_VECTOR (3 downto 0) := "0000";
        o_BM_pix_x : out STD_LOGIC_VECTOR (2 downto 0) := "000";
        o_BM_pix_y : out STD_LOGIC_VECTOR (2 downto 0) := "000";

        -- ActorMgmt
        o_AM_act_id     : out STD_LOGIC_VECTOR (2 downto 0) := (others => '0');
        o_AM_newpos_x   : out STD_LOGIC_VECTOR (9 downto 0) := (others => '0');
        o_AM_newpos_y   : out STD_LOGIC_VECTOR (9 downto 0) := (others => '0');
        o_AM_tile_id    : out STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
        o_AM_flip_X     : out STD_LOGIC := '0';
        o_AM_flip_Y     : out STD_LOGIC := '0';
        o_AM_ch_setpos  : out STD_LOGIC := '0';
        o_AM_ch_movepos : out STD_LOGIC := '0';
        o_AM_ch_tile_id : out STD_LOGIC := '0';
        o_AM_ch_flip_x   : out STD_LOGIC := '0';
        o_AM_ch_flip_y  : out STD_LOGIC := '0';

        -- MuxBackActor
        o_MBA_act_en : out STD_LOGIC := '0';

        -- ColorConvertor
        o_CC_color_id : out STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
        o_CC_new_RBG  : out STD_LOGIC_VECTOR (23 downto 0) := (others => '0');
        o_CC_ch_color : out STD_LOGIC := '0'
    );
end Controller;

architecture Behavioral of Controller is

    signal current_instruction : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal r_BM_ch_tileBack    : STD_LOGIC := '0';

begin

    process(i_clk)
        variable opcode : STD_LOGIC_VECTOR(3 downto 0);
    begin
        if rising_edge(i_clk) then
            -- Register input instruction
            o_ch_setoffset  <= '0';
            o_ch_moveoffset <= '0';
            o_x_newoffset   <= (others => '0');
            o_y_newoffset   <= (others => '0');
    
            o_BM_col         <= (others => '0');
            o_BM_row         <= (others => '0');
            o_BM_tile_id     <= (others => '0');
            o_BM_flip_y      <= '0';
            o_BM_ch_tile_id  <= '0';
            o_BM_ch_flip_y   <= '0';
            o_BM_ch_tileBack <= '0';
            
            o_BM_tile_write <= "00000";
            o_BM_write_enable_pix <= '0';
            o_BM_new_cc <= "0000";
            o_BM_pix_x <= "000";
            o_BM_pix_y <= "000";
    
            o_AM_act_id     <= (others => '0');
            o_AM_newpos_x   <= (others => '0');
            o_AM_newpos_y   <= (others => '0');
            o_AM_tile_id    <= (others => '0');
            o_AM_flip_X     <= '0';
            o_AM_flip_Y     <= '0';
            o_AM_ch_setpos  <= '0';
            o_AM_ch_movepos <= '0';
            o_AM_ch_tile_id <= '0';
            o_AM_ch_flip_x   <= '0';
            o_AM_ch_flip_y  <= '0';
    
            o_MBA_act_en <= '0';
    
            o_CC_color_id <= (others => '0');
            o_CC_new_RBG  <= (others => '0');
            o_CC_ch_color <= '0';
            current_instruction <= i_instruction;
            opcode := i_instruction(31 downto 28);  -- decode from *current* instruction

            -- Viewport control
            if opcode = "0000" then  -- MoveView
                o_ch_moveoffset <= '1';
                o_x_newoffset   <= i_instruction(23 downto 14);
                o_y_newoffset   <= i_instruction(13 downto 4);
            elsif opcode = "0001" then  -- SetView
                o_ch_setoffset  <= '1';
                o_x_newoffset   <= i_instruction(23 downto 14);
                o_y_newoffset   <= i_instruction(13 downto 4);
            end if;

            -- BackMgmt control
            if opcode = "0101" then  -- SetBackTile
                o_BM_tile_id     <= i_instruction(27 downto 23);
                o_BM_ch_tile_id  <= i_instruction(22);
                o_BM_col         <= i_instruction(21 downto 15);
                o_BM_row         <= i_instruction(14 downto 8);
                o_BM_ch_flip_y    <= i_instruction(1);
                o_BM_flip_y      <= i_instruction(0);
                o_BM_ch_tileBack <= '1';
            end if;
            
            if opcode = "0110" then
                o_BM_tile_write <= i_instruction(27 downto 23);
                o_BM_write_enable_pix <= '1';
                o_BM_new_cc <= i_instruction(22 downto 19);
                o_BM_pix_x <= i_instruction(18 downto 16);
                o_BM_pix_y <= i_instruction(15 downto 13);
            end if;

            -- ActorMgmt
            if opcode = "0010" or opcode = "0011" or opcode = "0100" then
                o_AM_act_id <= i_instruction(27 downto 25);
            end if;

            if opcode = "0010" then  -- MoveActPos
                o_AM_ch_movepos <= i_instruction(24);
                o_AM_newpos_x   <= i_instruction(23 downto 14);
                o_AM_newpos_y   <= i_instruction(13 downto 4);
            elsif opcode = "0011" then  -- SetActPos
                o_AM_ch_setpos  <= i_instruction(24);
                o_AM_newpos_x   <= i_instruction(23 downto 14);
                o_AM_newpos_y   <= i_instruction(13 downto 4);
            elsif opcode = "0100" then  -- SetActTile
                o_AM_ch_tile_id <= i_instruction(24);
                o_AM_tile_id    <= i_instruction(23 downto 20);
            end if;

            if opcode = "0100" or opcode = "0011" or opcode = "0010" then
                o_AM_ch_flip_x <= i_instruction(3);
                o_AM_ch_flip_y <= i_instruction(2);
                o_AM_flip_X   <= i_instruction(1);
                o_AM_flip_Y   <= i_instruction(0);
            end if;
        end if;
    end process;

end Behavioral;
