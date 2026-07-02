----------------------------------------------------------------------------------
-- Engineer: Olasubomi Borishade
-- 
-- Create Date: 05/30/2026 12:35:48 AM
-- Design Name: MAC Unit Test Bench
-- Module Name: MAC_Unit_Test_Bench - Behavioral
-- Project Name: Parameterized Matrix Multiply Engine

-- Description: Test bench for a fundamental digital circuit that computes the  
--              product of two numbers and adds the result to an accumulator.
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


-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MAC_Unit_Test_Bench is
--  Port ( );
end MAC_Unit_Test_Bench;

architecture Behavioral of MAC_Unit_Test_Bench is
Constant Input_Widths       : INTEGER   := 8;
Constant Accumulator_Widths : INTEGER   := 32;
Constant Clock_Period       : TIME      := 10 ns;
    
Signal Input_As             : SIGNED (Input_Widths - 1 downto 0) := (others => '0');
Signal Input_Bs             : SIGNED (Input_Widths - 1 downto 0) := (others => '0');
 
Signal Clocks               : STD_lOGIC := '0';
Signal Resets               : STD_lOGIC := '0';
Signal Enables              : STD_lOGIC := '0';
Signal Clear_Accumulators   : STD_lOGIC := '0';
Signal Outputs              : SIGNED (Accumulator_Widths - 1 downto 0) := (others => '0');

begin

MAC_Unit_Inst: entity work.Mac_Unit(Behavioral)
    Generic map (   Input_Width         => Input_Widths,
                    Accumulator_Width   => Accumulator_Widths
                    )
    
    Port map    (   Input_A             => Input_As,
                    Input_B             => Input_Bs,
                    Clock               => Clocks,
                    Reset               => Resets,
                    Clear_Accumulator   => Clear_Accumulators,
                    Enable              => Enables,                  
                    Output              => Outputs
                    );                         
                        
    Clock_process : process
    begin
        Clocks <= '0';
        wait for Clock_Period / 2;
        Clocks <= '1';
        wait for Clock_Period / 2;
    end process;
        
    Stimulus: Process
    begin

-----------------------------------------------------------------------------------------------------------------------
    
--                                                      TEST 1                                                       --
    
-----------------------------------------------------------------------------------------------------------------------
        
        Resets      <= '1';
        wait for Clock_Period;
        Resets      <= '0';
        wait for Clock_Period;
        
        Enables     <= '1';
        Input_As    <= to_signed(3, Input_Widths);
        Input_Bs    <= to_signed(4, Input_Widths);
        wait for Clock_Period;
        
        Input_As    <= to_signed(0, Input_Widths);
        Input_Bs    <= to_signed(0, Input_Widths);
        Enables     <= '0';
        wait for Clock_Period;
        
        assert (signed(Outputs) = to_signed(12, Accumulator_Widths))
            report "TEST 1 FAILED: Expected 12, got " & integer'image(to_integer(signed(Outputs)))
        severity error;
    



-----------------------------------------------------------------------------------------------------------------------
    
--                                                      TEST 2                                                       --
    
-----------------------------------------------------------------------------------------------------------------------    
        
        Enables     <= '1';        
        Input_As    <= to_signed(2, Input_Widths);
        Input_Bs    <= to_signed(3, Input_Widths);
        wait for Clock_Period;
        
        Clear_Accumulators <= '1';
        wait for Clock_period;
        
        Clear_Accumulators <= '0';
        Input_As    <= to_signed(4, Input_Widths);
        Input_Bs    <= to_signed(5, Input_Widths);
        wait for Clock_Period;
        
        Input_As    <= to_signed(6, Input_Widths);
        Input_Bs    <= to_signed(7, Input_Widths);
        wait for Clock_Period;
        
        Input_As    <= to_signed(8, Input_Widths);
        Input_Bs    <= to_signed(9, Input_Widths);
        wait for Clock_Period;
        
        Input_As    <= to_signed(0, Input_Widths);
        Input_Bs    <= to_signed(0, Input_Widths);
        Enables     <= '0';
        wait for Clock_Period;
        
        assert (signed(Outputs) = to_signed(134, Accumulator_Widths))
            report "TEST 2 FAILED: Expected 134, got " & integer'image(to_integer(signed(Outputs)))
        severity error;
        
       
       
        
-----------------------------------------------------------------------------------------------------------------------
    
--                                                      TEST 3                                                       --
    
-----------------------------------------------------------------------------------------------------------------------    

        Clear_Accumulators <= '1';
        wait for Clock_Period;  
        
        assert (signed(Outputs) = to_signed(0, Accumulator_Widths))
            report "TEST 3 FAILED: Expected 0 after clear, got " & integer'image(to_integer(signed(Outputs)))
            severity error;
        
    
    
    
-----------------------------------------------------------------------------------------------------------------------
    
--                                                      TEST 4                                                       --
    
-----------------------------------------------------------------------------------------------------------------------    

        Clear_Accumulators <= '0';
        Enables     <= '1';      
        Input_As    <= to_signed(-3, Input_Widths);
        Input_Bs    <= to_signed(4, Input_Widths);
        wait for Clock_Period;
          
        Input_As    <= to_signed(0, Input_Widths);
        Input_Bs    <= to_signed(0, Input_Widths);
        Enables     <= '0';
        wait for Clock_Period;

        assert (signed(Outputs) = to_signed(-12, Accumulator_Widths))
            report "TEST 4 FAILED: Expected -12, got " & integer'image(to_integer(signed(Outputs)))
        severity error;
    
    
    
    
-----------------------------------------------------------------------------------------------------------------------
    
--                                                          DONE                                                     --
    
-----------------------------------------------------------------------------------------------------------------------    
    
        report "All MAC unit tests completed." 
        severity note;
           
        finish;
    end process;                                    
end Behavioral;
