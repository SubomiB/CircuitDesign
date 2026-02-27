----------------------------------------------------------------------------------
-- Engineer: Olasubomi Borishade
--
-- Create Date: 02/11/2026 07:02:15 PM
-- Design Name: Local Storage Unit
-- Module Name: Local_Storage_Unit - Behavioral
-- Project Name: EENG 5550 Project 1

-- Description: A test bench for an 8-bit data storage unit

-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use STD.ENV.FINISH;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Local_Storage_Unit_Test_Bench is
--  Port ( );
end Local_Storage_Unit_Test_Bench;

architecture Behavioral of Local_Storage_Unit_Test_Bench is
Constant d_w_c: integer:= 8;
signal Data_Ins, Q_Outs: STD_LOGIC_VECTOR(d_w_c - 1 downto 0);
signal ReadWrite_Enables: STD_LOGIC;
signal Clocks: STD_LOGIC:= '0';

begin
Local_Storage_Unit: entity work.Local_Storage_Unit(Behavioral)
    Generic map (d_w => d_w_c)
    
    port map(   Data_In => Data_Ins, 
                Q_Out => Q_Outs, 
                ReadWrite_Enable => ReadWrite_Enables, 
                Clock => Clocks
                );

Clocks <= NOT Clocks after 5 ns; -- Toggle the clock every 5 ns

stim: process
begin

    Data_Ins <= X"9C"; 
    ReadWrite_Enables <= '1'; wait for 10 ns; -- if the storage unit is in write mode

    ReadWrite_Enables <= '0'; wait for 10 ns; -- if the storage unit is in read mode
    finish;

end process stim;

end Behavioral;
