----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/01/2026 05:33:53 PM
-- Design Name: 
-- Module Name: Matrix_Accelerator_Test_Bench - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.ENV.FINISH;
use WORK.ARRAY_CUSTOM_PACK.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Matrix_Accelerator_Test_Bench is
--  Port ( );
end Matrix_Accelerator_Test_Bench;

architecture Behavioral of Matrix_Accelerator_Test_Bench is
Constant Rows               : INTEGER := 2;
Constant Cols               : INTEGER := 2;
Constant Input_Widths       : INTEGER := 8;
Constant Accumulator_Widths : INTEGER := 32;
Constant Clock_Period       : TIME    := 10 ns;

Signal Clocks               : STD_LOGIC := '0';
Signal Resets               : STD_LOGIC := '0';
Signal Starts               : STD_LOGIC := '0';
Signal Dones                : STD_LOGIC;

Signal A_Write_Ens          : STD_LOGIC := '0';
Signal A_Write_Rows         : INTEGER range 0 to Rows - 1 := 0;
Signal A_Write_Cols         : INTEGER range 0 to Cols - 1 := 0;
Signal A_Write_Datas        : SIGNED(Input_Widths - 1 downto 0) := (others => '0');

Signal B_Write_Ens          : STD_LOGIC := '0';
Signal B_Write_Rows         : INTEGER range 0 to Rows - 1 := 0;
Signal B_Write_Cols         : INTEGER range 0 to Cols - 1 := 0;
Signal B_Write_Datas        : SIGNED(Input_Widths - 1 downto 0) := (others => '0');

Signal Outputs              : SignedArray_2d(0 to Rows - 1)(0 to Cols - 1)(Accumulator_Widths - 1 downto 0);

begin

MA_Inst : entity work.Matrix_Accelerator(Behavioral)
    Generic map (   Rows              => Rows,
                    Cols              => Cols,
                    Input_Width       => Input_Widths,
                    Accumulator_Width => Accumulator_Widths
                )
    Port map    (   Clock             => Clocks,
                    Reset             => Resets,
                    Start             => Starts,
                    Done              => Dones,
                    A_Write_En        => A_Write_Ens,
                    A_Write_Row       => A_Write_Rows,
                    A_Write_Col       => A_Write_Cols,
                    A_Write_Data      => A_Write_Datas,
                    B_Write_En        => B_Write_Ens,
                    B_Write_Row       => B_Write_Rows,
                    B_Write_Col       => B_Write_Cols,
                    B_Write_Data      => B_Write_Datas,
                    Output            => Outputs
                );

Clock_Process : process
begin
    Clocks <= '0';
    wait for Clock_Period / 2;
    Clocks <= '1';
    wait for Clock_Period / 2;
end process;

Stim_Proc : process
begin

-----------------------------------------------------------------------------------------------------------------------
--                                                      TEST 1                                                       --
--                                                                                                                   --
--        A = | 1  2 |       B = | 5  6 |       C = | 19  22 |                                                      --
--            | 3  4 |           | 7  8 |           | 43  50 |                                                      --
-----------------------------------------------------------------------------------------------------------------------

    -- Reset
    Resets  <= '1';
    wait for Clock_Period;
    Resets  <= '0';
    wait for Clock_Period;

    -- Write Matrix A
    A_Write_Ens <= '1';

    A_Write_Rows <= 0; A_Write_Cols <= 0; A_Write_Datas <= to_signed(1, Input_Widths); wait for Clock_Period;
    A_Write_Rows <= 0; A_Write_Cols <= 1; A_Write_Datas <= to_signed(2, Input_Widths); wait for Clock_Period;
    A_Write_Rows <= 1; A_Write_Cols <= 0; A_Write_Datas <= to_signed(3, Input_Widths); wait for Clock_Period;
    A_Write_Rows <= 1; A_Write_Cols <= 1; A_Write_Datas <= to_signed(4, Input_Widths); wait for Clock_Period;

    A_Write_Ens <= '0';

    -- Write Matrix B
    B_Write_Ens <= '1';

    B_Write_Rows <= 0; B_Write_Cols <= 0; B_Write_Datas <= to_signed(5, Input_Widths); wait for Clock_Period;
    B_Write_Rows <= 0; B_Write_Cols <= 1; B_Write_Datas <= to_signed(6, Input_Widths); wait for Clock_Period;
    B_Write_Rows <= 1; B_Write_Cols <= 0; B_Write_Datas <= to_signed(7, Input_Widths); wait for Clock_Period;
    B_Write_Rows <= 1; B_Write_Cols <= 1; B_Write_Datas <= to_signed(8, Input_Widths); wait for Clock_Period;

    B_Write_Ens <= '0';
    wait for Clock_Period;

    -- Pulse Start
    Starts  <= '1';
    wait for Clock_Period;
    Starts  <= '0';

    -- Wait for Done
    wait until Dones = '1';
    wait for Clock_Period;

    -- Check results
    assert (Outputs(0)(0) = to_signed(19, Accumulator_Widths))
        report "TEST 1a FAILED: C(0,0) expected 19, got " & integer'image(to_integer(Outputs(0)(0)))
    severity error;

    assert (Outputs(0)(1) = to_signed(22, Accumulator_Widths))
        report "TEST 1b FAILED: C(0,1) expected 22, got " & integer'image(to_integer(Outputs(0)(1)))
    severity error;

    assert (Outputs(1)(0) = to_signed(43, Accumulator_Widths))
        report "TEST 1c FAILED: C(1,0) expected 43, got " & integer'image(to_integer(Outputs(1)(0)))
    severity error;

    assert (Outputs(1)(1) = to_signed(50, Accumulator_Widths))
        report "TEST 1d FAILED: C(1,1) expected 50, got " & integer'image(to_integer(Outputs(1)(1)))
    severity error;

-----------------------------------------------------------------------------------------------------------------------
--                                                          DONE                                                     --
-----------------------------------------------------------------------------------------------------------------------

    report "All Matrix Accelerator tests completed."
    severity note;

    finish;
end process;

end Behavioral;