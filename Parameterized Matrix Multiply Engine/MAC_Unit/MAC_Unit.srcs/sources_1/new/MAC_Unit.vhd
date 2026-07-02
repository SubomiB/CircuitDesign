----------------------------------------------------------------------------------
-- Engineer: Olasubomi Borishade
-- 
-- Create Date: 05/29/2026 11:23:00 PM
-- Design Name: MAC Unit
-- Module Name: MAC_Unit - Behavioral
-- Project Name: Parameterized Matrix Multiply Engine

-- Description: Fundamental digital circuit that computes the product of 
--              two numbers and adds the result to an internal accumulator.
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MAC_Unit is

Generic (   Input_Width         : INTEGER := 8;
            Accumulator_Width   : INTEGER := 32
            );

Port    (   Input_A             : in SIGNED (Input_Width - 1 downto 0); 
            Input_B             : in SIGNED (Input_Width - 1 downto 0);
            Clock               : in STD_lOGIC;
            Reset               : in STD_LOGIC;
            Enable              : in STD_LOGIC;
            Clear_Accumulator   : in STD_LOGIC;
            Output              : out SIGNED (Accumulator_Width - 1 downto 0)
            );
            
end MAC_Unit;

architecture Behavioral of MAC_Unit is
attribute use_dsp : string;
Signal Product                  : SIGNED ((2 * Input_Width) - 1 downto 0);
attribute use_dsp of Product : signal is "yes";

Signal Accumulator_Register     : SIGNED (Accumulator_Width - 1 downto 0);

begin

Product <= Input_A * Input_B;

Process(Clock)
begin
    if rising_edge(Clock) then
            if Reset = '1' then
                Accumulator_Register <= (others => '0');
            elsif Clear_Accumulator = '1' then
                Accumulator_Register <= (others => '0');    
            elsif Enable = '1' then
                Accumulator_Register <= Accumulator_Register + resize(Product, Accumulator_Width) ;
            end if;
        end if;
end process;

Output <= Accumulator_Register;

end Behavioral;
