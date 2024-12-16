-------------------------------------------
-- Block code:  baud_tick.vhd
-- History: 	12.Nov.2013 - 1st version (dqtm)
--                gerst, wyssl, stald 3.12.2024
-- Function: down-counter, with start input and count output. 
-- 			The input start should be a pulse which causes the 
--			counter to load its max-value. When start is off,
--			the counter decrements by one every clock cycle till 
--			baud_tick equals 0. Once the baud_tick reachs 0, the counter
--			freezes and wait till next start pulse. 
--			Can be used as enable for other blocks where need to 
--			count number of iterations.
-------------------------------------------


-- Library & Use Statements
-------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


-- Entity Declaration 
-------------------------------------------
ENTITY baud_tick IS
GENERIC (width : positive := 6);
  PORT( clk,reset_n		: IN    std_logic;
  		start_bit			: IN    std_logic;
    	baud_tick    		: OUT   std_logic
    	);
END baud_tick;


-- Architecture Declaration
-------------------------------------------
ARCHITECTURE rtl OF baud_tick IS
-- Signals & Constants Declaration
-------------------------------------------
CONSTANT  	max_val: 			unsigned(width-1 downto 0):= to_unsigned(4,width); -- convert integer value 4 to unsigned with 4bits
SIGNAL 		count, next_count: 	unsigned(width-1 downto 0);	 


CONSTANT clock_freq : positive := 6_250_000; -- Clock/Hz
CONSTANT baud_rate : positive := 115_200; -- Baude Rate/Hz
CONSTANT count_width : positive := width; -- FreqClock/FreqBaudRate = 6250000/115200 = 54.25… so need 6 bits
CONSTANT one_period : unsigned(count_width - 1 downto 0):= to_unsigned(clock_freq / baud_rate ,count_width);
CONSTANT half_period : unsigned(count_width - 1 downto 0):= to_unsigned(clock_freq/ baud_rate /2, count_width);

-- Begin Architecture
-------------------------------------------
BEGIN


  --------------------------------------------------
  -- PROCESS FOR COMBINATORIAL LOGIC
  --------------------------------------------------
  comb_logic: PROCESS(all)
  BEGIN	
	-- load	
	IF (start_bit = '1') THEN
		next_count <= half_period;
	
	ELSIF (count = 0) THEN
  		next_count <= one_period ;
  	ELSE
  		next_count <= count-1;
  	END IF;
	
  END PROCESS comb_logic;   
  
  
  
  
  --------------------------------------------------
  -- PROCESS FOR REGISTERS
  --------------------------------------------------
  flip_flops : PROCESS(all)
  BEGIN
  
  	IF (reset_n = '0') THEN
		count <= to_unsigned(0,count_width); -- convert integer value 0 to unsigned with 4bits
    ELSIF rising_edge(clk) THEN
		count <= next_count;
    END IF;
	 
  END PROCESS flip_flops;
  
  
  --------------------------------------------------
  -- PROCESS FOR OUTPUT
  --------------------------------------------------
  output : PROCESS(all)
  BEGIN
  
	baud_tick <= '0';
  
  	IF (count = 0) THEN
		baud_tick <= '1';
   END IF;
	
	IF (start_bit = '1') THEN
		baud_tick <= '0';
	END IF;
		
	
  END PROCESS output;	

  
 -- End Architecture 
------------------------------------------- 
END rtl;