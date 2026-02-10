----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Olasubomi Borishade
-- 
-- Create Date: 02/03/2026 04:47:16 PM
-- Design Name: Operations & Array Custom Pack
-- Module Name: Operations_Array_Custom_Pack - Behavioral
-- Project Name: EENG 5560 Homework 2

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
type ALB_Operation is (aADD, aSUB, aMULT, NoOp);
type CLB_Operation is (cGTH, cLTH, cEQT, cGTET, cLTET, cNET, NoOp);
type RLB_Operation is (rLSL, rLSR, NoOp);

type ALBArray_1d is array (natural range<>) of ALB_Operation;
type CLBArray_1d is array (natural range<>) of CLB_Operation;
type RLBArray_1d is array (natural range<>) of RLB_Operation;

type ALBArray_2d is array (natural range<>) of ALBArray_1d;
type CLBArray_2d is array (natural range<>) of CLBArray_1d;
type RLBArray_2d is array (natural range<>) of RLBArray_1d;

subtype vec is std_logic_vector;
type VectorArray_1d is array(natural range<>) of vec;
type VectorArray_2d is array(natural range<>) of VectorArray_1d;

end package Operations_Array_Custom_Pack;
