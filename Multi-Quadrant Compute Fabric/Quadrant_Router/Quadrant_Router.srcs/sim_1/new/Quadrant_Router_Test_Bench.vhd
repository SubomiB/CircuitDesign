----------------------------------------------------------------------------------
-- Engineer: Olasubomi Borishade
-- 
-- Create Date: 02/12/2026 09:21:13 PM
-- Design Name: Quadrant Router
-- Module Name: Quadrant_Router - Behavioral
-- Project Name: EENG 5550 Project 1

-- Description: A test bench for a storage unit/router capable of receiving 5 inputs and 3 outputs

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

entity Quadrant_Router_Test_Bench is
--  Port ( );
end Quadrant_Router_Test_Bench;

architecture Behavioral of Quadrant_Router_Test_Bench is
Constant d_w_c: integer:= 8;
Constant rows_c: natural := 4;
Signal Data_In_0s, Data_In_1s, Data_In_2s, Data_In_3s: STD_LOGIC_VECTOR(d_w_c - 1 downto 0);
Signal Global_Router_Ins, Global_Router_Outs: STD_LOGIC_VECTOR(d_w_c - 1 downto 0); 
Signal Q_Out_A0s, Q_Out_A1s, Q_Out_A2s, Q_Out_A3s: STD_LOGIC_VECTOR(d_w_c - 1 downto 0);
Signal Q_Out_B0s, Q_Out_B1s, Q_Out_B2s, Q_Out_B3s: STD_LOGIC_VECTOR(d_w_c - 1 downto 0);
Signal Address_As: VectorArray_1d (0 to rows_c - 1)(3 downto 0); 
Signal Address_Bs: VectorArray_1d (0 to rows_c - 1)(3 downto 0);
Signal Address_Globals: STD_LOGIC_VECTOR (3 downto 0) := "1111";
Signal Read_Write_Enables, Global_Write_Enables: STD_LOGIC;
Signal Clocks: STD_LOGIC := '0';

begin
Quadrant_Router: entity work.Quadrant_Router(Behavioral)
    Generic map (   d_w => d_w_c,
                    rows => rows_c)

    Port map(   Data_In_0 => Data_In_0s, Data_In_1 => Data_In_1s, Data_In_2 => Data_In_2s, Data_In_3 => Data_In_3s,
                Global_Router_In => Global_Router_Ins, Global_Router_Out => Global_Router_Outs,
                Address_A => Address_As,
                Address_B => Address_Bs,
                Address_Global => Address_Globals,
                Read_Write_Enable => Read_Write_Enables, Global_Write_Enable => Global_Write_Enables, 
                Clock => Clocks,
                Q_Out_A0 => Q_Out_A0s, Q_Out_A1 => Q_Out_A1s, Q_Out_A2 => Q_Out_A2s, Q_Out_A3 => Q_Out_A3s,
                Q_Out_B0 => Q_Out_B0s, Q_Out_B1 => Q_Out_B1s, Q_Out_B2 => Q_Out_B2s, Q_Out_B3 => Q_Out_B3s
                );
                
Clocks <= NOT Clocks after 5 ns; -- Toggle the clock every 5 ns

stim: process
begin
    Read_Write_Enables <= '1'; -- The storage unit is in write mode, all inputs are stored in their respective registers.
    Global_Write_Enables <= '1';
    
    Address_Globals <= "0110"; -- Global Input should be stored in register 6
    
    Data_In_0s <= X"0A"; Data_In_1s <= X"0B"; Data_In_2s <= X"0C"; Data_In_3s <= X"0D"; Global_Router_Ins <= X"0E"; -- Assign data inputs
    
    wait for 5 ns;

       
    Read_Write_Enables <= '0'; -- The storage unit is in read mode
    Global_Write_Enables <= '0';
    
    Address_Globals <= "0001"; -- Global output should be what was stored in register 1 (i.e., Data_In_1s)
    
    Address_As <= ( ("0110"),-- Output for A0 operand should be what was stored in register 6 (i.e., Global_Router_Ins)
                    ("1000"),-- Output for A1 operand should be what was stored in register 8 (i.e., Unknown)
                    ("0000"),-- Output for A2 operand should be what was stored in register 0 (i.e., Data_In_0s)
                    ("0110"));-- Output for A3 operand should be what was stored in register 6 (i.e., Global_Router_Ins)
    
    Address_Bs <= ( ("0011"),-- Output for B0 operand should be what was stored in register 3 (i.e., Data_In_3s)
                    ("0001"),-- Output for B1 operand should be what was stored in register 1 (i.e., Data_In_1s)
                    ("0010"),-- Output for B2 operand should be what was stored in register 2 (i.e., Data_In_2s)
                    ("0101"));-- Output for B3 operand should be what was stored in register 5 (i.e., Unknown)
                                     
    wait for 15 ns;
     
    finish;
end process stim;

end Behavioral;
