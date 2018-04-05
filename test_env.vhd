----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/28/2018 09:37:29 PM
-- Design Name: 
-- Module Name: test_env - Behavioral
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

entity test_env is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (4 downto 0);
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end test_env;

architecture Behavioral of test_env is
component mpg is
Port ( clk : in STD_LOGIC;
       btn : in STD_LOGIC;
       enable : out STD_LOGIC);
end component;

component ssd is
    Port ( digit : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           cat : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component InstrFetch is
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
end component;

signal en: std_logic;
signal write_enable: std_logic :='1';
signal jAdd: std_logic_vector(15 downto 0) := "0000000000000000";
signal brAdd: std_logic_vector(15 downto 0) := "0000000000000000";
signal outputI: std_logic_vector(15 downto 0);
signal outputPC: std_logic_vector(15 downto 0);
signal digits: std_logic_vector(15 downto 0);
signal controlDisplay: std_logic;
begin

u1: mpg port map (clk, btn(0), en );
u2: InstrFetch port map (en, write_enable, btn(1), jAdd, brAdd, sw(0), sw(1),outputI, outputPC);
u3: ssd port map (digits, en, cat, an);

process (sw(7))
begin
    if ( sw(7) = '0') then
       -- controlDisplay <= digits
       end if;
end process;
end Behavioral;
