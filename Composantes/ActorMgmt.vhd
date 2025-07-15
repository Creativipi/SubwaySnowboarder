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
-- Description: Actor Manager using sparse format for 8 actors with 16x16 tiles
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
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity ActorMgmt is
    Port ( i_view_x : in STD_LOGIC_VECTOR (9 downto 0);
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
           i_clk : in STD_LOGIC;
           
           -- Info du pixel qu'on regarde
           o_tile_id : out STD_LOGIC_VECTOR (3 downto 0);
           o_flip_x : out STD_LOGIC;
           o_flip_y : out STD_LOGIC;
           o_pix_x : out STD_LOGIC_VECTOR (3 downto 0);
           o_pix_y : out STD_LOGIC_VECTOR (3 downto 0);
           o_is_actor_present : out STD_LOGIC);
end ActorMgmt;

architecture Behavioral of ActorMgmt is
    -- Actor storage arrays (sparse format)
    type pos_array_t is array (0 to 7) of std_logic_vector(9 downto 0);
    type tile_array_t is array (0 to 7) of std_logic_vector(3 downto 0);
    type flip_array_t is array (0 to 7) of std_logic;
    
    signal actor_pos_x : pos_array_t := (others => (others => '0'));
    signal actor_pos_y : pos_array_t := (others => (others => '0'));
    signal actor_tile_id : tile_array_t := (others => (others => '0'));
    signal actor_flip_x : flip_array_t := (others => '0');
    signal actor_flip_y : flip_array_t := (others => '0');
    
    -- Intersection detection signals
    signal s_actor_hit : std_logic_vector(7 downto 0);
    signal s_pix_x_in_actor : std_logic_vector(3 downto 0);
    signal s_pix_y_in_actor : std_logic_vector(3 downto 0);
    
begin
    -- Check intersection with each actor
    gen_actor_check: for i in 0 to 7 generate
        process(i_view_x, i_view_y, actor_pos_x(i), actor_pos_y(i))
            variable view_x_int : integer range 0 to 1023;
            variable view_y_int : integer range 0 to 1023;
            variable actor_x_int : integer range 0 to 1023;
            variable actor_y_int : integer range 0 to 1023;
        begin
            view_x_int := to_integer(unsigned(i_view_x));
            view_y_int := to_integer(unsigned(i_view_y));
            actor_x_int := to_integer(unsigned(actor_pos_x(i)));
            actor_y_int := to_integer(unsigned(actor_pos_y(i)));
            
            -- Check if view pixel is within this actor's 16x16 tile
            if (view_x_int >= actor_x_int and view_x_int < (actor_x_int + 16) and
                view_y_int >= actor_y_int and view_y_int < (actor_y_int + 16)) then
                s_actor_hit(i) <= '1';
            else
                s_actor_hit(i) <= '0';
            end if;
        end process;
    end generate;
    
    -- Priority encoder: find highest priority actor (lowest ID)
    process(s_actor_hit, actor_tile_id, actor_flip_x, actor_flip_y, i_view_x, i_view_y, actor_pos_x, actor_pos_y)
        variable found_actor : boolean := false;
        variable actor_idx : integer range 0 to 7;
        variable rel_x, rel_y : integer range 0 to 15;
    begin
        -- Default outputs
        o_tile_id <= (others => '0');
        o_flip_x <= '0';
        o_flip_y <= '0';
        o_pix_x <= (others => '0');
        o_pix_y <= (others => '0');
        o_is_actor_present <= '0';
        
        found_actor := false;
        
        -- Check actors in priority order (0 has highest priority)
        for i in 0 to 7 loop
            if s_actor_hit(i) = '1' and not found_actor then
                actor_idx := i;
                found_actor := true;
                
                -- Calculate relative pixel position within the actor's tile
                rel_x := to_integer(unsigned(i_view_x)) - to_integer(unsigned(actor_pos_x(i)));
                rel_y := to_integer(unsigned(i_view_y)) - to_integer(unsigned(actor_pos_y(i)));
                
                -- Output actor information
                o_tile_id <= actor_tile_id(i);
                o_flip_x <= actor_flip_x(i);
                o_flip_y <= actor_flip_y(i);
                o_pix_x <= std_logic_vector(to_unsigned(rel_x, 4));
                o_pix_y <= std_logic_vector(to_unsigned(rel_y, 4));
                o_is_actor_present <= '1';
            end if;
        end loop;
    end process;
    
    -- Actor management process
    process(i_clk)
        variable act_id_int : integer range 0 to 7;
    begin
        if rising_edge(i_clk) then
            act_id_int := to_integer(unsigned(i_act_id));
            
            -- Set absolute position
            if i_ch_setpos = '1' then
                actor_pos_x(act_id_int) <= i_newpos_x;
                actor_pos_y(act_id_int) <= i_newpos_y;
            end if;
            
            -- Change tile ID
            if i_ch_tile_id = '1' then
                actor_tile_id(act_id_int) <= i_tile_id;
            end if;
            
            -- Change flip X
            if i_ch_flipX = '1' then
                actor_flip_x(act_id_int) <= i_flip_x;
            end if;
            
            -- Change flip Y
            if i_ch_flipY = '1' then
                actor_flip_y(act_id_int) <= i_flip_y;
            end if;
        end if;
    end process;
    
end Behavioral;