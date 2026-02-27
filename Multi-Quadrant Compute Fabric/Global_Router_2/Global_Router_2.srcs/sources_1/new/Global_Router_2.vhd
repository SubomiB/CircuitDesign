----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/26/2026 11:38:06 AM
-- Design Name: 
-- Module Name: Global_Router_2 - Behavioral
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

entity Global_Router_2 is
    Generic (   d_w : integer := 8
                );
    
    Port (  Clock                   : in std_logic;
            Read_Write_Enable_Global : in std_logic;

            -- Quadrant inputs
            Quadrant_0_In : in std_logic_vector(d_w-1 downto 0);
            Quadrant_1_In : in std_logic_vector(d_w-1 downto 0);
            Quadrant_2_In : in std_logic_vector(d_w-1 downto 0);
            Quadrant_3_In : in std_logic_vector(d_w-1 downto 0);

            -- Global addresses (0–15)
            Quadrant_0_Address : in std_logic_vector(3 downto 0);
            Quadrant_1_Address : in std_logic_vector(3 downto 0);
            Quadrant_2_Address : in std_logic_vector(3 downto 0);
            Quadrant_3_Address : in std_logic_vector(3 downto 0);

            -- Outputs
            Quadrant_0_Out : out std_logic_vector(d_w-1 downto 0);
            Quadrant_1_Out : out std_logic_vector(d_w-1 downto 0);
            Quadrant_2_Out : out std_logic_vector(d_w-1 downto 0);
            Quadrant_3_Out : out std_logic_vector(d_w-1 downto 0)
            );
            
end Global_Router_2;

architecture Behavioral of Global_Router_2 is

    -- Each quadrant owns a bank of 4 registers
    Type Bank_Type is array (0 to 3) of std_logic_vector(d_w - 1 downto 0);

    Signal Bank_0 : Bank_Type;
    Signal Bank_1 : Bank_Type;
    Signal Bank_2 : Bank_Type;
    Signal Bank_3 : Bank_Type;

begin

    ------------------------------------------------------------------
    -- WRITE LOGIC (all quadrants write in parallel)
    ------------------------------------------------------------------
    process(Clock)
    begin
        if rising_edge(Clock) then
            if Read_Write_Enable_Global = '1' then

                -- Quadrant 0 writes Bank 0 (addresses 0–3)
                Bank_0(to_integer(unsigned(Quadrant_0_Address(1 downto 0)))) <= Quadrant_0_In;

                -- Quadrant 1 writes Bank 1 (addresses 4–7)
                Bank_1(to_integer(unsigned(Quadrant_1_Address(1 downto 0)))) <= Quadrant_1_In;

                -- Quadrant 2 writes Bank 2 (addresses 8–11)
                Bank_2(to_integer(unsigned(Quadrant_2_Address(1 downto 0)))) <= Quadrant_2_In;

                -- Quadrant 3 writes Bank 3 (addresses 12–15)
                Bank_3(to_integer(unsigned(Quadrant_3_Address(1 downto 0)))) <= Quadrant_3_In;

            end if;
        end if;
    end process;



    process(Clock)
    begin
     if rising_edge(Clock) then
            if Read_Write_Enable_Global = '0' then

    -- Quadrant 0 read            
        case Quadrant_0_Address(3 downto 2) is
            when "00" => Quadrant_0_Out <= Bank_0(to_integer(unsigned(Quadrant_0_Address(1 downto 0))));
            when "01" => Quadrant_0_Out <= Bank_1(to_integer(unsigned(Quadrant_0_Address(1 downto 0))));
            when "10" => Quadrant_0_Out <= Bank_2(to_integer(unsigned(Quadrant_0_Address(1 downto 0))));
            when "11" => Quadrant_0_Out <= Bank_3(to_integer(unsigned(Quadrant_0_Address(1 downto 0))));
            when others => Quadrant_0_Out <= (others => '0');
        end case;

    -- Quadrant 1 read
        case Quadrant_1_Address(3 downto 2) is
            when "00" => Quadrant_1_Out <= Bank_0(to_integer(unsigned(Quadrant_1_Address(1 downto 0))));
            when "01" => Quadrant_1_Out <= Bank_1(to_integer(unsigned(Quadrant_1_Address(1 downto 0))));
            when "10" => Quadrant_1_Out <= Bank_2(to_integer(unsigned(Quadrant_1_Address(1 downto 0))));
            when "11" => Quadrant_1_Out <= Bank_3(to_integer(unsigned(Quadrant_1_Address(1 downto 0))));
            when others => Quadrant_1_Out <= (others => '0');
        end case;

    -- Quadrant 2 read
        case Quadrant_2_Address(3 downto 2) is
            when "00" => Quadrant_2_Out <= Bank_0(to_integer(unsigned(Quadrant_2_Address(1 downto 0))));
            when "01" => Quadrant_2_Out <= Bank_1(to_integer(unsigned(Quadrant_2_Address(1 downto 0))));
            when "10" => Quadrant_2_Out <= Bank_2(to_integer(unsigned(Quadrant_2_Address(1 downto 0))));
            when "11" => Quadrant_2_Out <= Bank_3(to_integer(unsigned(Quadrant_2_Address(1 downto 0))));
            when others => Quadrant_2_Out <= (others => '0');
        end case;

    -- Quadrant 3 read
        case Quadrant_3_Address(3 downto 2) is
            when "00" => Quadrant_3_Out <= Bank_0(to_integer(unsigned(Quadrant_3_Address(1 downto 0))));
            when "01" => Quadrant_3_Out <= Bank_1(to_integer(unsigned(Quadrant_3_Address(1 downto 0))));
            when "10" => Quadrant_3_Out <= Bank_2(to_integer(unsigned(Quadrant_3_Address(1 downto 0))));
            when "11" => Quadrant_3_Out <= Bank_3(to_integer(unsigned(Quadrant_3_Address(1 downto 0))));
            when others => Quadrant_3_Out <= (others => '0');
        end case;
        end if;
    end if;
end process;            
end Behavioral;