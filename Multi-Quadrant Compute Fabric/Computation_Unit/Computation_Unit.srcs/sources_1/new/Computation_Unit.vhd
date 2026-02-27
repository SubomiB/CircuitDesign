----------------------------------------------------------------------------------
-- Engineer: Olasubomi Borishade
-- 
-- Create Date: 02/09/2026 08:47:56 PM
-- Design Name: Computation Unit
-- Module Name: Computation_Unit - Behavioral
-- Project Name: EENG 5550 Project 1

-- Description: A computation unit with 8 bit operands and outputs capable of the following operations:
-- ADD, SUB, MULT, AND, NAND, OR, NOR, XOR, XNOR, OR, RSL, RSR, LSL and LSR

-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.OPERATIONS_ARRAY_CUSTOM_PACK.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Computation_Unit is
Generic (d_w: integer := 8);
Port ( A : in STD_LOGIC_VECTOR (d_w - 1 downto 0); -- Declaring A as a input vector
       B : in STD_LOGIC_VECTOR (d_w - 1 downto 0); -- Declaring B as a input vector
       OpSel : in CU_Operation; -- Declaring the operation selection signal as an input vector
       Y : out STD_LOGIC_VECTOR (d_w - 1 downto 0) -- Declaring Y as a output vector
       );
end Computation_Unit;

architecture Behavioral of Computation_Unit is

begin
ComputationUnit_proc: process (A, B, OpSel)
    variable Full_Addition : STD_LOGIC_VECTOR (d_w - 1 downto 0); -- Defining full-bit width intermediate addition signal
    variable Full_Subtraction : STD_LOGIC_VECTOR (d_w - 1 downto 0); -- Defining full-bit width intermediate subtraction signal
    variable Full_Multiplication : STD_LOGIC_VECTOR (2 * d_w - 1 downto 0); -- Defining full-bit width intermediate multiplication signal
    
begin
    case OpSel is
    when aADD =>
        Full_Addition := STD_LOGIC_VECTOR (Unsigned(A) + Unsigned(B)); -- Computes the full-bit width arithmetic addition of inputs A and B if the operation selection signal is 010
        Y <= Full_Addition (d_w - 1 downto 0); -- Truncates the sum to our specified bit width
 
    when aSUB => 
        Full_Subtraction := STD_LOGIC_VECTOR (Unsigned(A) - Unsigned(B)); -- Computes the full-bit width arithmetic sutraction of inputs A and B if the operation selection signal is 011
        Y <= Full_Subtraction (d_w - 1 downto 0); -- Truncates the difference to our specified bit width
 
    when aMULT => 
        Full_Multiplication := STD_LOGIC_VECTOR (Unsigned(A) * Unsigned (B)); -- Computes the full-bit width arithmetic multiplication of inputs A and B if the operation selection signal is 100
        Y <= Full_Multiplication (d_w - 1 downto 0); -- Truncates the product to our specified bit width
        
    when lAND => 
        Y <= A AND B; -- Computes the logical AND of inputs A and B if the operation selection signal is logical AND
 
    when lNAND => 
        Y <= A NAND B; -- Computes the logical NAND of inputs A and B if the operation selection signal is logical NAND
 
    when lOR => 
        Y <= A OR B; -- Computes the logical OR of inputs A and B if the operation selection signal is logical OR
        
    when lNOR => 
        Y <= A NOR B; -- Computes the logical NOR of inputs A and B if the operation selection signal is logical NOR    
 
    when lXOR => 
        Y <= A XOR B; -- Computes the logical XOR of inputs A and B if the operation selection signal is logical XOR 

    when lXNOR => 
        Y <= A XNOR B; -- Computes the logical XNOR of inputs A and B if the operation selection signal is logical XNOR 
         
    when rLSL =>
        Y <= to_stdlogicvector(to_bitvector(A) sll to_integer(unsigned(B))); -- Computes the logical shift leftward of A by B bits
        
    when rLSR =>
        Y <= to_stdlogicvector(to_bitvector(A) srl to_integer(unsigned(B))); -- Computes the logical shift rightward of A by B bits
 
    when rRSL =>
        Y <= to_stdlogicvector(to_bitvector(A) rol to_integer(unsigned(B))); -- Computes the rotate shift leftward of A by B bits
        
    when rRSR =>
        Y <= to_stdlogicvector(to_bitvector(A) ror to_integer(unsigned(B))); -- Computes the rotate shift rightward of A by B bits   
        
    when PassA =>
        Y <= A; -- Lets A be the output when PassA
                
    when PassB =>
        Y <= B; -- Lets B be the output when PassB
            
    when NoOp => -- NoOp
        Y <= (others => 'Z');
    
    when others => 
    Y <= (others => 'Z');
 
end case;
end process;
    
    

end Behavioral;