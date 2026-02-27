----------------------------------------------------------------------------------
-- Engineer: Olasubomi Borishade
-- 
-- Create Date: 02/23/2026 04:42:58 PM
-- Design Name: Global Router
-- Module Name: Global_Router - Behavioral
-- Project Name: EENG 5550 Project 1

-- Description: A test bench for a storage unit/router capable of sending and receiving data 
-- to and from different quadrant routers simultaneously

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

entity Global_Router_Test_Bench is
--  Port ( );
end Global_Router_Test_Bench;

architecture Behavioral of Global_Router_Test_Bench is
Constant d_w_c: integer:= 8;
Constant rows_c: natural := 4;
Signal Clocks: STD_LOGIC := '0';
Signal Read_Write_Enable_Globals: STD_LOGIC;
Signal Quadrant_0_Ins, Quadrant_1_Ins, Quadrant_2_Ins, Quadrant_3_Ins: STD_LOGIC_VECTOR(d_w_c - 1 downto 0);
Signal Quadrant_0_Addresss, Quadrant_1_Addresss, Quadrant_2_Addresss, Quadrant_3_Addresss : STD_LOGIC_VECTOR (3 downto 0);
Signal Quadrant_0_Outs, Quadrant_1_Outs, Quadrant_2_Outs, Quadrant_3_Outs: STD_LOGIC_VECTOR (d_w_c - 1 downto 0);

begin
Global_Router: entity work.Global_Router(Behavioral)
    Generic map (   d_w => d_w_c)
                    
    Port map (  Quadrant_0_In => Quadrant_0_Ins, Quadrant_1_In => Quadrant_1_Ins, Quadrant_2_In => Quadrant_2_Ins, Quadrant_3_In => Quadrant_3_Ins,
                Clock => Clocks, Read_Write_Enable_Global => Read_Write_Enable_Globals,
                Quadrant_0_Address => Quadrant_0_Addresss, Quadrant_1_Address => Quadrant_1_Addresss,
                Quadrant_2_Address => Quadrant_2_Addresss, Quadrant_3_Address => Quadrant_3_Addresss,
                Quadrant_0_Out => Quadrant_0_Outs, Quadrant_1_Out => Quadrant_1_Outs, Quadrant_2_Out => Quadrant_2_Outs, Quadrant_3_Out => Quadrant_3_Outs);
                
Clocks <= NOT Clocks after 5 ns; -- Toggle the clock every 5 ns                

stim: process
begin
    Read_Write_Enable_Globals <= '1'; -- The storage unit is in write mode, all inputs are stored in their respective registers.
    Quadrant_0_Ins <= X"0C"; Quadrant_1_Ins <= X"0A"; Quadrant_2_Ins <= X"0B"; Quadrant_3_Ins <= X"0D";
    Quadrant_0_Addresss <= "0001"; -- Store the Quadrant 0 input into register 1
    Quadrant_1_Addresss <= "0101"; -- Store the Quadrant 1 input into register 5
    Quadrant_2_Addresss <= "1001"; -- Store the Quadrant 2 input into register 9
    Quadrant_3_Addresss <= "1101"; -- Store the Quadrant 3 input into register 13
    wait for 5 ns;
    
    Read_Write_Enable_Globals <= '0'; -- The storage unit is in read mode
    Quadrant_0_Addresss <= "1101"; -- Output register 13 to Quadrant 0
    Quadrant_1_Addresss <= "1001"; -- Output register 9 to Quadrant 1
    Quadrant_2_Addresss <= "0101"; -- Output register 5 to Quadrant 2
    Quadrant_3_Addresss <= "0001"; -- Output register 1 to Quadrant 3
    wait for 15ns;
    
    finish;
    
end process;                
end Behavioral;
