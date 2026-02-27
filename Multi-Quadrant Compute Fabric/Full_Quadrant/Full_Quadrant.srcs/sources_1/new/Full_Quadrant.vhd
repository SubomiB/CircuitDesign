----------------------------------------------------------------------------------
-- Engineer: Olasubomi Borishade
-- 
-- Create Date: 02/23/2026 07:31:53 PM
-- Design Name: Full_Quadrant
-- Module Name: Full_Quadrant - Structural
-- Project Name: EENG 5550 Project 1

-- Description: A full quadrant of 4 full computation blocks and one quadrant router

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

entity Full_Quadrant is
    Generic (   d_w: integer := 8;
                cols: natural := 2;
                rows: natural := 2;
                blocks: natural := 4
                );
   
    Port (  Clock: in STD_LOGIC;
            CU_RW_Enable: in STD_LOGIC;
            QR_Global_Write_Enable: in STD_LOGIC;
            Ext_In_A: in VectorArray_2d (0 to rows - 1)(0 to cols - 1)(d_w - 1 downto 0);
            Ext_In_B: in VectorArray_2d (0 to rows - 1)(0 to cols - 1)(d_w - 1 downto 0);
            Quadrant_OpSel: in CUArray_2d (0 to rows - 1)(0 to cols - 1);
            Global_Router_Input: in STD_LOGIC_VECTOR (d_w - 1 downto 0);
            In_A_Sel: in BitArray_2d (0 to rows - 1)(0 to cols - 1);
            In_B_Sel: in BitArray_2d (0 to rows - 1)(0 to cols - 1);
            Router_Address_A: in VectorArray_1d (0 to blocks - 1)(3 downto 0);
            Router_Address_B: in VectorArray_1d (0 to blocks - 1) (3 downto 0);
            Router_Address_Global: in STD_LOGIC_VECTOR (3 downto 0) := "1111";
            Global_Router_Output: out STD_LOGIC_VECTOR (d_w - 1 downto 0)
            );
                            
end Full_Quadrant;

architecture Structural of Full_Quadrant is
Signal Comp_Out: VectorArray_2d (0 to rows - 1)(0 to cols - 1)(d_w - 1 downto 0); -- Outputs of all full computation blocks
Signal Q_Out_A: VectorArray_2d (0 to rows - 1)(0 to cols - 1)(d_w - 1 downto 0); -- Input A operands for all full computation blocks
Signal Q_Out_B: VectorArray_2d (0 to rows - 1)(0 to cols - 1)(d_w - 1 downto 0); -- Input B operands for all full computation blocks
            
begin
gen_rows: for r in 0 to rows - 1 generate
gen_cols: for c in 0 to cols - 1 generate

Full_Computation_Blocks_Inst: entity work.Full_Computation_Block(Structural)
    Port map (  In_A1 => Ext_In_A(r)(c), In_B1 => Ext_In_B(r)(c), In_A2 => Q_Out_A(r)(c), In_B2 => Q_Out_B(r)(c),
                Input_A_Sel => In_A_Sel(r)(c), Input_B_Sel => In_B_Sel(r)(c),
                Clock => Clock, ReadWrite_Enable => CU_RW_Enable,
                In_OpSel => Quadrant_OpSel(r)(c),
                Q_Out_Y => Comp_Out(r)(c)
    ); 
       
end generate;
end generate;

Quadrant_Router_Inst: entity work.Quadrant_Router(Behavioral)
    Port map (  Data_In_0 => Comp_Out(0)(0), Data_In_1 => Comp_Out(0)(1), Data_In_2 => Comp_Out(1)(0), Data_In_3 => Comp_Out(1)(1),
                Address_A => Router_Address_A, Address_B => Router_Address_B, Address_Global => Router_Address_Global,
                Global_Router_In => Global_Router_Input, Global_Router_Out => Global_Router_Output,
                Clock => Clock, Read_Write_Enable => CU_RW_Enable, Global_Write_Enable => QR_Global_Write_Enable,
                Q_Out_A0 => Q_Out_A(0)(0), Q_Out_B0 => Q_Out_B(0)(0),
                Q_Out_A1 => Q_Out_A(0)(1), Q_Out_B1 => Q_Out_B(0)(1),
                Q_Out_A2 => Q_Out_A(1)(0), Q_Out_B2 => Q_Out_B(1)(0),
                Q_Out_A3 => Q_Out_A(1)(1), Q_Out_B3 => Q_Out_B(1)(1)
                );

end Structural;
