----------------------------------------------------------------------------------
-- Engineer: Olasubomi Borishade
-- 
-- Create Date: 02/11/2026 08:07:33 PM
-- Design Name: CU With Local Storage Test Bench
-- Module Name: CU_With_Local_Storage_Test_Bench - Behavioral
-- Project Name: EENG 5550 Porject 1

-- Description: A test bench for a computation Unit capable of pulling stored operands from local storage units
-- and storing output into a local storage unit

-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use STD.ENV.FINISH;
use WORK.OPERATIONS_ARRAY_CUSTOM_PACK.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CU_With_Local_Storage_Test_Bench is
--  Port ( );
end CU_With_Local_Storage_Test_Bench;

architecture Behavioral of CU_With_Local_Storage_Test_Bench is
Constant d_w_c: integer := 8;
Signal Data_In_As, Data_In_Bs, Q_Out_Ys: STD_LOGIC_VECTOR(d_w_c - 1 downto 0);
Signal Clocks: STD_LOGIC:= '0'; 
Signal ReadWrite_Enables: STD_LOGIC;
Signal OpSels: CU_Operation := NoOp;

begin
CU_With_Local_Storage: entity work.CU_With_Local_Storage(Structural)
    Generic map(d_w => d_w_c)

    Port map(Data_In_A => Data_In_As, Data_In_B => Data_In_Bs, Clock => Clocks, ReadWrite_Enable => ReadWrite_Enables, OpSel => OpSels, Q_Out_Y => Q_Out_Ys); 

Clocks <= NOT Clocks after 5 ns; -- Toggle the clock every 1 ns

stim: process
begin
    Data_In_As <= "00001010"; -- Input A is 10
    Data_In_Bs <= "00001100"; -- Input B is 12
    OpSels <= aMULT; -- Computation Unit is in arithmetic multiplication operation mode
    ReadWrite_Enables <= '1'; wait for 5 ns; -- Storage units are in write mode; operands are stored in local storages
    ReadWrite_Enables <= '0'; wait for 15 ns; -- Storage units are in read mode; operands are sent to computation unit
    
    ReadWrite_Enables <= '1'; wait for 5 ns; -- Storage units are in write mode; result is stored in local storage
    ReadWrite_Enables <= '0'; wait for 15 ns; -- Storage units are in read mode; result is given
    finish;
end process stim;


end Behavioral;
