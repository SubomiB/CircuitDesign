----------------------------------------------------------------------------------
-- Engineer: Olasubomi Borishade
-- 
-- Create Date: 06/02/2026 06:25:39 PM
-- Design Name: Array Custom Pack
-- Module Name: Array_Custom_Pack - Behavioral
-- Project Name: Parameterized Matrix Multiply Engine

-- Description: Custom package for array of integers, logic vectors and bit vectors

-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

Package Array_Custom_Pack is

subtype SignedArray is SIGNED;
type SignedArray_1d is array (natural range<>) of SignedArray;
type SignedArray_2d is array (natural range<>) of SignedArray_1d;

subtype VectorArray is STD_LOGIC_VECTOR;
type VectorArray_1d is array (natural range<>) of VectorArray;
type VectorArray_2d is array (natural range<>) of VectorArray_1d;

subtype BitArray is STD_LOGIC;
type BitArray_1d is array (natural range<>) of BitArray;
type BitArray_2d is array (natural range<>) of BitArray_1d;

end Array_Custom_Pack;
