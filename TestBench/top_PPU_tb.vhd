library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

entity top_PPU_tb is
end top_PPU_tb;

architecture Behavioral of top_PPU_tb is

    signal i_command_sim : STD_LOGIC_VECTOR(31 downto 0);
    signal i_x_sim : STD_LOGIC_VECTOR(11 downto 0);
    signal i_y_sim : STD_LOGIC_VECTOR(11 downto 0);
    signal i_reset_sim : STD_LOGIC;
    signal i_clk_sim   : STD_LOGIC := '0';
    signal o_dataPixel_sim  : STD_LOGIC_VECTOR(23 downto 0);
    signal o_dataValid_sim  : STD_LOGIC;

    component top_PPU is
        Port (
           i_command : in STD_LOGIC_VECTOR (31 downto 0);
           i_x : in STD_LOGIC_VECTOR (11 downto 0);
           i_y : in STD_LOGIC_VECTOR (11 downto 0);
           i_reset : in STD_LOGIC;
           i_clk : in STD_LOGIC;
           
           o_dataPixel : out STD_LOGIC_VECTOR (23 downto 0);
           o_dataValid : out STD_LOGIC
        );
    end component;

begin

    uut: top_PPU
        port map (
            i_command => i_command_sim,
            i_x => i_x_sim,
            i_y => i_y_sim,
            i_reset => i_reset_sim,
            i_clk => i_clk_sim,
            o_dataPixel => o_dataPixel_sim,
            o_dataValid => o_dataValid_sim
        );

    -- Clock generation
    CLK_process :process
    begin
        i_clk_sim <= '0'; wait for 10 ns;
        i_clk_sim <= '1'; wait for 10 ns;
    end process;

    -- Stimulus
    stim_proc: process
    variable i, j : integer;
    variable i_slv, j_slv : std_logic_vector(6 downto 0);
    variable x_slv, y_slv : std_logic_vector(11 downto 0);
    begin
        i_reset_sim <= '1';  -- Assert reset
        wait for 100 ns;
        i_reset_sim <= '0';  -- Deassert reset
        wait for 20 ns;
    
        for i in 0 to 127 loop
            for j in 0 to 127 loop
                i_slv := std_logic_vector(to_unsigned(i, 7));
                j_slv := std_logic_vector(to_unsigned(j, 7));
                if (j mod 2 = 0) then
                    i_command_sim <= "0101" & "00000" & '1' & j_slv & i_slv & "00000000";
                else
                    i_command_sim <= "0101" & "01011" & '1' & j_slv & i_slv & "00000000";
                end if;
                wait for 40 ns;
            end loop;
        end loop;
        
        for y in 0 to 359 loop
            for x in 0 to 639 loop
                x_slv := std_logic_vector(to_unsigned(x, 12));
                y_slv := std_logic_vector(to_unsigned(y, 12));
                i_x_sim <= x_slv;
                i_y_sim <= y_slv;
                wait for 40 ns;
            end loop;
        end loop;
        
--        i_x_sim <= "000000101000";
--        i_reset_sim <= '0';
--        -- mettre tuile 4 a (5, 0)
--        -- opcode & tuile id & ch_tuile & y & x & flip info...
--        i_command_sim <= "0101" & "00100" & '1' & "0000000" & "0000101" & "00000000";
        
--        --place tuile 5 a (5, 0)
--        wait for 40 ns;
--        i_y_sim <= "000000000000";
--        wait for 40 ns;
--        i_y_sim <= "000000000001";
--        wait for 40 ns;
--        i_y_sim <= "000000000010";
--        wait for 40 ns;
--        i_y_sim <= "000000000011";
--        wait for 40 ns;
--        i_y_sim <= "000000000100";
--        wait for 40 ns;
--        i_y_sim <= "000000000101";
--        wait for 40 ns;
--        i_y_sim <= "000000000110";
--        wait for 40 ns;
--        i_y_sim <= "000000000111";
        -- MoveView: opcode = "0000", x = 3, y = 4
        -- x = 3 => "0000000011" into bits [23:14]
        -- y = 4 => "0000000100" into bits [13:4]
