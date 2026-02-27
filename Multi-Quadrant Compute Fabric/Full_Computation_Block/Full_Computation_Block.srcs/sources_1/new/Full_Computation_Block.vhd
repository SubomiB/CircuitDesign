----------------------------------------------------------------------------------
-- Engineer: Olasubomi Borishade
-- 
-- Create Date: 02/20/2026 04:18:00 PM
-- Design Name: Full Computation Block
-- Module Name: Full_Computation_Block - Structural
-- Project Name: EENG 5550 Project 1

-- Description: A computation unit capable of pulling stored operands through a multiplexer 
-- interconnect and operation select signals from local storage units and storing output into a local storage unit

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

entity Full_Computation_Block is
    Generic (d_w: integer := 8); -- Generic parameter is set to 12 bits because 4 of those bits will be used to determine the address of incoming operands
    
    Port (  In_A1: in STD_LOGIC_VECTOR (d_w - 1 downto 0); -- Declaring the input to the storage unit that input A pulls from as a vector
            In_B1: in STD_LOGIC_VECTOR (d_w - 1 downto 0); -- Declaring the input to the storage unit that input B pulls from as a vector
            In_A2: in STD_LOGIC_VECTOR (d_w - 1 downto 0); -- Declaring the input to the storage unit that input A pulls from as a vector
            In_B2: in STD_LOGIC_VECTOR (d_w - 1 downto 0); -- Declaring the input to the storage unit that input B pulls from as a vector
            Input_A_Sel: in STD_LOGIC; -- Select line for the input into the multiplexer
            Input_B_Sel: in STD_LOGIC; -- Select line for the input into the multiplexer
            Clock: in STD_LOGIC; -- Declaring the clock input for the local storage units
            ReadWrite_Enable: in STD_LOGIC; -- Declaring the read/write enable input of the A and B operand local storage unit
            In_OpSel: in CU_Operation := NoOp; -- Declaring the operation selection signal as an input vector
            Q_Out_Y: out STD_LOGIC_VECTOR (d_w - 1 downto 0) -- Declaring the input to the storage unit that input A pulls from as a vector
            );
        
end Full_Computation_Block;

architecture Structural of Full_Computation_Block is
Signal Input_A_MUX: STD_LOGIC_VECTOR(d_w - 1 downto 0); -- The input into the A port of the CU
Signal Input_B_MUX: STD_LOGIC_VECTOR(d_w - 1 downto 0); -- The input into the B port of the CU

begin

Multiplexer_2_to_1_Inst1: entity work.Multiplexer_2_to_1(Behavioral)
    Port map (I0 => In_A1, I1 => In_A2, Sel => Input_A_Sel, Y => Input_A_MUX);
    
Multiplexer_2_to_1_Inst2: entity work.Multiplexer_2_to_1(Behavioral)
    Port map (I0 => In_B1, I1 => In_B2, Sel => Input_B_Sel, Y => Input_B_MUX);    
    
CU_With_local_Storage_Inst: entity work.CU_With_Local_Storage(Structural)
    Port map (  Data_In_A => Input_A_MUX, Data_In_B => Input_B_MUX, -- only 8 bits are allowed in
                Clock => Clock, ReadWrite_Enable => ReadWrite_Enable, 
                OpSel => In_OpSel, Q_Out_Y => Q_Out_Y -- 8-bit output
                );
    
end Structural;
