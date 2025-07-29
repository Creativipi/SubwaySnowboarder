library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ActorMgmt_tb is
end ActorMgmt_tb;

architecture Behavioral of ActorMgmt_tb is

    component ActorMgmt is
        Port (
            i_view_x           : in  STD_LOGIC_VECTOR (9 downto 0);
            i_view_y           : in  STD_LOGIC_VECTOR (9 downto 0);
            i_act_id           : in  STD_LOGIC_VECTOR (2 downto 0);
            i_newpos_x         : in  STD_LOGIC_VECTOR (9 downto 0);
            i_newpos_y         : in  STD_LOGIC_VECTOR (9 downto 0);
            i_tile_id          : in  STD_LOGIC_VECTOR (3 downto 0);
            i_flip_x           : in  STD_LOGIC;
            i_flip_y           : in  STD_LOGIC;
            i_ch_setpos        : in  STD_LOGIC;
            i_ch_tile_id       : in  STD_LOGIC;
            i_ch_flipX         : in  STD_LOGIC;
            i_ch_flipY         : in  STD_LOGIC;
            i_clk              : in  STD_LOGIC;
            o_tile_id          : out STD_LOGIC_VECTOR (3 downto 0);
            o_flip_x           : out STD_LOGIC;
            o_flip_y           : out STD_LOGIC;
            o_pix_x            : out STD_LOGIC_VECTOR (3 downto 0);
            o_pix_y            : out STD_LOGIC_VECTOR (3 downto 0);
            o_is_actor_present : out STD_LOGIC
        );
    end component;

    -- Signaux internes
    signal s_i_view_x           : STD_LOGIC_VECTOR (9 downto 0) := (others => '0');
    signal s_i_view_y           : STD_LOGIC_VECTOR (9 downto 0) := (others => '0');
    signal s_i_act_id           : STD_LOGIC_VECTOR (2 downto 0) := (others => '0');
    signal s_i_newpos_x         : STD_LOGIC_VECTOR (9 downto 0) := (others => '0');
    signal s_i_newpos_y         : STD_LOGIC_VECTOR (9 downto 0) := (others => '0');
    signal s_i_tile_id          : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal s_i_flip_x           : STD_LOGIC := '0';
    signal s_i_flip_y           : STD_LOGIC := '0';
    signal s_i_ch_setpos        : STD_LOGIC := '0';
    signal s_i_ch_tile_id       : STD_LOGIC := '0';
    signal s_i_ch_flipX         : STD_LOGIC := '0';
    signal s_i_ch_flipY         : STD_LOGIC := '0';
    signal s_i_clk_sim          : STD_LOGIC := '0';

    signal s_o_tile_id          : STD_LOGIC_VECTOR (3 downto 0);
    signal s_o_flip_x           : STD_LOGIC;
    signal s_o_flip_y           : STD_LOGIC;
    signal s_o_pix_x            : STD_LOGIC_VECTOR (3 downto 0);
    signal s_o_pix_y            : STD_LOGIC_VECTOR (3 downto 0);
    signal s_o_is_actor_present : STD_LOGIC;

begin

    -- Instanciation du composant
    uut: ActorMgmt
        port map (
            i_view_x            => s_i_view_x,
            i_view_y            => s_i_view_y,
            i_act_id            => s_i_act_id,
            i_newpos_x          => s_i_newpos_x,
            i_newpos_y          => s_i_newpos_y,
            i_tile_id           => s_i_tile_id,
            i_flip_x            => s_i_flip_x,
            i_flip_y            => s_i_flip_y,
            i_ch_setpos         => s_i_ch_setpos,
            i_ch_tile_id        => s_i_ch_tile_id,
            i_ch_flipX          => s_i_ch_flipX,
            i_ch_flipY          => s_i_ch_flipY,
            i_clk               => s_i_clk_sim,
            o_tile_id           => s_o_tile_id,
            o_flip_x            => s_o_flip_x,
            o_flip_y            => s_o_flip_y,
            o_pix_x             => s_o_pix_x,
            o_pix_y             => s_o_pix_y,
            o_is_actor_present  => s_o_is_actor_present
        );

    -- Horloge
    clk_process : process
    begin
        s_i_clk_sim <= '0';
        wait for 10 ns;
        s_i_clk_sim <= '1';
        wait for 10 ns;
    end process;

stimulus : process
begin
    -- Réinitialisation
    s_i_view_x     <= (others => '0');
    s_i_view_y     <= (others => '0');
    s_i_act_id     <= (others => '0');
    s_i_newpos_x   <= (others => '0');
    s_i_newpos_y   <= (others => '0');
    s_i_tile_id    <= (others => '0');
    s_i_flip_x     <= '0';
    s_i_flip_y     <= '0';
    s_i_ch_setpos  <= '0';
    s_i_ch_tile_id <= '0';
    s_i_ch_flipX   <= '0';
    s_i_ch_flipY   <= '0';

    wait for 25 ns;

    -- Test 1 : Position connue (acteur 0 par défaut) à (325, 185)
    s_i_view_x <= std_logic_vector(to_unsigned(325, 10));
    s_i_view_y <= std_logic_vector(to_unsigned(185, 10));
    wait for 100 ns;

    -- Test 2 : Déplacer acteur 1 à (200, 200)
    s_i_act_id    <= std_logic_vector(to_unsigned(0, 3));
    s_i_newpos_x  <= std_logic_vector(to_unsigned(200, 10));
    s_i_newpos_y  <= std_logic_vector(to_unsigned(200, 10));
    s_i_tile_id   <= "0000";
    s_i_flip_x    <= '0';
    s_i_flip_y    <= '0';
    s_i_ch_setpos <= '1';
    s_i_ch_tile_id <= '0';
    s_i_ch_flipX  <= '0';
    s_i_ch_flipY  <= '0';

    wait for 20 ns;

    -- Fin des signaux de changement
    s_i_ch_setpos  <= '0';
    s_i_ch_tile_id <= '0';
    s_i_ch_flipX   <= '0';
    s_i_ch_flipY   <= '0';

    wait for 40 ns;

    -- Test 3 : Vue à la nouvelle position de l'acteur 1 (doit détecter)
    s_i_view_x <= std_logic_vector(to_unsigned(200, 10));
    s_i_view_y <= std_logic_vector(to_unsigned(200, 10));

    wait for 100 ns;

    wait;
end process;


end Behavioral;
