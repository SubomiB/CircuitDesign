----------------------------------------------------------------------------------
-- Engineer: Olasubomi Borishade
-- 
-- Create Date: 02/23/2026 04:42:58 PM
-- Design Name: Global Router
-- Module Name: Global_Router - Behavioral
-- Project Name: EENG 5550 Project 1

-- Description: A storage unit/router capable of sending and receiving data 
-- to and from different quadrant routers simultaneously

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

entity Global_Router is
    Generic (   d_w: integer := 8
                );
                
    Port (  Clock: in STD_LOGIC;
            Read_Write_Enable_Global: in STD_LOGIC;  
            Quadrant_0_In: in STD_LOGIC_VECTOR (d_w - 1 downto 0);
            Quadrant_1_In: in STD_LOGIC_VECTOR (d_w - 1 downto 0);
            Quadrant_2_In: in STD_LOGIC_VECTOR (d_w - 1 downto 0);
            Quadrant_3_In: in STD_LOGIC_VECTOR (d_w - 1 downto 0);
            Quadrant_0_Address: in STD_LOGIC_VECTOR (3 downto 0);
            Quadrant_1_Address: in STD_LOGIC_VECTOR (3 downto 0);
            Quadrant_2_Address: in STD_LOGIC_VECTOR (3 downto 0);
            Quadrant_3_Address: in STD_LOGIC_VECTOR (3 downto 0);
            Quadrant_0_Out: out STD_LOGIC_VECTOR (d_w - 1 downto 0);
            Quadrant_1_Out: out STD_LOGIC_VECTOR (d_w - 1 downto 0);
            Quadrant_2_Out: out STD_LOGIC_VECTOR (d_w - 1 downto 0);
            Quadrant_3_Out: out STD_LOGIC_VECTOR (d_w - 1 downto 0)
            );
                                     
end Global_Router;

architecture Behavioral of Global_Router is
type RegisterArray_1d is array (0 to 15) of STD_LOGIC_VECTOR(d_w - 1 downto 0);
Signal Stored_Data_Q: RegisterArray_1d;

begin
Store_Process: process(Clock)
begin

    if(rising_edge(Clock)) then
            
        if(Read_Write_Enable_Global = '1') then -- If the quadrant router is in write mode
        
        -- Store all outputs from each quadrant into selected register
            Stored_Data_Q(to_integer(unsigned(Quadrant_0_Address))) <= Quadrant_0_In;
            Stored_Data_Q(to_integer(unsigned(Quadrant_1_Address))) <= Quadrant_1_In;
            Stored_Data_Q(to_integer(unsigned(Quadrant_2_Address))) <= Quadrant_2_In;
            Stored_Data_Q(to_integer(unsigned(Quadrant_3_Address))) <= Quadrant_3_In;
            
        
--            if to_integer(unsigned(Quadrant_0_Address)) <= 3 then
--                    Stored_Data_Q(to_integer(unsigned(Quadrant_0_Address))) <= Quadrant_0_In;
--            end if;
            
--            if to_integer(unsigned(Quadrant_1_Address)) > 3 then
--                if to_integer(unsigned(Quadrant_1_Address)) <= 7 then
--                    Stored_Data_Q(to_integer(unsigned(Quadrant_1_Address))) <= Quadrant_1_In;
--                end if;    
--            end if;
            
--            if to_integer(unsigned(Quadrant_2_Address)) > 7 then
--                if to_integer(unsigned(Quadrant_2_Address)) <= 11 then
--                    Stored_Data_Q(to_integer(unsigned(Quadrant_2_Address))) <= Quadrant_2_In;
--                end if;    
--            end if;
            
--            if to_integer(unsigned(Quadrant_3_Address)) > 11 then
--                if to_integer(unsigned(Quadrant_3_Address)) <= 15 then
--                    Stored_Data_Q(to_integer(unsigned(Quadrant_3_Address))) <= Quadrant_3_In;
--                end if;    
--            end if;                                  
        end if;

        if(Read_Write_Enable_Global = '0') then -- If the quadrant router is in read mode
        
        -- Store all outputs from each quadrant into selected register
            Quadrant_0_Out <= Stored_Data_Q(to_integer(unsigned(Quadrant_0_Address))); 
            Quadrant_1_Out <= Stored_Data_Q(to_integer(unsigned(Quadrant_1_Address)));
            Quadrant_2_Out <= Stored_Data_Q(to_integer(unsigned(Quadrant_2_Address)));
            Quadrant_3_Out <= Stored_Data_Q(to_integer(unsigned(Quadrant_3_Address)));
        
        end if;
    end if;
end process;        
end Behavioral;
