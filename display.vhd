----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/28/2018 09:39:44 PM
-- Design Name: 
-- Module Name: display - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ssd is
    Port ( digit : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           cat : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0));
end ssd;
architecture Behavioral of ssd is
signal count: std_logic_vector(15 downto 0):=x"0000";
signal outMUX: std_logic_vector(3 downto 0):="0000";

begin

process(clk)
begin
    if rising_edge(clk) then
        count<=count+1;
    end if;
end process;

process(count)
begin
    case count(15 downto 14) is
        when "00" => an<="1110";
        when "01" => an<="1101";
        when "10" => an<="1011";
        when "11" => an<="0111";
    end case;
end process;
process(count)
begin
    case count(15 downto 14) is
        when "00" => outMUx<=digit(3 downto 0);
        when "01" => outMUx<=digit(7 downto 4);
        when "10" => outMUx<=digit(11 downto 8);
        when "11" => outMUx<=digit(15 downto 12);
    end case;
end process;

process(outMUX)
begin
    case outMUX is
        when "0001" => cat<="1111001";  --1
        when "0010" => cat<="0100100";  --2
        when "0011" => cat<="0110000";  --3
        when "0100" => cat<="0011001";  --4
        when "0101" => cat<="0010010";  --5
        when "0110" => cat<="0000010";  --6
        when "0111" => cat<="1111000";  --7
        when "1000" => cat<="0000000";  --8
        when "1001" => cat<="0010000";  --9
        when "1010" => cat<="0001000";  --A
        when "1011" => cat<="0000011";  --b
        when "1100" => cat<="1000110";  --C
        when "1101" => cat<="0100001";  --d
        when "1110" => cat<="0000110";  --E
        when "1111" => cat<="0001110";  --F
        when others => cat<="1000000";  --0
    end case;
end process;
end Behavioral;

