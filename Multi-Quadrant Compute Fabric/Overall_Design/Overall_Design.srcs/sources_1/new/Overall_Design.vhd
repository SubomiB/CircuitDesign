----------------------------------------------------------------------------------
-- Engineer: Olasubomi Borishade
-- 
-- Create Date: 02/23/2026 10:25:23 PM
-- Design Name: Overall Design
-- Module Name: Overall_Design - Behavioral
-- Project Name: EENG 5550 Project 1

-- Description: The design includes 4 quadrants and routers. Each quadrant has external data input source options.
-- The router is capable of sending and receiving data to and from different quadrant routers simultaneously.

-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use WORK.OPERATIONS_ARRAY_CUSTOM_PACK.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Overall_Design is
    Generic (   d_w: integer := 8;
                cols: natural := 2;
                rows: natural := 2;
                blocks: natural := 4
                );
                
    Port (  Q0_Ext_In_A, Q1_Ext_In_A, Q2_Ext_In_A, Q3_Ext_In_A: in VectorArray_2d (0 to rows - 1)(0 to cols - 1)(d_w - 1 downto 0);
            Q0_Ext_In_B, Q1_Ext_In_B, Q2_Ext_In_B, Q3_Ext_In_B: in VectorArray_2d (0 to rows - 1)(0 to cols - 1)(d_w - 1 downto 0);
            Q0_OpSel, Q1_OpSel, Q2_OpSel, Q3_OpSel: in CUArray_2d (0 to rows - 1)(0 to cols - 1);
            Q0_A_Sel, Q1_A_Sel, Q2_A_Sel, Q3_A_Sel: in BitArray_2d (0 to rows - 1)(0 to cols - 1);
            Q0_B_Sel, Q1_B_Sel, Q2_B_Sel, Q3_B_Sel: in BitArray_2d (0 to rows - 1)(0 to cols - 1);
            Q0_Address_A, Q0_Address_B: in VectorArray_1d (0 to blocks - 1)(3 downto 0);
            Q1_Address_A, Q1_Address_B: in VectorArray_1d (0 to blocks - 1)(3 downto 0);
            Q2_Address_A, Q2_Address_B: in VectorArray_1d (0 to blocks - 1)(3 downto 0);
            Q3_Address_A, Q3_Address_B: in VectorArray_1d (0 to blocks - 1)(3 downto 0);
            Q0_Address_Global, Q1_Address_Global, Q2_Address_Global, Q3_Address_Global: in STD_LOGIC_VECTOR (3 downto 0) := "1111";
            Global_to_Q0_Address, Global_to_Q1_Address, Global_to_Q2_Address, Global_to_Q3_Address: in STD_LOGIC_VECTOR (3 downto 0);
            Q0_RW_Enable, Q1_RW_Enable, Q2_RW_Enable, Q3_RW_Enable: in STD_LOGIC;
            QR0_Global_Write_Enable, QR1_Global_Write_Enable, QR2_Global_Write_Enable, QR3_Global_Write_Enable: in STD_LOGIC;
            RW_Enable_Global: in STD_LOGIC;
            Clock: in STD_LOGIC
            );
                        
end Overall_Design;

architecture Behavioral of Overall_Design is
Signal Q0_Global_I, Q1_Global_I, Q2_Global_I, Q3_Global_I: STD_LOGIC_VECTOR (d_w - 1 downto 0);
Signal Q0_Global_O, Q1_Global_O, Q2_Global_O, Q3_Global_O: STD_LOGIC_VECTOR (d_w - 1 downto 0);

begin
Global_Inst: entity work.Global_Router(Behavioral)                  
    Port map(   Clock => Clock, Read_Write_Enable_Global => RW_Enable_Global,
                Quadrant_0_In => Q0_Global_I, Quadrant_1_In => Q1_Global_I, Quadrant_2_In => Q2_Global_I, Quadrant_3_In => Q3_Global_I,
                Quadrant_0_Out => Q0_Global_O, Quadrant_1_Out => Q1_Global_O, Quadrant_2_Out => Q2_Global_O, Quadrant_3_Out => Q3_Global_O,
                Quadrant_0_Address => Global_to_Q0_Address, Quadrant_1_Address => Global_to_Q1_Address, 
                Quadrant_2_Address => Global_to_Q2_Address, Quadrant_3_Address => Global_to_Q3_Address
                );
                
Full_Quadrant_Inst0: entity work.Full_Quadrant(Structural)
 Port map (  Clock => Clock, CU_RW_Enable => Q0_RW_Enable, QR_Global_Write_Enable => QR0_Global_Write_Enable,
                Ext_In_A => Q0_Ext_In_A, Ext_In_B => Q0_Ext_In_B, Global_Router_Input => Q0_Global_O,
                Quadrant_OpSel => Q0_OpSel,
                In_A_Sel => Q0_A_Sel, In_B_Sel => Q0_B_Sel,
                Router_Address_A => Q0_Address_A, Router_Address_B => Q0_Address_B, Router_Address_Global => Q0_Address_Global,
                Global_Router_Output => Q0_Global_I
                );

Full_Quadrant_Inst1: entity work.Full_Quadrant(Structural)
 Port map (  Clock => Clock, CU_RW_Enable => Q1_RW_Enable, QR_Global_Write_Enable => QR1_Global_Write_Enable,
                Ext_In_A => Q1_Ext_In_A, Ext_In_B => Q1_Ext_In_B, Global_Router_Input => Q1_Global_O,
                Quadrant_OpSel => Q1_OpSel,
                In_A_Sel => Q1_A_Sel, In_B_Sel => Q1_B_Sel,
                Router_Address_A => Q1_Address_A, Router_Address_B => Q1_Address_B, Router_Address_Global => Q1_Address_Global,
                Global_Router_Output => Q1_Global_I
                );

Full_Quadrant_Inst2: entity work.Full_Quadrant(Structural)
 Port map (  Clock => Clock, CU_RW_Enable => Q2_RW_Enable, QR_Global_Write_Enable => QR2_Global_Write_Enable,
                Ext_In_A => Q2_Ext_In_A, Ext_In_B => Q2_Ext_In_B, Global_Router_Input => Q2_Global_O,
                Quadrant_OpSel => Q2_OpSel,
                In_A_Sel => Q2_A_Sel, In_B_Sel => Q2_B_Sel,
                Router_Address_A => Q2_Address_A, Router_Address_B => Q2_Address_B, Router_Address_Global => Q2_Address_Global,
                Global_Router_Output => Q2_Global_I
                );
                
Full_Quadrant_Inst3: entity work.Full_Quadrant(Structural)
 Port map (  Clock => Clock, CU_RW_Enable => Q3_RW_Enable, QR_Global_Write_Enable => QR3_Global_Write_Enable,
                Ext_In_A => Q3_Ext_In_A, Ext_In_B => Q3_Ext_In_B, Global_Router_Input => Q3_Global_O,
                Quadrant_OpSel => Q3_OpSel,
                In_A_Sel => Q3_A_Sel, In_B_Sel => Q3_B_Sel,
                Router_Address_A => Q3_Address_A, Router_Address_B => Q3_Address_B, Router_Address_Global => Q3_Address_Global,
                Global_Router_Output => Q3_Global_I
                );
                                                                       
end Behavioral;
