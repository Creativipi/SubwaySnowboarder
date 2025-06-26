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
        -- MoveView: opcode = "0000", x = 3, y = 4
        -- x = 3 => "0000000011" into bits [23:14]
        -- y = 4 => "0000000100" into bits [13:4]
        FETCH <= "0000" & "0000" & "0000000011" & "0000000100" & "0000";
        wait for 40 ns;
        
        -- SetView: opcode = "0001", x = 5, y = 6
        -- x = 5 => "0000000101" into bits [23:14]
        -- y = 6 => "0000000110" into bits [13:4]
        FETCH <= "0001" & "0000" & "0000000101" & "0000000110" & "0000";
        wait for 40 ns;
        
        -- MoveActPos: opcode = "0010", act_id = 3, ch_movepos = 1, x = 10, y = 20, ch_flipX=1, ch_flipY=0, flipX=0, flipY=0
        -- act_id[27:25] = "011", ch = 1 [24], x = 10 [23:14], y = 20 [13:4], ch_flipX = 1 [3], ch_flipY = 0 [2], flipX = 0 [1], flipY = 0 [0]
        FETCH <= "0010" & "011" & '1' & "0000001010" & "0000010100" & '0' & '1' & '0' & '0';
        wait for 40 ns;
        
        -- SetActPos: opcode = "0011", act_id = 2, ch_setpos = 1, x = 30, y = 40, ch_flipX=1, ch_flipY=0, flipX=1, flipY=0
        FETCH <= "0011" & "010" & '1' & "0000011110" & "0000101000" & '1' & '0' & '1' & '0';
        wait for 40 ns;
        
        -- SetActTile: opcode = "0100", act_id = 1, ch_tile_id = 1, tile_id = 7, ch_flipX=1, ch_flipY=1, flipX=1, flipY=1
        FETCH <= "0100" & "001" & '1' & "0111" & "0000000000000000" & '1' & '1' & '1' & '1';
        wait for 40 ns;
        
        -- SetBackTile: opcode = "0101", tile_id = 17, ch_tile = 1, row = 12, col = 22, ch_flipY = 1, flip_y = 1
        -- tile_id = "10001" [27:23], ch_tile_id = 1 [22], row = 0001100 [21:15], col = 0010110 [14:8], ch_flipY = 1 [1], flip_y = 1 [0]
        FETCH <= "0101" & "10001" & '1' & "0001100" & "0010110" & "000000" & '1' & '1';
        wait for 40 ns;
                
        wait;
    end process;

end Behavioral;
