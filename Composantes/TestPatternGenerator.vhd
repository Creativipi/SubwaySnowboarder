----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/18/2021 06:55:22 PM
-- Design Name: 
-- Module Name: testPatternGenerator - Behavioral
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

entity TestPatternGenerator is
Port ( 
    i_clk : in std_logic;
    i_rstn : in std_logic;
    i_axis_tready : in std_logic; -- input (1 when you are ready to render, 0 to stall the render)
    o_axis_tuser : out std_logic; -- start of frame
    o_axis_tlast : out std_logic; -- end of frame
    o_axis_tvalid : out std_logic; -- outputting valid data
    o_x : out std_logic_vector (9 downto 0);
    o_y : out std_logic_vector (8 downto 0)
);
end TestPatternGenerator;

architecture Behavioral of TestPatternGenerator is

type state_videostr is (WAITING, STREAMING, EOL);
signal lineCpt : unsigned(10 downto 0) := (others => '0');
signal columnCpt : unsigned(11 downto 0) := (others => '0');
signal current_state : state_videostr := WAITING;
signal next_state : state_videostr := WAITING;

begin
process(i_clk)
begin
    if(i_rstn = '0') then
        current_state <= WAITING;
    elsif(rising_edge(i_clk)) then
        current_state <= next_state;
        if(i_axis_tready = '1') then
             if(columnCpt = "001010000000") then
                    columnCpt <= "000000000000";
                    if(lineCpt = "00101101000") then
                        lineCpt  <= "00000000000";
                    else
                        lineCpt <= lineCpt + "1";
                    end if;
             else
                    columnCpt <= columnCpt + "1";
             end if;
         end if;
    end if;
    o_x <= std_logic_vector(columnCpt(9 downto 0));
    o_y <= std_logic_vector(lineCpt (8 downto 0));
end process;

process(current_state, i_axis_tready,columnCpt,lineCpt)
begin
    case current_state is
    when WAITING =>
        if(i_axis_tready = '1') then
            next_state <= STREAMING;
        else
            next_state <= WAITING;
        end if;
    when STREAMING =>
        if(columnCpt = "001010000000") then
            next_state <= EOL;
        else
            next_state <= STREAMING;
        end if;
    when EOL =>
         if(lineCpt = "00101101000") then
            next_state <= WAITING;
         else
            next_state <= STREAMING;
         end if;
    end case;
end process;
  
process(current_state,lineCpt)
begin
    case current_state is
    when WAITING =>
        o_axis_tvalid <= '1';
        o_axis_tuser <= '1';
        o_axis_tlast <= '0';
    when STREAMING =>
        o_axis_tvalid <= '1';
        o_axis_tlast <= '0';
        o_axis_tuser <= '0';
    when EOL =>
        o_axis_tvalid <= '1';
        o_axis_tlast <= '1';
        o_axis_tuser <= '0';
    end case;      
end process;     
end Behavioral;
