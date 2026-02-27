----------------------------------------------------------------------------------
-- Engineer: Olasubomi Borishade
-- 
-- Create Date: 02/11/2026 08:07:33 PM
-- Design Name: CU With Local Storage
-- Module Name: CU_With_Local_Storage - Behavioral
-- Project Name: EENG 5550 Porject 1

-- Description: Computation Unit capable of pulling stored operands from local storage units
-- and storing output into a local storage unit

-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use WORK.OPERATIONS_ARRAY_CUSTOM_PACK.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CU_With_Local_Storage is
    Generic (d_w: integer := 8);
    
    Port (  Data_In_A: in STD_LOGIC_VECTOR (d_w - 1 downto 0); -- Declaring the input to the storage unit that input A pulls from as a vector
            Data_In_B: in STD_LOGIC_VECTOR (d_w - 1 downto 0); -- Declaring the input to the storage unit that input B pulls from as a vector
            Clock: in STD_LOGIC; -- Declaring the clock input for the local storage units
            ReadWrite_Enable: in STD_LOGIC; -- Declaring the read/write enable input of the A and B operand local storage unit
            OpSel : in CU_Operation := NoOp; -- Declaring the operation selection signal as an input vector
            Q_Out_Y: out STD_LOGIC_VECTOR (d_w - 1 downto 0) -- Declaring the input to the storage unit that input A pulls from as a vector
            );
        
end CU_With_Local_Storage;

architecture Structural of CU_With_Local_Storage is
Signal AStored_Data: STD_LOGIC_VECTOR(d_w - 1 downto 0); -- The input into the A port of the CU
Signal BStored_Data: STD_LOGIC_VECTOR(d_w - 1 downto 0); -- The input into the B port of the CU
Signal YStored_Data: STD_LOGIC_VECTOR(d_w - 1 downto 0); -- The output into the Y port of the CU

begin

Input_A_Local_Storage: entity work.Local_Storage_Unit(Behavioral)
    Port map (Data_In => Data_In_A, Clock => Clock, ReadWrite_Enable => ReadWrite_Enable, Q_Out => AStored_Data);

Input_B_Local_Storage: entity work.Local_Storage_Unit(Behavioral)
    Port map (Data_In => Data_In_B, Clock => Clock, ReadWrite_Enable => ReadWrite_Enable, Q_Out => BStored_Data);

Computation_Unit: entity work.Computation_Unit(Behavioral)
    Port map(A => AStored_Data, B => BStored_Data, OpSel => OpSel, Y => YStored_Data);
    
Output_Y_Local_Storage: entity work.Local_Storage_Unit(Behavioral)
    Port map (Data_In => YStored_Data, Clock => Clock, ReadWrite_Enable => ReadWrite_Enable, Q_Out => Q_Out_Y);    
    
end Structural;
