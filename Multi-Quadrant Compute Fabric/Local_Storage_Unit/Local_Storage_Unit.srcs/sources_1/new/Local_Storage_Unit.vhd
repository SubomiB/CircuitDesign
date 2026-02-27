----------------------------------------------------------------------------------
-- Engineer: Olasubomi Borishade
--
-- Create Date: 02/11/2026 07:02:15 PM
-- Design Name: Local Storage Unit
-- Module Name: Local_Storage_Unit - Behavioral
-- Project Name: EENG 5550 Project 1

-- Description: 8-Bit data storage unit

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

entity Local_Storage_Unit is
    Generic (d_w: integer := 8);
    
    Port ( Data_In : in STD_LOGIC_VECTOR(d_w - 1 downto 0);
           Clock : in STD_LOGIC;
           ReadWrite_Enable : in STD_LOGIC;
           Q_Out : out STD_LOGIC_VECTOR(d_w - 1 downto 0));
           
end Local_Storage_Unit;

architecture Behavioral of Local_Storage_Unit is
Signal Stored_Data: STD_LOGIC_VECTOR(d_w - 1 downto 0);

begin

store: process(Data_In, ReadWrite_Enable, Clock)
begin

    if(rising_edge(Clock)) then
        if(ReadWrite_Enable = '1') then -- if the storage unit is in write mode
            Stored_Data <= Data_In;
        elsif(ReadWrite_Enable = '0') then -- if the storage unit is in read mode
            Q_Out <= Stored_Data;
        end if;
    end if;

end process store;

end Behavioral;
