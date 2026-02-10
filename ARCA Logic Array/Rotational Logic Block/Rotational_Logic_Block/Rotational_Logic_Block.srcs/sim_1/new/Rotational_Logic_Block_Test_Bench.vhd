----------------------------------------------------------------------------------
-- Engineer: Olasubomi Borishade
-- 
-- Create Date: 02/04/2026 07:28:44 PM
-- Design Name: Rotational Logic Block
-- Module Name: Rotational_Logic_Block_Test_Bench - Behavioral
-- Project Name: EENG 5560 Homework 2

-- Description: Testing a logical block that can shift an input A by the magnitude of another
-- input B either left or right

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

entity Rotational_Logic_Block_Test_Bench is
--  Port ( );
end Rotational_Logic_Block_Test_Bench;

architecture Behavioral of Rotational_Logic_Block_Test_Bench is
Constant d_w_c: integer := 3; -- Declaring data width signal
Signal As, Bs, Ys: STD_LOGIC_VECTOR (d_w_c - 1 downto 0); -- Declaring input and output signals
Signal OpSelRs: RLB_Operation; -- Declaring the operation selection signal as an input vector

begin
RLB_Inst: entity work.Rotational_Logic_Block(Behavioral)
    Generic map (d_w => d_w_c) -- Port-mapping the data width values of the instatiated logic block
    Port map (A => As, -- Port-mapping the the input, output and select signals
                B => Bs,
                OpSelR => OpSelRs,
                Y => Ys
                );

stim: process
begin
    As <= "010"; Bs <= "001"; -- Assigning first set of test vectors
    OpselRs <= rLSL; wait for 5 ns;
    OpselRs <= rLSR; wait for 5 ns;
    OpselRs <= NoOp; wait for 5 ns;
    finish;
    
end process;
end Behavioral;
