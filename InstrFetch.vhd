----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/29/2018 04:38:10 PM
-- Design Name: 
-- Module Name: InstrFetch - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity InstrFetch is
 Port ( clk: in std_logic;
 we: in std_logic;
 reset: in std_logic;
 jumpAdd: in std_logic_vector(15 downto 0);
 branchAdd: in std_logic_vector(15 downto 0);
 je: in std_logic; -- jump control signal
 be: in std_logic;  -- PCSrc Control signal(for branch)
 instr: out std_logic_vector(15 downto 0);
 pc_1: out std_logic_vector(15 downto 0)
 );
end InstrFetch;

architecture Behavioral of InstrFetch is
type ROM is array (0 to 255) of std_logic_vector(15 downto 0); -- how big we should do it?
signal instruction_rom: ROM :=(
B"000_000_001_010_0_000",--R-type addition --1+1=2
B"000_001_010_001_0_000",--R-type addition --1+2=3
B"000_001_010_010_0_000",--R-type addition --3+2=5
B"000_001_010_001_0_000",--R-type addition --5+3=8
B"000_001_010_010_0_000",--R-type addition --8+5=13
B"000_001_010_001_0_000",--R-type addition --13+8=21
B"000_001_010_010_0_000",--R-type addition --21+13=44
B"000_001_010_001_0_000",--R-type addition --44+21=65
others => "0000000000000000");

signal count: std_logic_vector (15 downto 0):= "0000000000000000";
signal address: std_logic_vector(7 downto 0);
signal outAdder: std_logic_vector(15 downto 0);
signal outMuxB: std_logic_vector(15 downto 0);
signal outMuxJ: std_logic_vector(15 downto 0);

begin

process(clk, reset, we) --clk comes from mpg
begin
--PC
if (reset = '1') then
    count <= "0000000000000000";
else 
    if (clk'event and clk = '1') then
         if(we = '1') then --this should actually always be on because we always need to take the next address
                count <= jumpAdd;
         end if;
    end if;
end if;

address <= count(7 downto 0);
end process;

process(count)
begin
    outAdder <= count +1;
end process;

--INSTRUCTION MEM
process(address)
begin
    instr <= instruction_rom(conv_integer(address));
end process;

--MUX BRANCH EN
process(be)
begin
    if (be = '0')then
        outMuxB <= outAdder;
    else --be = '1'
        outMuxB <= branchAdd;
    end if;        
end process;

--MUX JUMP ENABLE
process(je)
begin
    if (je = '0') then
        outMuxJ <= outMuxB;
    else --je ='1'
        outMuxJ <= jumpAdd;
    end if;
end process;

pc_1 <= outAdder;

end Behavioral;
