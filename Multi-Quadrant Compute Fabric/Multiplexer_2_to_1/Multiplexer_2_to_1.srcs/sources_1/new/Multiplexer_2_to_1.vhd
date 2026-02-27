----------------------------------------------------------------------------------
-- Engineer: Olasubomi Borishade
-- 
-- Create Date: 02/16/2026 09:38:15 PM
-- Design Name: 2:1 Multiplexer
-- Module Name: Multiplexer_2_to_1 - Behavioral
-- Project Name: EENG 5560 Homework 3

-- Description: A 2:1 Multiplexer

-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Multiplexer_2_to_1 is
    Generic (d_w: integer := 8);

    Port ( I0 : in STD_LOGIC_VECTOR (d_w - 1 downto 0);
           I1 : in STD_LOGIC_VECTOR (d_w - 1 downto 0);
           Sel : in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (d_w - 1 downto 0)
           );
           
end Multiplexer_2_to_1;

architecture Behavioral of Multiplexer_2_to_1 is

begin
Multiplexer_2_1_proc: process(I0, I1, Sel)
    begin
        case Sel is
        when '0' =>
            Y <= I0;
            
        when '1' =>
            Y <= I1;
            
        when others => 
            Y <= (others => 'Z');
                 
        end case;
    end process;
        
end Behavioral;
