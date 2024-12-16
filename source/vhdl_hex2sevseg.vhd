--
-- Project     : DT
--
-- File Name   : vhdl_template
-- Description : Template for DT lessons
-- gerst, wyssl, stald 3.12.2024
-- Features:     
--
--------------------------------------------------------------------
-- Change History
-- Date     |Name      |Modification
------------|----------|--------------------------------------------
-- 15.10.14 |  dqtm    | file created
-- 15.10.14 |  rosn    | small changes, comments
-- 11.10.19 |  gelk    | adapted for 2025

--------------------------------------------------------------------

-- Library & Use Statements
library ieee;
use ieee.std_logic_1164.all;

-- Entity Declaration 
entity vhdl_hex2sevseg is
  port(
    blank_n    	 : in  std_logic;                      -- Input of entity
    lt_n    		 : in  std_logic;   
	 rbi_n    		 : in  std_logic;    
	 -- Input of entity
    data_in 		 : IN std_logic_vector(3 downto 0);   -- Inputs of entity
    seg_o 			 : OUT std_logic_vector(6 downto 0); 
	 rbo_n			 : OUT std_logic);
	 
	 -- Outputs of entity
	 
end vhdl_hex2sevseg;

-- Architecture Declaration 
architecture vhdl_hex2sevseg_a of vhdl_hex2sevseg is

  -- Signals & Constants Declaration    
  constant val_0   : std_logic_vector(6 downto 0) := "1000000";
  constant val_1   : std_logic_vector(6 downto 0) := "1111001";
  constant val_2   : std_logic_vector(6 downto 0) := "0100100";
  constant val_3   : std_logic_vector(6 downto 0) := "0110000";
  constant val_4   : std_logic_vector(6 downto 0) := "0011001";
  constant val_5   : std_logic_vector(6 downto 0) := "0010010";
  constant val_6   : std_logic_vector(6 downto 0) := "0000010";
  constant val_7   : std_logic_vector(6 downto 0) := "1111000";
  constant val_8   : std_logic_vector(6 downto 0) := "0000000";
  constant val_9   : std_logic_vector(6 downto 0) := "0010000";
  constant val_a   : std_logic_vector(6 downto 0) := "0001000";
  constant val_b   : std_logic_vector(6 downto 0) := "0000011";
  constant val_c   : std_logic_vector(6 downto 0) := "1000110";
  constant val_d   : std_logic_vector(6 downto 0) := "0100001";
  constant val_e   : std_logic_vector(6 downto 0) := "0000110";
  constant val_f   : std_logic_vector(6 downto 0) := "0001110";
  


-- Begin Architecture
begin
  -------------------------------------------
  -- Process for combinatorial logic
  ------------------------------------------- 
  -- Process for registers (flip-flops)
  -------------------------------------------
  -- Concurrent Assignements  
  -- e.g. Assign outputs from intermediate signals
  -------------------------------------------
  muxer :  Process(all)
  begin
  rbo_n <= '1';
  IF blank_n THEN
	IF lt_n THEN
		CASE data_in IS
			WHEN "0000" => 
				IF rbi_n then 
					seg_o <= val_0;
				ELSE  
					seg_o <= "1111111";
					rbo_n <= '0';
				END IF;
			WHEN "0001" => seg_o <= val_1;
			WHEN "0010" => seg_o <= val_2;
			WHEN "0011" => seg_o <= val_3;
			WHEN "0100" => seg_o <= val_4;
			WHEN "0101" => seg_o <= val_5;
			WHEN "0110" => seg_o <= val_6;
			WHEN "0111" => seg_o <= val_7;
			WHEN "1000" => seg_o <= val_8;
			WHEN "1001" => seg_o <= val_9;
			WHEN "1010" => seg_o <= val_a;
			WHEN "1011" => seg_o <= val_b;
			WHEN "1100" => seg_o <= val_c;
			WHEN "1101" => seg_o <= val_d;
			WHEN "1110" => seg_o <= val_e;
			WHEN "1111" => seg_o <= val_f;
			WHEN OTHERS => seg_o <= "1111111";
		end Case;
		ELSE
			seg_o <= val_8;
		End IF;
	 ELSE
			seg_o <= "1111111";
	 end IF; 
	 
	END Process;
	
		
  

-- End Architecture 
end vhdl_hex2sevseg_a;
