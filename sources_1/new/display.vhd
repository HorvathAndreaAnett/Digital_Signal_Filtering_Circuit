----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/10/2020 01:19:53 PM
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity display is
    Port ( internal_clk : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (4 downto 0);
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end display;

architecture Behavioral of display is

component mpg is
Port ( btn : in STD_LOGIC_VECTOR (4 downto 0);
       clk : in STD_LOGIC;
       step : out STD_LOGIC_VECTOR (4 downto 0));
end component;

component ssd is
Port ( digit0 : in STD_LOGIC_VECTOR (3 downto 0);
       digit1 : in STD_LOGIC_VECTOR (3 downto 0);
       digit2 : in STD_LOGIC_VECTOR (3 downto 0);
       digit3 : in STD_LOGIC_VECTOR (3 downto 0);
       clk : in STD_LOGIC;
       cat : out STD_LOGIC_VECTOR (6 downto 0);
       an : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component filter is
    Generic ( n : integer := 8);
    Port (data : in STD_LOGIC_VECTOR (n-1 downto 0);
          reset : in STD_LOGIC;
          result : out STD_LOGIC_VECTOR (n+3 downto 0); 
          cout : out STD_LOGIC;
          clk : in STD_LOGIC);
end component filter;

signal step : std_logic_vector(4 downto 0);
signal digit : std_logic_vector(15 downto 0);

signal clk : std_logic;

signal data : STD_LOGIC_VECTOR (7 downto 0);
signal reset : STD_LOGIC;
signal result : STD_LOGIC_VECTOR (11 downto 0);
signal cout : STD_LOGIC;

begin

    MPGU: mpg port map(btn, internal_clk, step);
    SSDU: ssd port map(digit(3 downto 0), digit(7 downto 4), digit(11 downto 8), digit(15 downto 12), internal_clk, cat, an);
    FILTER_UNIT : filter generic map (8) port map (data, reset, result, cout, clk);
    
    reset <= step(0);
    clk <= step(1);
    
    data <= sw(7 downto 0);
    
    digit(11 downto 0) <= result;
    led(0) <= cout;
    

end Behavioral;
