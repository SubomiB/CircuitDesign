----------------------------------------------------------------------------------
-- Engineer: Olasubomi Borishade
-- 
-- Create Date: 02/23/2026 10:25:23 PM
-- Design Name: Overall Design Test Bench
-- Module Name: Overall_Design_Test_Bench - Behavioral
-- Project Name: EENG 5550 Project 1

-- Description: A test nbench for a design which includes 4 quadrants and routers. Each quadrant has external data input source options.
-- The router is capable of sending and receiving data to and from different quadrant routers simultaneously.

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

entity Overall_Design_Test_Bench_1 is
--  Port ( );
end Overall_Design_Test_Bench_1;

architecture Behavioral of Overall_Design_Test_Bench_1 is
Constant d_w_c: integer := 8;
Constant cols_c: natural := 2;
Constant rows_c: natural := 2;
Constant blocks_c: natural := 4;
Signal Clocks: STD_LOGIC := '0';
Signal RW_Enable_Globals: STD_LOGIC;
Signal Q0_Ext_In_As, Q1_Ext_In_As, Q2_Ext_In_As, Q3_Ext_In_As: VectorArray_2d (0 to rows_c - 1)(0 to cols_c - 1)(d_w_c - 1 downto 0);
Signal Q0_Ext_In_Bs, Q1_Ext_In_Bs, Q2_Ext_In_Bs, Q3_Ext_In_Bs: VectorArray_2d (0 to rows_c - 1)(0 to cols_c - 1)(d_w_C - 1 downto 0);
Signal Q0_OpSels, Q1_OpSels, Q2_OpSels, Q3_OpSels: CUArray_2d (0 to rows_c - 1)(0 to cols_c - 1);
Signal Q0_A_Sels, Q1_A_Sels, Q2_A_Sels, Q3_A_Sels: BitArray_2d (0 to rows_c - 1)(0 to cols_c - 1);
Signal Q0_B_Sels, Q1_B_Sels, Q2_B_Sels, Q3_B_Sels: BitArray_2d (0 to rows_c - 1)(0 to cols_c - 1);
Signal Q0_Address_As, Q0_Address_Bs: VectorArray_1d (0 to blocks_c - 1)(3 downto 0);
Signal Q1_Address_As, Q1_Address_Bs: VectorArray_1d (0 to blocks_c - 1)(3 downto 0);
Signal Q2_Address_As, Q2_Address_Bs: VectorArray_1d (0 to blocks_c - 1)(3 downto 0);
Signal Q3_Address_As, Q3_Address_Bs: VectorArray_1d (0 to blocks_c - 1)(3 downto 0);
Signal Q0_Address_Globals, Q1_Address_Globals, Q2_Address_Globals, Q3_Address_Globals: STD_LOGIC_VECTOR (3 downto 0) := "1111";
Signal Global_to_Q0_Addresss, Global_to_Q1_Addresss, Global_to_Q2_Addresss, Global_to_Q3_Addresss: STD_LOGIC_VECTOR (3 downto 0) := "1111";
Signal Q0_RW_Enables, Q1_RW_Enables, Q2_RW_Enables, Q3_RW_Enables: STD_LOGIC;
Signal QR0_Global_Write_Enables, QR1_Global_Write_Enables, QR2_Global_Write_Enables, QR3_Global_Write_Enables: STD_LOGIC;

