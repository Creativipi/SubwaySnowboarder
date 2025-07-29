library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity TuileBackBuff2 is
    Port(
    i_x : in STD_LOGIC_VECTOR (2 downto 0);
    i_y : in STD_LOGIC_VECTOR (2 downto 0);
    i_tile_id : in STD_LOGIC_VECTOR (4 downto 0);
    i_ch_x : in STD_LOGIC_VECTOR (2 downto 0);
    i_ch_y : in STD_LOGIC_VECTOR (2 downto 0);
    i_ch_cc : in STD_LOGIC_VECTOR (3 downto 0);
    i_ch_we : in std_logic;
    i_clk : in STD_LOGIC;
    i_flip_y : in STD_LOGIC;
    i_tile_id_write : in STD_LOGIC_VECTOR (4 downto 0);
    o_colorCode : out STD_LOGIC_VECTOR (3 downto 0));
end TuileBackBuff2;

architecture Behavioral of TuileBackBuff2 is
    type tuile_out_array_t is array (0 to 31) of std_logic_vector(3 downto 0);
    signal tuile_outputs : tuile_out_array_t;
    signal tuile_write_enable : std_logic_vector(31 downto 0);
begin
    
    process(i_tile_id, i_ch_we)
        variable idx : integer;
    begin
        for i in 0 to 31 loop
            tuile_write_enable(i) <= '0';
        end loop;
        idx := to_integer(unsigned(i_tile_id_write));
        tuile_write_enable(idx) <= i_ch_we;
    end process;
    
    gen_tuile_instances : for i in 0 to 31 generate
        tuile_inst : entity work.Tuile
            generic map (
                TILE_ID => i
            )
            port map (
                i_x => i_x,
                i_y => i_y,
                i_clk => i_clk,
                i_ch_x => i_ch_x,
                i_ch_y => i_ch_y,
                i_ch_cc => i_ch_cc,
                i_ch_we => tuile_write_enable(i),
                o_cc => tuile_outputs(i)
            );
    end generate gen_tuile_instances;
    process(i_tile_id, tuile_outputs)
        variable idx : integer;
    begin
        idx := to_integer(unsigned(i_tile_id));
        if idx >= 0 and idx <= 31 then
            o_colorCode <= tuile_outputs(idx);
        else
            o_colorCode <= (others => '0');
        end if;
    end process;

end Behavioral;
