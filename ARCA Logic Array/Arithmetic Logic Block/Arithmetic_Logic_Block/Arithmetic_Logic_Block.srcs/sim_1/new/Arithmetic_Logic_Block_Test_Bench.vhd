----------------------------------------------------------------------------------
-- Engineer: Olasubomi Borishade
-- 
-- Create Date: 02/03/2026 04:42:08 PM
-- Design Name: Arithmetic Logic Block Test Bench
-- Module Name: Arithmetic_Logic_Block_Test_Bench - Behavioral
-- Project Name: EENG 5560 Homework 2

-- Description: Test bench for a logic block capable of adding, 
-- subtracting and multiplying to inputs A and B

-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.OPERATIONS_ARRAY_CUSTOM_PACK.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.ENV.FINISH;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Arithmetic_Logic_Block_Test_Bench is
--  Port ( );
end Arithmetic_Logic_Block_Test_Bench;

architecture Behavioral of Arithmetic_Logic_Block_Test_Bench is
Constant  d_w_c: integer := 3; -- Declaring data width signal
Signal As, Bs, Ys: STD_LOGIC_VECTOR (d_w_c - 1 downto 0); -- Declaring input and output signals
Signal OpselAs: ALB_Operation; -- Declaring the operation selection signal as an input vector

begin
ALB_Inst: entity work.Arithmetic_Logic_Block(Behavioral)
    Generic map (d_w => d_w_c) -- Port-mapping the data width values of the instatiated logic block
    Port map (A => As, -- Port-mapping the the input, output and select signals
                B => Bs,
                OpselA => OpselAs,
                Y => Ys
                );

stim: process
    begin
        As <= "111"; Bs <= "000"; -- Assigning first set of test vectors
        OpselAs <= aADD; wait for 5 ns;
        OpselAs <= aSUB; wait for 5 ns;
        OpselAs <= aMULT; wait for 5 ns;
        OpselAs <= NoOp; wait for 5 ns;

    finish;
end process;
end Behavioral;