begin
Overall_Design_Inst: entity work.Overall_Design(Behavioral)
    Generic map (   d_w => d_w_c,
                    cols => cols_c,
                    rows => rows_c,
                    blocks => blocks_c)
                    
    Port map (  Q0_Ext_In_A => Q0_Ext_In_As, Q1_Ext_In_A => Q1_Ext_In_As, Q2_Ext_In_A => Q2_Ext_In_As, Q3_Ext_In_A => Q3_Ext_In_As,
                Q0_Ext_In_B => Q0_Ext_In_Bs, Q1_Ext_In_B => Q1_Ext_In_Bs, Q2_Ext_In_B => Q2_Ext_In_Bs, Q3_Ext_In_B => Q3_Ext_In_Bs,
                Q0_OpSel => Q0_OpSels, Q1_OpSel => Q1_OpSels, Q2_OpSel => Q2_OpSels, Q3_OpSel => Q3_OpSels,
                Q0_A_Sel => Q0_A_Sels, Q1_A_Sel => Q1_A_Sels, Q2_A_Sel => Q2_A_Sels, Q3_A_Sel => Q3_A_Sels,                  
                Q0_B_Sel => Q0_B_Sels, Q1_B_Sel => Q1_B_Sels, Q2_B_Sel => Q2_B_Sels, Q3_B_Sel => Q3_B_Sels,
                Q0_Address_A => Q0_Address_As, Q0_Address_B => Q0_Address_Bs,
                Q1_Address_A => Q1_Address_As, Q1_Address_B => Q1_Address_Bs,
                Q2_Address_A => Q2_Address_As, Q2_Address_B => Q2_Address_Bs,
                Q3_Address_A => Q3_Address_As, Q3_Address_B => Q3_Address_Bs,
                Q0_Address_Global => Q0_Address_Globals, Q1_Address_Global => Q1_Address_Globals, 
                Q2_Address_Global => Q2_Address_Globals, Q3_Address_Global => Q3_Address_Globals,
                Global_to_Q0_Address => Global_to_Q0_Addresss,
                Global_to_Q1_Address => Global_to_Q1_Addresss,
                Global_to_Q2_Address => Global_to_Q2_Addresss,
                Global_to_Q3_Address => Global_to_Q3_Addresss,
                Q0_RW_Enable => Q0_RW_Enables, Q1_RW_Enable => Q1_RW_Enables,
                Q2_RW_Enable => Q2_RW_Enables, Q3_RW_Enable => Q3_RW_Enables,
                QR0_Global_Write_Enable => QR0_Global_Write_Enables, 
                QR1_Global_Write_Enable => QR1_Global_Write_Enables, 
                QR2_Global_Write_Enable => QR2_Global_Write_Enables, 
                QR3_Global_Write_Enable => QR3_Global_Write_Enables,
                RW_Enable_Global => RW_Enable_Globals,
                Clock => Clocks 
                );

Clocks <= NOT Clocks after 5 ns; -- Toggle the clock every 5 ns

stim: process
begin


-----------------------------------------------------------------------------------------------------------------------------------------------------------------                               



---------------------------------------------------------------------- TEST CASE 1 ------------------------------------------------------------------------------



-----------------------------------------------------------------------------------------------------------------------------------------------------------------  






-- COMPUTING TEST CASE 1 STAGE 1 OPERATIONS
---------------------------------------------------------------------------------------------------------------------------------------------------------------
Q0_Ext_In_As <= (  (X"89", X"D8"),
                   (X"B5", X"E6"));

Q0_Ext_In_Bs <= (  (X"3D", X"32"),
                   (X"7D", X"AE"));                               

Q0_A_Sels <= (  ('0', '0'), -- All external inputs selected
                ('0', '0'));

Q0_B_Sels <= (  ('0', '0'), -- All external inputs selected
                ('0', '0'));
                                   
Q0_RW_Enables <= '1'; -- Storage units are in write mode; operands are stored in local storages
wait for 5 ns;

Q0_RW_Enables <= '0'; -- Storage units are in read mode; operands are sent to computation unit
wait for 15 ns;
 
Q0_OpSels <= (    (aADD, rRSR),
                  (lXOR, lAND));
                  
Q0_RW_Enables <= '1'; -- Storage units are in write mode;
wait for 5 ns;

Q0_RW_Enables <= '0'; -- Storage units are in read mode; results are sent to local storages
wait for 15 ns; 

Q0_RW_Enables <= '1'; -- Quadrant 0 router is in write mode; results are stored in local storages
wait for 5 ns;

Q0_RW_Enables <= '0'; -- Storage units are in read mode;
wait for 15 ns;

---------------------------------------------------------------------------------------------------------------------------------------------------------------





-- TRANSFER OF QUADRANT 0 RESULTS TO GLOBAL ROUTER
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
QR0_Global_Write_Enables <= '0'; -- read mode
Q0_Address_Globals <= "0000"; 
wait for 5 ns;

RW_Enable_Globals <= '1'; -- write mode
Global_to_Q0_Addresss <= "0000";
wait for 15 ns;

QR0_Global_Write_Enables <= '0'; -- read mode
Q0_Address_Globals <= "0001"; 
wait for 5 ns;

