----------------------------------------------------------------------------------
-- Engineer: Olasubomi Borishade
-- 
-- Create Date: 02/16/2026 09:38:15 PM
-- Design Name: 2:1 Multiplexer
-- Module Name: Multiplexer_2_to_1 - Behavioral
-- Project Name: EENG 5560 Homework 3

-- Description: A test bench for a 2:1 Multiplexer

-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use STD.ENV.FINISH;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Multiplexer_2_to_1_Test_Bench is
--  Port ( );
end Multiplexer_2_to_1_Test_Bench;

architecture Behavioral of Multiplexer_2_to_1_Test_Bench is
Constant d_w_c: integer := 8;
Signal I0s, I1s, Ys: STD_LOGIC_VECTOR(d_w_c - 1 downto 0);
Signal Sels: STD_LOGIC;

begin
mux: entity work.Multiplexer_2_to_1(Behavioral)
    Generic map(d_w => d_w_c)
    
    Port map (  I0 => I0s,
                I1 => I1s,
                Sel => Sels,
                Y => Ys
                );

stim: process
    begin
    I0s <= X"AB"; I1s <= X"10";
    Sels <= '0'; wait for 5 ns;
    Sels <= '1'; wait for 5 ns;
    finish;
    end process;

end Behavioral;
