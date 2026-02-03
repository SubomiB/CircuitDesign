----------------------------------------------------------------------------------
-- Engineer: Olasubomi Borishade
-- 
-- Create Date: 01/30/2026 07:18:46 PM
-- Design Name: Operation/Array Pack
-- Module Name: OperationArray_Pack - Behavioral
-- Project Name: EENG 5560 Homework 1
-- Description: Custom package of operation and array types
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package Operations_Array_CustomPack is
type CU_Operation is (lAND, lNOR, aADD, aSUB, aMULT, cGTH, cLTH, cEQT, NoOp);
type OperationArray_1d is array (natural range<>) of CU_Operation;
type OperationArray_2d is array (natural range<>) of OperationArray_1d;

subtype vec is std_logic_vector;
type VectorArray_1d is array(natural range<>) of vec;
type VectorArray_2d is array(natural range<>) of VectorArray_1d;

end package Operations_Array_CustomPack;