RW_Enable_Globals <= '1'; -- write mode
Global_to_Q0_Addresss <= "0001";
wait for 15 ns;

QR0_Global_Write_Enables <= '0'; -- read mode
Q0_Address_Globals <= "0010"; 
wait for 5 ns;

RW_Enable_Globals <= '1'; -- write mode
Global_to_Q0_Addresss <= "0010";
wait for 15 ns;

QR0_Global_Write_Enables <= '0'; -- read mode
Q0_Address_Globals <= "0011"; 
wait for 5 ns;

RW_Enable_Globals <= '1'; -- write mode
Global_to_Q0_Addresss <= "0011";
wait for 15 ns;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------





-- TRANSFER OF QUADRANT 0 RESULTS FROM GLOBAL ROUTER TO QUADRANT 1
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
RW_Enable_Globals <= '0'; -- read mode
Global_to_Q1_Addresss <= "0000";
Q1_Address_Globals <= "0100"; 
wait for 5 ns;

QR1_Global_Write_Enables <= '1'; -- write mode
Q1_RW_Enables <= '1';
wait for 15 ns;

RW_Enable_Globals <= '0'; -- read mode
Global_to_Q1_Addresss <= "0001";
Q1_Address_Globals <= "0101"; 
wait for 5ns;

QR1_Global_Write_Enables <= '1'; -- write mode
wait for 15 ns;

RW_Enable_Globals <= '0'; -- read mode
Global_to_Q1_Addresss <= "0010";
Q1_Address_Globals <= "0110";
wait for 5ns;

QR1_Global_Write_Enables <= '1'; -- write mode 
wait for 15 ns;

RW_Enable_Globals <= '0'; -- read mode
Global_to_Q1_Addresss <= "0011";
Q1_Address_Globals <= "0111"; 
wait for 5ns;

QR1_Global_Write_Enables <= '1'; -- write mode
wait for 15 ns;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------





-- COMPUTING TEST CASE 1 STAGE 2 OPERATIONS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------                               
Q1_Address_As <= (("0101"),
                  ("ZZZZ"),
                  ("ZZZZ"),
                  ("0100"));

Q1_Address_Bs <= (("0111"),
                  ("ZZZZ"),
                  ("ZZZZ"),
                  ("0110"));

Q1_RW_Enables <= '1'; -- Storage units are in write mode;
wait for 5 ns;

Q1_RW_Enables <= '0'; -- Storage units are in read mode;
wait for 15 ns;

Q1_RW_Enables <= '1'; -- Storage units are in write mode; operands are stored in local storages
wait for 5 ns;

Q1_RW_Enables <= '0'; -- Storage units are in read mode; operands are sent to computation unit
wait for 15 ns;

Q1_A_Sels <= (  ('1', '1'), -- All internal inputs selected
                ('1', '1'));

Q1_B_Sels <= (  ('1', '1'), -- All internal inputs selected
                ('1', '1'));  

Q1_OpSels <= (    (rRSL, NoOp),
                  (NoOp, aSUB));

Q1_RW_Enables <= '1'; -- Storage units are in write mode;
wait for 5 ns;

Q1_RW_Enables <= '0'; -- Storage units are in read mode; results are sent to local storages
wait for 15 ns; 

Q1_RW_Enables <= '1'; -- Quadrant 1 router is in write mode; results are stored in registers
wait for 5 ns;

Q1_RW_Enables <= '0'; -- Storage units are in read mode;
wait for 15 ns;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------                               





-- COMPUTING TEST CASE 1 STAGE 3 OPERATIONS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------                               
Q1_Address_As <= (("0000"),
                  ("0111"),
                  ("0100"),
                  ("ZZZZ"));

Q1_Address_Bs <= (("ZZZZ"),
                  ("0100"),
                  ("0111"),
                  ("0011"));

Q1_RW_Enables <= '1'; -- Storage units are in write mode;
wait for 5 ns;

Q1_RW_Enables <= '0'; -- Storage units are in read mode;
wait for 15 ns;

Q1_RW_Enables <= '1'; -- Storage units are in write mode; operands are stored in local storages
wait for 5 ns;

Q1_RW_Enables <= '0'; -- Storage units are in read mode; operands are sent to computation unit
wait for 15 ns;

