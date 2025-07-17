----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.06.2025 00:00:57
-- Design Name: 
-- Module Name: MuxBackActor - Behavioral
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

entity MuxBackActor is
    Port ( i_back_color_code : in STD_LOGIC_VECTOR (3 downto 0);
           i_act_color_code : in STD_LOGIC_VECTOR (3 downto 0);
           i_act_en : in STD_LOGIC;
           i_is_actor_present : std_logic;
           o_color_code : out STD_LOGIC_VECTOR (3 downto 0));
end MuxBackActor;

architecture Behavioral of MuxBackActor is

begin
    -- use i_is_actor_present to pick background or actor color ?
    --
    -- o_color_code <= i_act_color_code when i_is_actor_present = '1'
    -- else i_back_color_code
    --
    
    --Basiqument, si i_act_color_code n'�gal pas 16, c'est i_act_color_code qui est envoy�, sinon, c'est i_back_color_code
    s_isActorAlpha <= (i_act_color_code(0) AND i_act_color_code(1) AND i_act_color_code(2) AND i_act_color_code(3)) OR NOT(i_act_en);
    
    o_color_code(0) <= (i_back_color_code(0) AND s_isActorAlpha) OR (i_act_color_code(0) AND NOT(s_isActorAlpha));
    o_color_code(1) <= (i_back_color_code(1) AND s_isActorAlpha) OR (i_act_color_code(1) AND NOT(s_isActorAlpha));
    o_color_code(2) <= (i_back_color_code(2) AND s_isActorAlpha) OR (i_act_color_code(2) AND NOT(s_isActorAlpha));
    o_color_code(3) <= (i_back_color_code(3) AND s_isActorAlpha) OR (i_act_color_code(3) AND NOT(s_isActorAlpha));

end Behavioral;
