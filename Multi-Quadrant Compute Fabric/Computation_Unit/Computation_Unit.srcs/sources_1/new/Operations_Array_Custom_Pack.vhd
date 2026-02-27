----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Olasubomi Borishade
-- 
-- Create Date: 02/03/2026 04:47:16 PM
-- Design Name: Operations & Array Custom Pack
-- Module Name: Operations_Array_Custom_Pack - Behavioral
-- Project Name: EENG 5550 Project 1

-- Description:  Custom package of operation and array types

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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package Operations_Array_Custom_Pack is
type CU_Operation is (aADD, aSUB, aMULT, lAND, lNAND, lNOR, lOR, lXOR, lXNOR, rLSL, rLSR, rRSR, rRSL, PassA, PassB, NoOp);

type CUArray_1d is array (natural range<>) of CU_Operation;

type CUArray_2d is array (natural range<>) of CUArray_1d;

subtype vec is std_logic_vector;
type VectorArray_1d is array (natural range<>) of vec;
type VectorArray_2d is array (natural range<>) of VectorArray_1d;

subtype bit_array is std_logic;
type BitArray_1d is array (natural range<>) of bit_array;
type BitArray_2d is array (natural range<>) of BitArray_1d;

end package Operations_Array_Custom_Pack;