--        i_command_sim <= "0000" & "0000" & "0000000000" & "0000000000" & "0000";
--        i_x_sim <= "000000000000";
--        i_y_sim <= "000000000000";
--        i_reset_sim <= '0';
--        wait for 40 ns;
        
        -- SetView: opcode = "0001", x = 5, y = 6
        -- x = 5 => "0000000101" into bits [23:14]
        -- y = 6 => "0000000110" into bits [13:4]
--        i_command_sim <= "0001" & "0000" & "0000000000" & "0000000000" & "0000";
--        i_x_sim <= "000000000000";
--        i_y_sim <= "000000000000";
--        i_reset_sim <= '0';
--        wait for 40 ns;
        
--        i_command_sim <= "0001" & "0000" & "0000000001" & "0000000000" & "0000";
--        i_x_sim <= "000000000000";
--        i_y_sim <= "000000000000";
--        i_reset_sim <= '0';
--        wait for 40 ns;
        
--        i_command_sim <= "0001" & "0000" & "0000000010" & "0000000000" & "0000";
--        i_x_sim <= "000000000000";
--        i_y_sim <= "000000000000";
--        i_reset_sim <= '0';
--        wait for 40 ns;
        
--        i_command_sim <= "0001" & "0000" & "0000000011" & "0000000000" & "0000";
--        i_x_sim <= "000000000000";
--        i_y_sim <= "000000000000";
--        i_reset_sim <= '0';
--        wait for 40 ns;
        
        -- MoveActPos: opcode = "0010", act_id = 3, ch_movepos = 1, x = 10, y = 20, ch_flipX=1, ch_flipY=0, flipX=0, flipY=0
        -- act_id[27:25] = "011", ch = 1 [24], x = 10 [23:14], y = 20 [13:4], ch_flipX = 1 [3], ch_flipY = 0 [2], flipX = 0 [1], flipY = 0 [0]
--        i_command_sim <= "0010" & "011" & '1' & "0000001010" & "0000010100" & '0' & '1' & '0' & '0';
--        i_x_sim <= "000000000000";
--        i_y_sim <= "000000000000";
--        i_reset_sim <= '0';
--        wait for 40 ns;
        
--        -- SetActPos: opcode = "0011", act_id = 2, ch_setpos = 1, x = 30, y = 40, ch_flipX=1, ch_flipY=0, flipX=1, flipY=0
--        i_command_sim <= "0011" & "010" & '1' & "0000011110" & "0000101000" & '1' & '0' & '1' & '0';
--        i_x_sim <= "000000000000";
--        i_y_sim <= "000000000000";
--        i_reset_sim <= '0';
--        wait for 40 ns;
        
--        -- SetActTile: opcode = "0100", act_id = 1, ch_tile_id = 1, tile_id = 7, ch_flipX=1, ch_flipY=1, flipX=1, flipY=1
--        i_command_sim <= "0100" & "001" & '1' & "0111" & "0000000000000000" & '1' & '1' & '1' & '1';
--        i_x_sim <= "000000000000";
--        i_y_sim <= "000000000000";
--        i_reset_sim <= '0';
--        wait for 40 ns;
        
--        -- SetBackTile: opcode = "0101", tile_id = 17, ch_tile = 1, row = 12, col = 22, ch_flipY = 1, flip_y = 1
--        -- tile_id = "10001" [27:23], ch_tile_id = 1 [22], row = 0001100 [21:15], col = 0010110 [14:8], ch_flipY = 1 [1], flip_y = 1 [0]
--        i_command_sim <= "0101" & "10001" & '1' & "0001100" & "0010110" & "000000" & '1' & '1';
--        i_x_sim <= "000000000000";
--        i_y_sim <= "000000000000";
--        i_reset_sim <= '0';
--        wait for 40 ns;
                
        wait;
    end process;

end Behavioral;
