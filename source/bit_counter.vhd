-------------------------------------------
-- Block code:  count_down.vhd
-- History:     12.Nov.2013 - 1st version (dqtm)
-- gerst, wyssl, stald 3.12.2024
-------------------------------------------


-- Library & Use Statements
-------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


-- Entity Declaration 
-------------------------------------------
entity bit_counter is
  generic (width : positive := 4); -- Breite des Zaehlers
  port(
       clk, reset_n : in  std_logic;
       start_bit    : in  std_logic; -- Startsignal
       baud_tick    : in  std_logic; -- Takt fuer die Zaehlung
       bit_count    : out std_logic_vector(width-1 downto 0) -- Ausgang des Zaehlers
       );
end bit_counter;


-- Architecture Declaration
-------------------------------------------
architecture rtl of bit_counter is
-- Signals & Constants Declaration
-------------------------------------------
  constant max_val         : unsigned(width-1 downto 0) := to_unsigned(9, width);  -- Max. Val. =9
  signal count, next_count : unsigned(width-1 downto 0);


-- Begin Architecture
-------------------------------------------
begin

  --------------------------------------------------
  -- PROCESS FOR COMBINATORIAL LOGIC
  --------------------------------------------------
  bit_counter : process(start_bit, baud_tick, count)
  begin
    
    if (start_bit = '1') then
      next_count <= to_unsigned(0, width);


    elsif (baud_tick = '1' and count < max_val) then
      next_count <= count+1;

   
    else
      next_count <= count;
    end if;

  end process bit_counter;


  --------------------------------------------------
  -- PROCESS FOR REGISTERS
  --------------------------------------------------
  flip_flops : process(clk, reset_n)
  begin
    if reset_n = '0' then
      count <= to_unsigned(0, width);  -- reset counter
    elsif rising_edge(clk) then
      count <= next_count;            
    end if;
  end process flip_flops;


  --------------------------------------------------
  -- CONCURRENT ASSIGNMENTS
  --------------------------------------------------
  
  bit_count <= std_logic_vector(count);

-- End Architecture 
------------------------------------------- 
end rtl;

