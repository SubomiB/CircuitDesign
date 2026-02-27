----------------------------------------------------------------------------------
-- Engineer: Olasubomi Borishade
-- 
-- Create Date: 02/23/2026 10:25:23 PM
-- Design Name: Overall Design Test Bench
-- Module Name: Overall_Design_Test_Bench - Behavioral
-- Project Name: EENG 5550 Project 1

-- Description: A test nbench for a design which includes 4 quadrants and routers. Each quadrant has external data input source options.
-- The router is capable of sending and receiving data to and from different quadrant routers simultaneously.

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

entity Overall_Design_Test_Bench_2 is
--  Port ( );
end Overall_Design_Test_Bench_2;

architecture Behavioral of Overall_Design_Test_Bench_2 is
Constant d_w_c: integer := 8;
Constant cols_c: natural := 2;
Constant rows_c: natural := 2;
Constant blocks_c: natural := 4;
Signal Clocks: STD_LOGIC := '0';
Signal RW_Enable_Globals: STD_LOGIC;
Signal Q0_Ext_In_As, Q1_Ext_In_As, Q2_Ext_In_As, Q3_Ext_In_As: VectorArray_2d (0 to rows_c - 1)(0 to cols_c - 1)(d_w_c - 1 downto 0);
Signal Q0_Ext_In_Bs, Q1_Ext_In_Bs, Q2_Ext_In_Bs, Q3_Ext_In_Bs: VectorArray_2d (0 to rows_c - 1)(0 to cols_c - 1)(d_w_C - 1 downto 0);
Signal Q0_OpSels, Q1_OpSels, Q2_OpSels, Q3_OpSels: CUArray_2d (0 to rows_c - 1)(0 to cols_c - 1);
Signal Q0_A_Sels, Q1_A_Sels, Q2_A_Sels, Q3_A_Sels: BitArray_2d (0 to rows_c - 1)(0 to cols_c - 1);
Signal Q0_B_Sels, Q1_B_Sels, Q2_B_Sels, Q3_B_Sels: BitArray_2d (0 to rows_c - 1)(0 to cols_c - 1);
Signal Q0_Address_As, Q0_Address_Bs: VectorArray_1d (0 to blocks_c - 1)(3 downto 0);
Signal Q1_Address_As, Q1_Address_Bs: VectorArray_1d (0 to blocks_c - 1)(3 downto 0);
Signal Q2_Address_As, Q2_Address_Bs: VectorArray_1d (0 to blocks_c - 1)(3 downto 0);
Signal Q3_Address_As, Q3_Address_Bs: VectorArray_1d (0 to blocks_c - 1)(3 downto 0);
Signal Q0_Address_Globals, Q1_Address_Globals, Q2_Address_Globals, Q3_Address_Globals: STD_LOGIC_VECTOR (3 downto 0) := "1111";
Signal Global_to_Q0_Addresss, Global_to_Q1_Addresss, Global_to_Q2_Addresss, Global_to_Q3_Addresss: STD_LOGIC_VECTOR (3 downto 0) := "1111";
Signal Q0_RW_Enables, Q1_RW_Enables, Q2_RW_Enables, Q3_RW_Enables: STD_LOGIC;
Signal QR0_Global_Write_Enables, QR1_Global_Write_Enables, QR2_Global_Write_Enables, QR3_Global_Write_Enables: STD_LOGIC;

begin
Overall_Design_Inst: entity work.Overall_Design(Behavioral)
    Generic map (   d_w => d_w_c,
                    cols => cols_c,
                    rows => rows_c,
                    blocks => blocks_c)
                    
    Port map (  Q0_Ext_In_A => Q0_Ext_In_As, Q1_Ext_In_A => Q1_Ext_In_As, Q2_Ext_In_A => Q2_Ext_In_As, Q3_Ext_In_A => Q3_Ext_In_As,
                Q0_Ext_In_B => Q0_Ext_In_Bs, Q1_Ext_In_B => Q1_Ext_In_Bs, Q2_Ext_In_B => Q2_Ext_In_Bs, Q3_Ext_In_B => Q3_Ext_In_Bs,
                Q0_OpSel => Q0_OpSels, Q1_OpSel => Q1_OpSels, Q2_OpSel => Q2_OpSels, Q3_OpSel => Q3_OpSels,
                Q0_A_Sel => Q0_A_Sels, Q1_A_Sel => Q1_A_Sels, Q2_A_Sel => Q2_A_Sels, Q3_A_Sel => Q3_A_Sels,                  
                Q0_B_Sel => Q0_B_Sels, Q1_B_Sel => Q1_B_Sels, Q2_B_Sel => Q2_B_Sels, Q3_B_Sel => Q3_B_Sels,
                Q0_Address_A => Q0_Address_As, Q0_Address_B => Q0_Address_Bs,
                Q1_Address_A => Q1_Address_As, Q1_Address_B => Q1_Address_Bs,
                Q2_Address_A => Q2_Address_As, Q2_Address_B => Q2_Address_Bs,
                Q3_Address_A => Q3_Address_As, Q3_Address_B => Q3_Address_Bs,
                Q0_Address_Global => Q0_Address_Globals, Q1_Address_Global => Q1_Address_Globals, 
                Q2_Address_Global => Q2_Address_Globals, Q3_Address_Global => Q3_Address_Globals,
                Global_to_Q0_Address => Global_to_Q0_Addresss,
                Global_to_Q1_Address => Global_to_Q1_Addresss,
                Global_to_Q2_Address => Global_to_Q2_Addresss,
                Global_to_Q3_Address => Global_to_Q3_Addresss,
                Q0_RW_Enable => Q0_RW_Enables, Q1_RW_Enable => Q1_RW_Enables,
                Q2_RW_Enable => Q2_RW_Enables, Q3_RW_Enable => Q3_RW_Enables,
                QR0_Global_Write_Enable => QR0_Global_Write_Enables, 
                QR1_Global_Write_Enable => QR1_Global_Write_Enables, 
                QR2_Global_Write_Enable => QR2_Global_Write_Enables, 
                QR3_Global_Write_Enable => QR3_Global_Write_Enables,
                RW_Enable_Global => RW_Enable_Globals,
                Clock => Clocks 
                );

Clocks <= NOT Clocks after 5 ns; -- Toggle the clock every 5 ns

end Behavioral;
