----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.06.2025 00:00:57
-- Design Name: 
-- Module Name: ActorMgmt - Behavioral
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

entity ActorMgmt is
    Port (
        -- Position du pixel dans le viewport
        i_view_x : in STD_LOGIC_VECTOR (9 downto 0);
        i_view_y : in STD_LOGIC_VECTOR (9 downto 0);

        -- Mise � jour des acteurs (position RELATIVE AU VIEWPORT)
        i_act_id : in STD_LOGIC_VECTOR (2 downto 0);
        i_newpos_x : in STD_LOGIC_VECTOR (9 downto 0);
        i_newpos_y : in STD_LOGIC_VECTOR (9 downto 0);
        i_tile_id : in STD_LOGIC_VECTOR (3 downto 0);
        i_flip_x : in STD_LOGIC;
        i_flip_y : in STD_LOGIC;
        i_ch_setpos : in STD_LOGIC;
        i_ch_tile_id : in STD_LOGIC;
        i_ch_flipX : in STD_LOGIC;
        i_ch_flipY : in STD_LOGIC;
        i_clk : in STD_LOGIC;

        -- R�sultat : info du pixel
        o_tile_id : out STD_LOGIC_VECTOR (3 downto 0);
        o_flip_x : out STD_LOGIC;
        o_flip_y : out STD_LOGIC;
        o_pix_x : out STD_LOGIC_VECTOR (3 downto 0);
        o_pix_y : out STD_LOGIC_VECTOR (3 downto 0);
        o_is_actor_present : out STD_LOGIC
    );
end ActorMgmt;

architecture Behavioral of ActorMgmt is
    -- Sparse array de 8 acteurs
    type pos_array_t is array (0 to 7) of std_logic_vector(9 downto 0);
    type tile_array_t is array (0 to 7) of std_logic_vector(3 downto 0);
    type flip_array_t is array (0 to 7) of std_logic;

    signal actor_pos_x : pos_array_t := (
    0 => std_logic_vector(to_unsigned(320, 10)), -- acteur 0 au centre du viewport
    1 => std_logic_vector(to_unsigned(336, 10)), -- acteur 1 juste � droite (16 px)
    others => (others => '0')
);

signal actor_pos_y : pos_array_t := (
    0 => std_logic_vector(to_unsigned(180, 10)), -- centr� verticalement
    1 => std_logic_vector(to_unsigned(180, 10)),
    others => (others => '0')
);

signal actor_tile_id : tile_array_t := (
    others => std_logic_vector(to_unsigned(0, 4))
);

    signal actor_flip_x : flip_array_t := (others => '0');
    signal actor_flip_y : flip_array_t := (others => '0');

    signal s_actor_hit : std_logic_vector(7 downto 0);
begin

    -- G�n�ration: d�tection de collision pixel / acteur
    gen_actor_check: for i in 0 to 7 generate
        process(i_view_x, i_view_y, actor_pos_x(i), actor_pos_y(i))
            variable view_x : integer;
            variable view_y : integer;
            variable act_x : integer;
            variable act_y : integer;
        begin
            view_x := to_integer(unsigned(i_view_x));
            view_y := to_integer(unsigned(i_view_y));
            act_x := to_integer(unsigned(actor_pos_x(i)));
            act_y := to_integer(unsigned(actor_pos_y(i)));

            if (view_x >= act_x and view_x < act_x + 16 and
                view_y >= act_y and view_y < act_y + 16) then
                s_actor_hit(i) <= '1';
            else
                s_actor_hit(i) <= '0';
            end if;
        end process;
    end generate;

    -- R�solution: acteur de plus haute priorit� (ID plus bas)
    process(s_actor_hit, actor_tile_id, actor_flip_x, actor_flip_y, i_view_x, i_view_y, actor_pos_x, actor_pos_y)
        variable found : boolean := false;
        variable rel_x, rel_y : integer range 0 to 15;
    begin
        o_tile_id <= (others => '0');
        o_flip_x <= '0';
        o_flip_y <= '0';
        o_pix_x <= (others => '0');
        o_pix_y <= (others => '0');
        o_is_actor_present <= '0';

        for i in 0 to 7 loop
            if s_actor_hit(i) = '1' and not found then
                found := true;
                rel_x := to_integer(unsigned(i_view_x)) - to_integer(unsigned(actor_pos_x(i)));
                rel_y := to_integer(unsigned(i_view_y)) - to_integer(unsigned(actor_pos_y(i)));
                o_tile_id <= actor_tile_id(i);
                o_flip_x <= actor_flip_x(i);
                o_flip_y <= actor_flip_y(i);
                o_pix_x <= std_logic_vector(to_unsigned(rel_x, 4));
                o_pix_y <= std_logic_vector(to_unsigned(rel_y, 4));
                o_is_actor_present <= '1';
            end if;
        end loop;
    end process;

    -- �criture des donn�es d'acteurs
    process(i_clk)
        variable id : integer;
    begin
        if rising_edge(i_clk) then
            id := to_integer(unsigned(i_act_id));

            if i_ch_setpos = '1' then
                actor_pos_x(id) <= i_newpos_x;
                actor_pos_y(id) <= i_newpos_y;
            end if;

            if i_ch_tile_id = '1' then
                actor_tile_id(id) <= i_tile_id;
            end if;

            if i_ch_flipX = '1' then
                actor_flip_x(id) <= i_flip_x;
            end if;

            if i_ch_flipY = '1' then
                actor_flip_y(id) <= i_flip_y;
            end if;
        end if;
    end process;

end Behavioral;
