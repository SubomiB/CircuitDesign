----------------------------------------------------------------------------------
-- Engineer: Olasubomi Borishade
-- 
-- Create Date: 02/20/2026 04:18:00 PM
-- Design Name: Full Computation Block
-- Module Name: Full_Computation_Block - Structural
-- Project Name: EENG 5550 Project 1

-- Description: A test bench for a computation unit capable of pulling stored operands through a multiplexer 
-- interconnect and operation select signals from local storage units and storing output into a local storage unit

-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use WORK.OPERATIONS_ARRAY_CUSTOM_PACK.ALL;
use STD.ENV.FINISH;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Full_Block_Test_Bench is
--  Port ( );
end Full_Block_Test_Bench;

architecture Behavioral of Full_Block_Test_Bench is
Constant d_w_c: integer := 8;
Signal In_A1s, In_A2s, In_B1s, In_B2s: STD_LOGIC_VECTOR(d_w_c - 1 downto 0);
Signal Q_Out_Ys: STD_LOGIC_VECTOR(d_w_c - 1 downto 0);
Signal Clocks: STD_LOGIC:= '0'; 
Signal Input_A_Sels, Input_B_Sels, ReadWrite_Enables: STD_LOGIC;
Signal In_OpSels: CU_Operation;

begin
Full_Block: entity work.Full_Computation_Block(Structural)
    Generic map(d_w => d_w_c)

    Port map(   In_A1 => In_A1s, In_A2 => In_A2s, In_B1 => In_B1s, In_B2 => In_B2s, 
                Clock => Clocks, ReadWrite_Enable => ReadWrite_Enables, 
                Input_A_Sel => Input_A_Sels, Input_B_Sel => Input_B_Sels, In_OpSel => In_OpSels, 
                Q_Out_Y => Q_Out_Ys); 

Clocks <= NOT Clocks after 5 ns; -- Toggle the clock every 1 ns

stim: process
begin
    In_A1s <= X"01"; -- Input A1 is 226
    In_A2s <= X"10"; -- Input A2 is 14
    In_B1s <= X"AB"; -- Input B1 is 220
    In_B2s <= X"CD"; -- Input B2 is 228
    Input_A_Sels <= '1'; -- Select In_A2
    Input_B_Sels <= '1'; -- Select In_B2
    
    ReadWrite_Enables <= '1'; wait for 5 ns; -- Storage units are in write mode; operands are stored in local storages
    ReadWrite_Enables <= '0'; wait for 15 ns; -- Storage units are in read mode; operands are sent to computation unit
    In_OpSels <= aADD; -- Computation Unit is in arithmetic addition operation mode
    
    ReadWrite_Enables <= '1'; wait for 5 ns; -- Storage units are in write mode; result is stored in local storage
    ReadWrite_Enables <= '0'; wait for 15 ns; -- Storage units are in read mode; result is given

    finish;
end process stim;

end Behavioral;
