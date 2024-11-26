--
-- Project     : DT
--
-- File Name   : vhdl_template
-- Description : Template for DT lessons
--
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
		data_in : IN std_logic_vector(3 downto 0);
		lt_n : IN std_logic;
		blank_n : IN std_logic;
		rbi_n : IN std_logic;
		seg_o : OUT std_logic_vector(6 downto 0);
		rbo_n : OUT std_logic);
end vhdl_hex2sevseg;

-- Architecture Declaration�
architecture hex2sevseg of vhdl_hex2sevseg is

  -- Signals & Constants Declaration�   
  constant zero   : std_logic_vector(6 downto 0) := "1000000";
  constant one   : std_logic_vector(6 downto 0) := "1111001";
  constant two   : std_logic_vector(6 downto 0) := "0100100";
  constant three   : std_logic_vector(6 downto 0) := "0110000";
  constant four   : std_logic_vector(6 downto 0) := "0011001";
  constant five   : std_logic_vector(6 downto 0) := "0010010";
  constant six   : std_logic_vector(6 downto 0) := "0000010";
  constant seven   : std_logic_vector(6 downto 0) := "1111000";
  constant eight   : std_logic_vector(6 downto 0) := "0000000";
  constant nine   : std_logic_vector(6 downto 0) := "0010000";
  constant ten   : std_logic_vector(6 downto 0) := "0001000";
  constant eleven   : std_logic_vector(6 downto 0) := "0000011";
  constant twelve   : std_logic_vector(6 downto 0) := "1000110";
  constant thirteen   : std_logic_vector(6 downto 0) := "0100001";
  constant fourteen   : std_logic_vector(6 downto 0) := "0000110";
  constant fifteen   : std_logic_vector(6 downto 0) := "0001110";
  constant blank   : std_logic_vector(6 downto 0) := "1111111";
  constant full	: std_logic_vector(6 downto 0) := "0000000";
 
  
-- Begin Architecture
begin
	muxer: PROCESS(all)
	BEGIN
	
		rbo_n <= '1';
		
		IF blank_n = '0' THEN 
			seg_o <= blank;
	
		ELSIF lt_n = '0' THEN
			seg_o <= full;	
			
		ELSE 
			CASE data_in IS
				WHEN "0000" => seg_o <= zero; 
					IF rbi_n = '0' THEN
						rbo_n <= '0';
						seg_o <= blank;
					END IF;
				WHEN "0001" => seg_o <= one;
				WHEN "0010" => seg_o <= two;
				WHEN "0011" => seg_o <= three;
				WHEN "0100" => seg_o <= four;
				WHEN "0101" => seg_o <= five;
				WHEN "0110" => seg_o <= six;
				WHEN "0111" => seg_o <= seven;
				WHEN "1000" => seg_o <= eight;
				WHEN "1001" => seg_o <= nine;
				WHEN "1010" => seg_o <= ten;
				WHEN "1011" => seg_o <= eleven;
				WHEN "1100" => seg_o <= twelve;
				WHEN "1101" => seg_o <= thirteen;
				WHEN "1110" => seg_o <= fourteen;
				WHEN OTHERS => seg_o <= fifteen;
			END CASE;
		END IF;
	END PROCESS muxer;

	
  -------------------------------------------
  -- Process for combinatorial logic
  ------------------------------------------- 
  -- Process for registers (flip-flops)
  -------------------------------------------
  -- Concurrent Assignements  
  -- e.g. Assign outputs from intermediate signals
  -------------------------------------------

-- End Architecture 
end hex2sevseg;