Q1_A_Sels <= (  ('1', '1'), -- All internal inputs selected
                ('1', '1'));

Q1_B_Sels <= (  ('1', '1'), -- All internal inputs selected
                ('1', '1'));  

Q1_OpSels <= (    (PassA, lOR),
                  (LXNOR, PassB));

Q1_RW_Enables <= '1'; -- Storage units are in write mode;
wait for 5 ns;

Q1_RW_Enables <= '0'; -- Storage units are in read mode; results are sent to local storages
wait for 15 ns; 

Q1_RW_Enables <= '1'; -- Quadrant 1 router is in write mode; results are stored in registers
wait for 5 ns;

Q1_RW_Enables <= '0'; -- Storage units are in read mode;
wait for 15 ns;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------     





-- TRANSFER OF QUADRANT 1 RESULTS TO GLOBAL ROUTER
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
QR1_Global_Write_Enables <= '0'; -- read mode
Q1_Address_Globals <= "0000"; 
wait for 5 ns;

RW_Enable_Globals <= '1'; -- write mode
Global_to_Q1_Addresss <= "0100";
wait for 15 ns;

QR1_Global_Write_Enables <= '0'; -- read mode
Q1_Address_Globals <= "0001"; 
wait for 5 ns;

RW_Enable_Globals <= '1'; -- write mode
Global_to_Q1_Addresss <= "0101";
wait for 15 ns;

QR1_Global_Write_Enables <= '0'; -- read mode
Q1_Address_Globals <= "0010"; 
wait for 5 ns;

RW_Enable_Globals <= '1'; -- write mode
Global_to_Q1_Addresss <= "0110";
wait for 15 ns;

QR1_Global_Write_Enables <= '0'; -- read mode
Q1_Address_Globals <= "0011"; 
wait for 5 ns;

RW_Enable_Globals <= '1'; -- write mode
Global_to_Q1_Addresss <= "0111";
wait for 15 ns;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------





-- TRANSFER OF QUADRANT 1 RESULTS FROM GLOBAL ROUTER TO QUADRANT 3
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
RW_Enable_Globals <= '0'; -- read mode
Global_to_Q3_Addresss <= "0100";
Q3_Address_Globals <= "0100"; 
wait for 5 ns;

QR3_Global_Write_Enables <= '1'; -- write mode
Q3_RW_Enables <= '1';
wait for 15 ns;

RW_Enable_Globals <= '0'; -- read mode
Global_to_Q3_Addresss <= "0101";
Q3_Address_Globals <= "0101"; 
wait for 5ns;

QR3_Global_Write_Enables <= '1'; -- write mode
wait for 15 ns;

RW_Enable_Globals <= '0'; -- read mode
Global_to_Q3_Addresss <= "0110";
Q3_Address_Globals <= "0110";
wait for 5ns;

QR3_Global_Write_Enables <= '1'; -- write mode 
wait for 15 ns;

RW_Enable_Globals <= '0'; -- read mode
Global_to_Q3_Addresss <= "0111";
Q3_Address_Globals <= "0111"; 
wait for 5ns;

QR3_Global_Write_Enables <= '1'; -- write mode
wait for 15 ns;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------





-- COMPUTING TEST CASE 1 STAGE 4 OPERATIONS
---------------------------------------------------------------------------------------------------------------------------------------------------------------
Q3_Ext_In_As <= (  (X"ZZ", X"ZZ"),
                   (X"ZZ", X"F3"));

Q3_Ext_In_Bs <= (  (X"ZZ", X"ZZ"),
                   (X"ZZ", X"06"));                               

Q3_A_Sels <= (  ('1', '0'), -- All required internal inputs selected
                ('0', '0'));

Q3_B_Sels <= (  ('1', '0'), -- All required internal inputs selected except
                ('0', '0'));

Q3_Address_As <= (("0110"),
                  ("ZZZZ"),
                  ("ZZZZ"),
                  ("ZZZZ"));

Q3_Address_Bs <= (("0101"),
                  ("ZZZZ"),
                  ("ZZZZ"),
                  ("ZZZZ"));
                  
                                   
Q3_RW_Enables <= '1'; -- Storage units are in write mode; operands are stored in local storages
wait for 5 ns;

