----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/10/2020 12:38:03 PM
-- Design Name: 
-- Module Name: filter - Behavioral
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

entity filter is
    Generic ( n : integer := 8);
    Port (data : in STD_LOGIC_VECTOR (n-1 downto 0);
          reset : in STD_LOGIC;
          result : out STD_LOGIC_VECTOR (n+3 downto 0); -- the length of the 
          --result should be changed according to the formua n+m-1 where m 
          --is the length of the constants
          cout : out STD_LOGIC;
          clk : in STD_LOGIC);
end filter;

architecture Behavioral of filter is

component multiplier is
    Generic (n: integer := 8;
             m : integer := 4);
    Port ( X : in STD_LOGIC_VECTOR (n-1 downto 0);
           Y : in STD_LOGIC_VECTOR (m-1 downto 0);
           result : out STD_LOGIC_VECTOR (n+m-1 downto 0));
end component multiplier;

component adder is
    Generic (n: integer := 8);
    Port ( A : in STD_LOGIC_VECTOR (n-1 downto 0);
           B : in STD_LOGIC_VECTOR (n-1 downto 0);
           C : in STD_LOGIC_VECTOR (n-1 downto 0);
           sum : out STD_LOGIC_VECTOR (n-1 downto 0);
           Cout : out STD_LOGIC);
end component adder;

--the constants can be changed
constant a1 : STD_LOGIC_VECTOR (3 downto 0) := "0010"; --2
constant a2 : STD_LOGIC_VECTOR (3 downto 0) := "0011"; --3
constant a3 : STD_LOGIC_VECTOR (3 downto 0) := "0100"; --4

signal reg1 : STD_LOGIC_VECTOR (n-1 downto 0) := (others => '0');
signal reg2 : STD_LOGIC_VECTOR (n-1 downto 0) := (others => '0');
signal reg3 : STD_LOGIC_VECTOR (n-1 downto 0) := (others => '0');

signal mul1 : STD_LOGIC_VECTOR (n + a1'length - 1 downto 0);
signal mul2 : STD_LOGIC_VECTOR (n + a1'length - 1 downto 0);
signal mul3 : STD_LOGIC_VECTOR (n + a1'length - 1 downto 0);

begin
    
    process (clk, reset)
    begin
        if (reset = '1') then
			reg1 <= (others => '0');
			reg2 <= (others => '0');
			reg3 <= (others => '0');
		elsif (rising_edge(clk)) then 
		    reg1 <= data;
		    reg2 <= reg1;
		    reg3 <= reg2; 
		end if;
    end process;
    
    Multiplication1 : multiplier generic map (n, a1'length) port map (reg1, a1, mul1);
    Multiplication2 : multiplier generic map (n, a2'length) port map (reg2, a2, mul2);
    Multiplication3 : multiplier generic map (n, a3'length) port map (reg3, a3, mul3);
    
    --in the generic mapping, the value should be n+m where m is the length of the constants
    Addition : adder generic map (n+4) port map (mul1, mul2, mul3, result, cout);
    
end Behavioral;
