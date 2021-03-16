----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/10/2020 12:57:07 PM
-- Design Name: 
-- Module Name: test_bench - Behavioral
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

entity test_bench is
--  Port ( );
end test_bench;

architecture Behavioral of test_bench is

component filter is
    Generic ( n : integer := 8);
    Port (data : in STD_LOGIC_VECTOR (n-1 downto 0);
          reset : in STD_LOGIC;
          result : out STD_LOGIC_VECTOR (n+3 downto 0); 
          cout : out STD_LOGIC;
          clk : in STD_LOGIC);
end component filter;

constant n : integer := 8;
signal data : STD_LOGIC_VECTOR (7 downto 0);
signal clk : STD_LOGIC;
signal reset : STD_LOGIC;
signal result : STD_LOGIC_VECTOR (11 downto 0);
signal cout : STD_LOGIC;

begin
    uut : filter generic map (8) port map (data, reset, result, cout, clk);
	process 
	begin
		clk <= '0';
		wait for 10 ns;
		clk <= '1';
		wait for 10 ns;
	end process;
	process
	begin
		reset <= '0';
		data <= x"02";
		wait for 20 ns;
		reset <= '0';
		data <= x"05";
		wait for 20 ns;
		reset <= '0';
		data <= x"03";
		wait for 20 ns;
		reset <= '0';
		data <= x"09";
		wait for 20 ns;
		reset <= '0';
		data <= x"01";
		wait for 20 ns;
		reset <= '0';
		data <= x"11";
		wait for 20 ns;
		reset <= '0';
		data <= x"14";
		wait for 20 ns;
		reset <= '0';
		data <= x"06";
		wait for 20 ns;
		reset <= '0';
		data <= x"00";
		wait for 20 ns;
		reset <= '0';
		data <= x"20";
		wait for 20 ns;
		wait;
	end process;

end Behavioral;