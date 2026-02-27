----------------------------------------------------------------------------------
-- Engineer: Olasubomi Borishade
-- 
-- Create Date: 02/23/2026 07:31:53 PM
-- Design Name: Full_Quadrant Test Bench
-- Module Name: Full_Quadrant - Structural
-- Project Name: EENG 5550 Project 1

-- Description: A test bench for a full quadrant of 4 full computation blocks and one quadrant router

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

entity Full_Quadrant_Test_Bench is
--  Port ( );
end Full_Quadrant_Test_Bench;

architecture Behavioral of Full_Quadrant_Test_Bench is
Constant d_w_c: integer := 8;
Constant cols_c: natural := 2;
Constant rows_c: natural := 2;
Constant blocks_c: natural := 4;
Signal Clocks: STD_LOGIC := '0';
Signal CU_RW_Enables: STD_LOGIC;
Signal QR_Global_Write_Enables: STD_LOGIC;
Signal Ext_In_As, Ext_In_Bs: VectorArray_2d (0 to rows_c - 1)(0 to cols_c - 1)(d_w_c - 1 downto 0);
Signal Quadrant_OpSels: CUArray_2d (0 to rows_c - 1)(0 to cols_c - 1);
Signal Global_Router_Inputs: STD_LOGIC_VECTOR (d_w_c - 1 downto 0);
Signal In_A_Sels, In_B_Sels: BitArray_2d (0 to rows_c - 1)(0 to cols_c - 1);
Signal Router_Address_As, Router_Address_Bs: VectorArray_1d (0 to blocks_c - 1) (3 downto 0);
Signal Router_Address_Globals: STD_LOGIC_VECTOR (3 downto 0);
Signal Global_Router_Outputs: STD_LOGIC_VECTOR (d_w_c - 1 downto 0);

begin
Full_Quadrant_Inst: entity work.Full_Quadrant(Structural)
    Generic map (   d_w => d_w_c,
                    cols => cols_c,
                    rows => rows_c,
                    blocks => blocks_c)

    Port map (  Clock => Clocks, CU_RW_Enable => CU_RW_Enables, QR_Global_Write_Enable => QR_Global_Write_Enables,
                Ext_In_A => Ext_In_As, Ext_In_B => Ext_In_Bs, Global_Router_Input => Global_Router_Inputs,
                Quadrant_OpSel => Quadrant_OpSels,
                In_A_Sel => In_A_Sels, In_B_Sel => In_B_Sels,
                Router_Address_A => Router_Address_As, Router_Address_B => Router_Address_Bs, Router_Address_Global => Router_Address_Globals,
                Global_Router_Output => Global_Router_Outputs
                );
             
Clocks <= NOT Clocks after 5 ns; -- Toggle the clock every 5 ns

stim: process
begin
Ext_In_As <= (  (X"0A", X"0B"),
                (X"0C", X"0D"));

Ext_In_Bs <= (  (X"01", X"02"),
                (X"03", X"04"));                               

In_A_Sels <= (  ('0', '0'), -- All external inputs selected
                ('0', '0'));

In_B_Sels <= (  ('0', '0'), -- All external inputs selected
                ('0', '0'));

Quadrant_OpSels <= (    (aADD, aADD),
                        (aSUB, aSUB));
                                   
CU_RW_Enables <= '1'; -- Storage units are in write mode; operands are stored in local storages
wait for 5 ns;

CU_RW_Enables <= '0'; -- Storage units are in read mode; operands are sent to computation unit
wait for 15 ns; 

Router_Address_Globals <= "0110"; -- Global Input should be stored in register 6
Global_Router_Inputs <= X"08";

CU_RW_Enables <= '1'; wait for 5 ns; -- Storage units are in write mode; result are stored in local storage

CU_RW_Enables <= '0'; wait for 15 ns; -- Storage units are in read mode; result are given to quadrant router

CU_RW_Enables <= '1'; 
QR_Global_Write_Enables <= '1';
wait for 5 ns; -- Quadrant router is in write mode; result are stored in registers
wait for 5ns;

CU_RW_Enables <= '0'; -- The storage unit is in read mode
Router_Address_Globals <= "0001"; -- Global output should be what was stored in register 1 (i.e., X"0B" + X"02")
Router_Address_As <= (  ("0000"), -- Output for A0 operand should be what was stored in register 0 (i.e., X"0A" + X"01")
                        ("0011"), -- Output for A1 operand should be what was stored in register 3 (i.e., X"0D" - X"04")
                        ("0010"), -- Output for A2 operand should be what was stored in register 2 (i.e., X"0B" + X"02")
                        ("0110")); -- Output for A3 operand should be what was stored in register 6 (i.e., X"08")
                        
Router_Address_Bs <= (  ("0010"), -- Output for B0 operand should be what was stored in register 2 (i.e., X"0B" + X"02")
                        ("0001"), -- Output for B1 operand should be what was stored in register 1 (i.e., X"0B" + X"02")
                        ("0110"), -- Output for B2 operand should be what was stored in register 6 (i.e., X"08")
                        ("1000")); -- Output for B3 operand should be unknown (i.e., UUUU or XXXX)

wait for 15 ns;
     
finish;
end process stim;                                                        
end Behavioral;