Q3_RW_Enables <= '0'; -- Storage units are in read mode; operands are sent to computation unit
wait for 15 ns;
 
Q3_OpSels <= (    (lNAND, NoOp),
                  (NoOp, rLSL));
                  
Q3_RW_Enables <= '1'; -- Storage units are in write mode;
wait for 5 ns;

Q3_RW_Enables <= '0'; -- Storage units are in read mode; results are sent to local storages
wait for 15 ns; 

Q3_RW_Enables <= '1'; 
wait for 5 ns;

Q3_RW_Enables <= '0'; 
wait for 15 ns;

Q3_RW_Enables <= '1';-- Quadrant 0 router is in write mode; results are stored in local storages
wait for 5 ns;

Q3_RW_Enables <= '0'; -- Storage units are in read mode;
wait for 15 ns;
---------------------------------------------------------------------------------------------------------------------------------------------------------------





-- TRANSFER OF QUADRANT 1 RESULTS TO GLOBAL ROUTER
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
QR3_Global_Write_Enables <= '0'; -- read mode
Q3_Address_Globals <= "0000"; 
wait for 5 ns;

RW_Enable_Globals <= '1'; -- write mode
Global_to_Q3_Addresss <= "1100";
wait for 15 ns;

QR3_Global_Write_Enables <= '0'; -- read mode
Q3_Address_Globals <= "0001"; 
wait for 5 ns;

RW_Enable_Globals <= '1'; -- write mode
Global_to_Q3_Addresss <= "1101";
wait for 15 ns;

QR3_Global_Write_Enables <= '0'; -- read mode
Q3_Address_Globals <= "0010"; 
wait for 5 ns;

RW_Enable_Globals <= '1'; -- write mode
Global_to_Q3_Addresss <= "1110";
wait for 15 ns;

QR3_Global_Write_Enables <= '0'; -- read mode
Q3_Address_Globals <= "0011"; 
wait for 5 ns;

RW_Enable_Globals <= '1'; -- write mode
Global_to_Q3_Addresss <= "1111";
wait for 15 ns;
---------------------------------------------------------------------------------------------------------------------------------------------------------------*/







-----------------------------------------------------------------------------------------------------------------------------------------------------------------                               



---------------------------------------------------------------------- TEST CASE 2 ------------------------------------------------------------------------------



