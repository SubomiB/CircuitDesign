----------------------------------------------------------------------------------
-- Engineer: Olasubomi Borishade
-- 
-- Create Date: 02/09/2026 08:47:56 PM
-- Design Name: Computation Unit
-- Module Name: Computation_Unit - Behavioral
-- Project Name: EENG 5550 Project 1

-- Description: A test bench for a computation unit with 8 bit operands and outputs capable of the following operations:
-- ADD, SUB, MULT, AND, NAND, OR, NOR, XOR, XNOR, OR, RSL, RSR, LSL and LSR

-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.OPERATIONS_ARRAY_CUSTOM_PACK.ALL;
use STD.ENV.FINISH;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Computation_Unit_Test_Bench is
--  Port ( );
end Computation_Unit_Test_Bench;

architecture Behavioral of Computation_Unit_Test_Bench is
Constant d_w_c: integer := 8; -- Declaring data width signal
Signal As, Bs, Ys: STD_LOGIC_VECTOR (d_w_c - 1 downto 0); -- Declaring input and output signals
Signal OpSels: CU_Operation; -- Declaring the operation selection signal as an input

begin
Computation_Unit_Inst: entity work.Computation_Unit(Behavioral)
    Generic map (d_w => d_w_c) -- Port-mapping the data width values of the instatiated computation unit
    Port map (A => As, -- Port-mapping the the input, output and select signals
              B => Bs,
              OpSel => OpSels,
              Y => Ys
              );

stim: process
begin
    As <= "00001010"; Bs <= "00000100"; -- Assigning first set of test vectors A = 10 and B = 4
        Opsels <= aADD; wait for 1 ns;
        Opsels <= aSUB; wait for 1 ns;
        Opsels <= aMULT; wait for 1 ns;
        Opsels <= lAND; wait for 1 ns;
        Opsels <= lNAND; wait for 1 ns;
        Opsels <= lOR; wait for 1 ns;
        Opsels <= lNOR; wait for 1 ns;
        Opsels <= lXOR; wait for 1 ns;
        Opsels <= lXNOR; wait for 1 ns;
        Opsels <= rLSL; wait for 1 ns;
        Opsels <= rLSR; wait for 1 ns;
        Opsels <= rRSL; wait for 1 ns;
        Opsels <= rRSR; wait for 1 ns;
        Opsels <= PassA; wait for 1 ns;
        Opsels <= PassB; wait for 1 ns;
        Opsels <= NoOp; wait for 1 ns;    
    finish;
    end process;
    
end Behavioral;
