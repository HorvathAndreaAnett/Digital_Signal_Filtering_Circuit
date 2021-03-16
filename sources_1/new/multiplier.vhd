----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/10/2020 12:35:43 PM
-- Design Name: 
-- Module Name: multiplier - Behavioral
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
use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity multiplier is
    Generic (n: integer := 8;
             m : integer := 4);
    Port ( X : in STD_LOGIC_VECTOR (n-1 downto 0);
           Y : in STD_LOGIC_VECTOR (m-1 downto 0);
           result : out STD_LOGIC_VECTOR (n+m-1 downto 0));
end multiplier;

architecture Behavioral of multiplier is

begin
    process (X, Y)
    variable B : STD_LOGIC_VECTOR (n+m-1 downto 0);
    variable Q : STD_LOGIC_VECTOR (m-1 downto 0);
    variable A : STD_LOGIC_VECTOR (n+m-1 downto 0);
    variable p : integer;
    begin
        B := std_logic_vector(resize(signed(X), B'length));
        --Q := std_logic_vector(resize(signed(Y), Q'length));
        Q := Y;
        A := (others => '0');  
        p := m;              
        
        while (p /= 0) loop
            if (Q(0) = '1') then
                A := A + B;
            end if;
            B := B((B'length - 2) downto 0) & '0';
            Q := '0' & Q(m-1 downto 1);
            p := p - 1;
        end loop;
        result <= A;
    end process;

end Behavioral;
