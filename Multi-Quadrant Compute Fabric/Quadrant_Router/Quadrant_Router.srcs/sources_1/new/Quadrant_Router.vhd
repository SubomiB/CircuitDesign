----------------------------------------------------------------------------------
-- Engineer: Olasubomi Borishade
-- 
-- Create Date: 02/12/2026 09:21:13 PM
-- Design Name: Quadrant Router
-- Module Name: Quadrant_Router - Behavioral
-- Project Name: EENG 5550 Project 1

-- Description: A storage unit/router capable of receiving 5 inputs and give out 3 outputs

-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use WORK.OPERATIONS_ARRAY_CUSTOM_PACK.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Quadrant_Router is
    Generic (   d_w: integer := 8;
                rows: natural := 4 -- parameterizing the rows of the array
                

                );
            
    Port (  Clock: in STD_LOGIC;
            Read_Write_Enable: in STD_LOGIC;
            Global_Write_Enable: in STD_LOGIC;
            Data_In_0: in STD_LOGIC_VECTOR (d_w - 1 downto 0);
            Data_In_1: in STD_LOGIC_VECTOR (d_w - 1 downto 0);
            Data_In_2: in STD_LOGIC_VECTOR (d_w - 1 downto 0);
            Data_In_3: in STD_LOGIC_VECTOR (d_w - 1 downto 0);            
            Address_A: in VectorArray_1d (0 to rows - 1)(3 downto 0);
            Address_B: in VectorArray_1d (0 to rows - 1) (3 downto 0);
            Address_Global: in STD_LOGIC_VECTOR (3 downto 0) := "1111";
            Global_Router_In: in STD_LOGIC_VECTOR (d_w - 1 downto 0);
            Global_Router_Out: out STD_LOGIC_VECTOR (d_w - 1 downto 0);
            Q_Out_A0: out STD_LOGIC_VECTOR (d_w - 1 downto 0);
            Q_Out_B0: out STD_LOGIC_VECTOR (d_w - 1 downto 0);
            Q_Out_A1: out STD_LOGIC_VECTOR (d_w - 1 downto 0);
            Q_Out_B1: out STD_LOGIC_VECTOR (d_w - 1 downto 0);
            Q_Out_A2: out STD_LOGIC_VECTOR (d_w - 1 downto 0);
            Q_Out_B2: out STD_LOGIC_VECTOR (d_w - 1 downto 0);
            Q_Out_A3: out STD_LOGIC_VECTOR (d_w - 1 downto 0);
            Q_Out_B3: out STD_LOGIC_VECTOR (d_w - 1 downto 0)
            );
            
end Quadrant_Router;

architecture Behavioral of Quadrant_Router is
Signal Stored_Data: VectorArray_1d (0 to 15)(d_w - 1 downto 0); -- 16 registers capable of storing 8-bit data
 
begin

Store_Process: process(Clock)
begin

    if(rising_edge(Clock)) then
            
        if(Read_Write_Enable = '1') then -- If the quadrant router is in write mode
        
        -- Store all outputs from CU local output storage
            Stored_Data(0) <= Data_In_0; Stored_Data(1) <= Data_In_1; Stored_Data(2) <= Data_In_2; Stored_Data(3) <= Data_In_3;
            
        -- Store other quadrant results in desired quadrant storage    
            if Global_Write_Enable = '1' then
                if to_integer(unsigned(Address_Global)) > 3 then
                    Stored_Data(to_integer(unsigned(Address_Global))) <= Global_Router_In;
                end if;
            end if;    
        end if;
            
        if(Read_Write_Enable = '0') then -- If the quadrant router is in read mode
            Q_Out_A0 <= Stored_Data(to_integer(unsigned(Address_A(0))));
            Q_Out_B0 <= Stored_Data(to_integer(unsigned(Address_B(0))));
            Q_Out_A1 <= Stored_Data(to_integer(unsigned(Address_A(1))));
            Q_Out_B1 <= Stored_Data(to_integer(unsigned(Address_B(1))));
            Q_Out_A2 <= Stored_Data(to_integer(unsigned(Address_A(2))));
            Q_Out_B2 <= Stored_Data(to_integer(unsigned(Address_B(2))));
            Q_Out_A3 <= Stored_Data(to_integer(unsigned(Address_A(3))));
            Q_Out_B3 <= Stored_Data(to_integer(unsigned(Address_B(3))));
        
            if Global_Write_Enable = '0' then                                        
                Global_Router_Out <= Stored_Data(to_integer(unsigned(Address_Global)));
            end if;
        end if;
        
    end if;
      
end process;    
end Behavioral;