-----------------------------------------------------------------------------------------------------------------------------------------------------------------                               
/*










-- COMPUTING TEST CASE 2 STAGE 1 OPERATIONS
---------------------------------------------------------------------------------------------------------------------------------------------------------------
Q2_Ext_In_As <= (  (X"1B", X"FF"),
                   (X"00", X"AE"));

Q2_Ext_In_Bs <= (  (X"37", X"04"),
                   (X"00", X"E7"));                               

Q2_A_Sels <= (  ('0', '0'), -- All external inputs selected except (1,0)
                ('1', '0'));

Q2_B_Sels <= (  ('0', '0'), -- All external inputs selected except (1,0)
                ('1', '0'));

Q3_Ext_In_As <= (  (X"1B", X"00"),
                   (X"2D", X"DF"));

Q3_Ext_In_Bs <= (  (X"09", X"00"),
                   (X"6F", X"03"));                               

Q3_A_Sels <= (  ('0', '1'), -- All external inputs selected except (0,1)
                ('0', '0'));

Q3_B_Sels <= (  ('0', '1'), -- All external inputs selected except (0,1)
                ('0', '0'));                
                                   
Q2_RW_Enables <= '1'; -- Storage units are in write mode; operands are stored in local storages
Q3_RW_Enables <= '1'; -- Storage units are in write mode; operands are stored in local storages
wait for 5 ns;

Q2_RW_Enables <= '0'; -- Storage units are in write mode; operands are stored in local storages
Q3_RW_Enables <= '0'; -- Storage units are in write mode; operands are stored in local storages
wait for 15 ns;
 
Q2_OpSels <= (    (aADD, rLSL),
                  (NoOp, lXNOR));

Q3_OpSels <= (    (aMULT, NoOp),
                  (aADD, rLSR));                  
                  
Q2_RW_Enables <= '1'; -- Storage units are in write mode;
Q3_RW_Enables <= '1'; -- Storage units are in write mode;
wait for 5 ns;

Q2_RW_Enables <= '0'; -- Storage units are in read mode; results are sent to local storages
Q3_RW_Enables <= '0'; -- Storage units are in read mode; results are sent to local storages
wait for 15 ns; 

Q2_RW_Enables <= '1'; -- Quadrant 0 router is in write mode; results are stored in local storages
Q3_RW_Enables <= '1'; -- Quadrant 0 router is in write mode; results are stored in local storages
wait for 5 ns;

Q2_RW_Enables <= '0'; -- Storage units are in read mode;
Q3_RW_Enables <= '0'; -- Storage units are in read mode;
wait for 15 ns;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------





-- TRANSFER OF QUADRANT 2 & 3 RESULTS TO GLOBAL ROUTER
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
QR2_Global_Write_Enables <= '0'; -- read mode
QR3_Global_Write_Enables <= '0'; -- read mode
Q2_Address_Globals <= "0000";
Q3_Address_Globals <= "0000"; 
wait for 5 ns;

RW_Enable_Globals <= '1'; -- write mode
Global_to_Q2_Addresss <= "1000";
Global_to_Q3_Addresss <= "1100";
wait for 15 ns;

QR2_Global_Write_Enables <= '0'; -- read mode
QR3_Global_Write_Enables <= '0'; -- read mode
Q2_Address_Globals <= "0001";
Q3_Address_Globals <= "0001"; 
wait for 5 ns;

RW_Enable_Globals <= '1'; -- write mode
Global_to_Q2_Addresss <= "1001";
Global_to_Q3_Addresss <= "1101";
wait for 15 ns;

QR2_Global_Write_Enables <= '0'; -- read mode
QR3_Global_Write_Enables <= '0'; -- read mode
Q2_Address_Globals <= "0010";
Q3_Address_Globals <= "0010"; 
wait for 5 ns;

RW_Enable_Globals <= '1'; -- write mode
Global_to_Q2_Addresss <= "1010";
Global_to_Q3_Addresss <= "1110";
wait for 15 ns;

QR2_Global_Write_Enables <= '0'; -- read mode
QR3_Global_Write_Enables <= '0'; -- read mode
Q2_Address_Globals <= "0011";
Q3_Address_Globals <= "0011";  
wait for 5 ns;

RW_Enable_Globals <= '1'; -- write mode
Global_to_Q2_Addresss <= "1011";
Global_to_Q3_Addresss <= "1111";
wait for 15 ns;

RW_Enable_Globals <= '0'; -- read mode
wait for 5 ns;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------





-- TRANSFER OF QUADRANT 2 & 3 RESULTS FROM GLOBAL ROUTER TO QUADRANT 1
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
RW_Enable_Globals <= '0'; -- read mode
Global_to_Q1_Addresss <= "1000";
wait for 15 ns;

QR1_Global_Write_Enables <= '1'; -- write mode
Q1_RW_Enables <= '1';
Q1_Address_Globals <= "1000"; 
wait for 5 ns;

RW_Enable_Globals <= '0'; -- read mode
Global_to_Q1_Addresss <= "1001";
wait for 15ns;

QR1_Global_Write_Enables <= '1'; -- write mode
Q1_Address_Globals <= "1001"; 
wait for 5 ns;

RW_Enable_Globals <= '0'; -- read mode
Global_to_Q1_Addresss <= "1010";
wait for 15ns;

QR1_Global_Write_Enables <= '1'; -- write mode
Q1_Address_Globals <= "1010"; 
wait for 5 ns;

RW_Enable_Globals <= '0'; -- read mode
Global_to_Q1_Addresss <= "1011";
wait for 15ns;

QR1_Global_Write_Enables <= '1'; -- write mode
Q1_Address_Globals <= "1011"; 
wait for 5 ns;

RW_Enable_Globals <= '0'; -- read mode
Global_to_Q1_Addresss <= "1100";
wait for 15ns;

QR1_Global_Write_Enables <= '1'; -- write mode
Q1_Address_Globals <= "1100"; 
wait for 5 ns;

RW_Enable_Globals <= '0'; -- read mode
Global_to_Q1_Addresss <= "1101";
wait for 15ns;

QR1_Global_Write_Enables <= '1'; -- write mode
Q1_Address_Globals <= "1101"; 
wait for 5 ns;

RW_Enable_Globals <= '0'; -- read mode
Global_to_Q1_Addresss <= "1110";
wait for 15ns;

QR1_Global_Write_Enables <= '1'; -- write mode
Q1_Address_Globals <= "1110"; 
wait for 5 ns;

RW_Enable_Globals <= '0'; -- read mode
Global_to_Q1_Addresss <= "1111";
wait for 15ns;

QR1_Global_Write_Enables <= '1'; -- write mode
Q1_Address_Globals <= "1111"; 
wait for 5 ns;

RW_Enable_Globals <= '0'; -- read mode
wait for 15ns;

QR1_Global_Write_Enables <= '1'; -- write mode 
wait for 5 ns;

QR1_Global_Write_Enables <= '0'; -- read mode
RW_Enable_Globals <= '1'; -- read mode
wait for 15ns;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------





-- COMPUTING TEST CASE 2 STAGE 2 OPERATIONS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------                               
Q1_Address_As <= (("1000"),
                  ("ZZZZ"),
                  ("1001"),
                  ("1011"));

Q1_Address_Bs <= (("1100"),
                  ("ZZZZ"),
                  ("1110"),
                  ("1111"));

Q1_RW_Enables <= '1'; -- Storage units are in write mode;
wait for 5 ns;

Q1_RW_Enables <= '0'; -- Storage units are in read mode;
wait for 15 ns;

Q1_RW_Enables <= '1'; -- Storage units are in write mode; operands are stored in local storages
wait for 5 ns;

Q1_RW_Enables <= '0'; -- Storage units are in read mode; operands are sent to computation unit
wait for 15 ns;

Q1_A_Sels <= (  ('1', '0'), -- All required external inputs selected
                ('1', '1'));

Q1_B_Sels <= (  ('1', '0'), -- All required external inputs selected
                ('1', '1'));  

Q1_OpSels <= (    (rRSR, NoOp),
                  (lAND, aSUB));

Q1_RW_Enables <= '1'; -- Storage units are in write mode;
wait for 5 ns;

Q1_RW_Enables <= '0'; -- Storage units are in read mode; results are sent to local storages
wait for 15 ns; 

Q1_RW_Enables <= '1'; -- Quadrant 1 router is in write mode; results are stored in local storages
wait for 5 ns;

Q1_RW_Enables <= '0'; -- Storage units are in read mode;
wait for 15 ns;

Q1_RW_Enables <= '1';
wait for 5 ns;

Q1_RW_Enables <= '0'; 
wait for 15 ns;

Q1_RW_Enables <= '1';
wait for 5 ns;

Q1_RW_Enables <= '0'; 
wait for 15 ns;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------     





-- TRANSFER OF QUADRANT 1 RESULTS TO GLOBAL ROUTER
-----------------------------------------------------------------------------------------------------------------------------------------------------------------    
QR1_Global_Write_Enables <= '0'; -- read mode
Q1_Address_Globals <= "0000";
Global_to_Q1_Addresss <= "0100";
wait for 5 ns;

RW_Enable_Globals <= '1'; -- write mode
wait for 15ns;

QR1_Global_Write_Enables <= '0'; -- read mode;
Q1_Address_Globals <= "0001";
Global_to_Q1_Addresss <= "0101";
wait for 5 ns;

RW_Enable_Globals <= '1'; -- write mode
wait for 15ns;

QR1_Global_Write_Enables <= '0'; -- read mode
Q1_Address_Globals <= "0010";
Global_to_Q1_Addresss <= "0110";
wait for 5 ns;

RW_Enable_Globals <= '1'; -- write mode
wait for 15ns;

QR1_Global_Write_Enables <= '0'; -- read mode;
Q1_Address_Globals <= "0011";
Global_to_Q1_Addresss <= "0111";
wait for 5 ns;

RW_Enable_Globals <= '1'; -- write mode
wait for 15ns;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------     





-- TRANSFER OF QUADRANT 1 RESULTS FROM GLOBAL ROUTER TO QUADRANT 0
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
RW_Enable_Globals <= '0'; -- read mode
Global_to_Q0_Addresss <= "0100";
Q0_Address_Globals <= "0100";
wait for 5 ns;

QR0_Global_Write_Enables <= '1'; -- write mode
Q0_RW_Enables <= '1'; -- write mode
wait for 15 ns;

RW_Enable_Globals <= '0'; -- read mode
Global_to_Q0_Addresss <= "0101";
Q0_Address_Globals <= "0101";
wait for 5 ns;

QR0_Global_Write_Enables <= '1'; -- write mode
Q0_RW_Enables <= '1'; -- write mode
wait for 15 ns;

RW_Enable_Globals <= '0'; -- read mode
Global_to_Q0_Addresss <= "0110";
Q0_Address_Globals <= "0110";
wait for 5 ns;

QR0_Global_Write_Enables <= '1'; -- write mode
Q0_RW_Enables <= '1'; -- write mode
wait for 15 ns;

RW_Enable_Globals <= '0'; -- read mode
Global_to_Q0_Addresss <= "0111";
Q0_Address_Globals <= "0111";
wait for 5 ns;

QR0_Global_Write_Enables <= '1'; -- write mode
Q0_RW_Enables <= '1'; -- write mode
wait for 15 ns;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------





-- COMPUTING TEST CASE 2 STAGE 3 OPERATIONS
---------------------------------------------------------------------------------------------------------------------------------------------------------------
Q0_Ext_In_As <= (  (X"ZZ", X"ZZ"),
                   (X"ZZ", X"ZZ"));

Q0_Ext_In_Bs <= (  (X"04", X"ZZ"),
                   (X"ZZ", X"ZZ"));                               

Q0_A_Sels <= (  ('1', '0'), -- All required internal inputs selected
                ('1', '0'));

Q0_B_Sels <= (  ('0', '0'), -- All required internal inputs selected except (0,0)
                ('1', '0'));

Q0_Address_As <= (("0111"),
                  ("ZZZZ"),
                  ("0100"),
                  ("ZZZZ"));

Q0_Address_Bs <= (("ZZZZ"),
                  ("ZZZZ"),
                  ("0110"),
                  ("ZZZZ"));
                  
                                   
Q0_RW_Enables <= '1'; -- Storage units are in write mode; operands are stored in local storages
wait for 5 ns;

Q0_RW_Enables <= '0'; -- Storage units are in read mode; operands are sent to computation unit
wait for 15 ns;
 
Q0_OpSels <= (    (rLSL, NoOp),
                  (aADD, NoOp));
                  
Q0_RW_Enables <= '1'; -- Storage units are in write mode;
wait for 5 ns;

Q0_RW_Enables <= '0'; -- Storage units are in read mode; results are sent to local storages
wait for 15 ns; 

Q0_RW_Enables <= '1'; -- Quadrant 0 router is in write mode; results are stored in local storages
wait for 5 ns;

Q0_RW_Enables <= '0'; -- Storage units are in read mode;
wait for 15 ns;

Q0_RW_Enables <= '1';
wait for 5 ns;

Q0_RW_Enables <= '0'; 
wait for 15 ns;
---------------------------------------------------------------------------------------------------------------------------------------------------------------





-- TRANSFER OF QUADRANT 0 RESULTS TO GLOBAL ROUTER
-----------------------------------------------------------------------------------------------------------------------------------------------------------------    
QR0_Global_Write_Enables <= '0'; -- read mode
Q0_Address_Globals <= "0000";
Global_to_Q0_Addresss <= "0000";
wait for 5 ns;

RW_Enable_Globals <= '1'; -- write mode
wait for 15ns;

QR0_Global_Write_Enables <= '0'; -- read mode;
Q0_Address_Globals <= "0001";
Global_to_Q0_Addresss <= "0001";
wait for 5 ns;

RW_Enable_Globals <= '1'; -- write mode
wait for 15ns;

QR0_Global_Write_Enables <= '0'; -- read mode
Q0_Address_Globals <= "0010";
Global_to_Q0_Addresss <= "0010";
wait for 5 ns;

RW_Enable_Globals <= '1'; -- write mode
wait for 15ns;

QR0_Global_Write_Enables <= '0'; -- read mode;
Q0_Address_Globals <= "0011";
Global_to_Q0_Addresss <= "0011";
wait for 5 ns;

RW_Enable_Globals <= '1'; -- write mode
wait for 15ns;*/


finish;
end process stim;                 
                
end Behavioral;
