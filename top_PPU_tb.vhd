library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity top_PPU_tb is
end top_PPU_tb;

architecture Behavioral of top_PPU_tb is

    signal FETCH : STD_LOGIC_VECTOR(31 downto 0);
    signal CLK   : STD_LOGIC := '0';
    signal HDMI  : STD_LOGIC_VECTOR(18 downto 0);

    component top_PPU is
        Port (
            FETCH : in STD_LOGIC_VECTOR (31 downto 0);
            CLK   : in STD_LOGIC;
            HDMI  : out STD_LOGIC_VECTOR (18 downto 0)
        );
    end component;

begin

    uut: top_PPU
        port map (
            FETCH => FETCH,
            CLK => CLK,
            HDMI => HDMI
        );

    -- Clock generation
    CLK_process :process
    begin
        CLK <= '0'; wait for 10 ns;
        CLK <= '1'; wait for 10 ns;
    end process;

    -- Stimulus
    stim_proc: process
    begin
        -- MoveView: opcode 0000, x = 3, y = 4
        FETCH <= "0000" & "0000000011" & "0000000100" & X"00";
        wait for 40 ns;
        
        -- SetView: opcode 0001, x = 5, y = 6
        FETCH <= "0001" & "0000000101" & "0000000110" & X"00";
        wait for 40 ns;
        
        -- MoveActPos: opcode 0010, act_id = 1, ch_movepos = 1, x = 10, y = 20, flip_x = 1, flip_y = 0
        --FETCH <= "0010" & "001" & '1' & "0000001010" & "0000010100" & '1' & '0' & "00";
        --wait for 40 ns;
        
        -- SetActPos: opcode 0011, act_id = 2, ch_setpos = 1, x = 30, y = 40, flip_x = 0, flip_y = 1
        --FETCH <= "0011" & "010" & '1' & "0000011110" & "0000101000" & '0' & '1' & "00";
        --wait for 40 ns;
        
        -- SetActTile: opcode 0100, act_id = 3, ch_tile = 1, tile_id = 5, flip_x = 1, flip_y = 1
        --FETCH <= "0100" & "011" & '1' & "0101" & '1' & '1' & "00000";
        --wait for 40 ns;
        
        -- SetBackTile: opcode 0101, tile_id = 10, ch_tile = 1, row = 3, col = 4, ch_flip = 1, flip_y = 1
        FETCH <= "0101" & "01010" & '1' & "0000011" & "0000100" & '1' & '1' & "000000";
        wait for 40 ns;

        wait;
    end process;

end Behavioral;
