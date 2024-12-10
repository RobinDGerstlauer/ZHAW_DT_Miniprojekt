-------------------------------------------
-- Block code:  count_down.vhd
-- History:     12.Nov.2013 - 1st version (dqtm)
--              10.12.2024 - Wysslrob, Gerstrob, Staldoli

-------------------------------------------


-- Library & Use Statements
-------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Entity Declaration 
-------------------------------------------
entity output_register is
  port(
       clk          : in  std_logic;
       reset_n      : in  std_logic;
       data_valid   : in  std_logic;  -- Signalisiert valid data
       parallel_in  : in  std_logic_vector(9 downto 0);  -- 10-Bit Eingabedaten
       hex_lsb_out  : out std_logic_vector(3 downto 0);  -- LSB für Hex-Anzeige
       hex_msb_out  : out std_logic_vector(3 downto 0)   -- MSB für Hex-Anzeige
       );
end output_register;

-- Architecture Declaration
-------------------------------------------
architecture rtl of output_register is
-- Signals & Constants Declaration
-------------------------------------------
  signal reg_data, next_data : std_logic_vector(9 downto 0);  -- Register für die 10-Bit Daten

-- Begin Architecture
-------------------------------------------
begin

  --------------------------------------------------
  -- PROCESS FOR COMBINATORIAL LOGIC
  --------------------------------------------------
  comb_logic : process(data_valid, parallel_in, reg_data)
  begin
    -- Standardwert beibehalten
    next_data <= reg_data;

    -- Speichert die Eingabedaten nur, wenn data_valid = '1'
    if data_valid = '1' then
      next_data <= parallel_in;
    end if;
  end process comb_logic;

  --------------------------------------------------
  -- PROCESS FOR REGISTERS
  --------------------------------------------------
  flip_flops : process(clk, reset_n)
  begin
    if reset_n = '0' then
      reg_data <= (others => '0');  -- Initialisiert das Register auf 0
    elsif rising_edge(clk) then
      reg_data <= next_data;       -- Aktualisiert die Daten im Register
    end if;
  end process flip_flops;

  --------------------------------------------------
  -- CONCURRENT ASSIGNMENTS
  --------------------------------------------------
  -- Weist die relevanten Teile von reg_data den Ausgängen zu
  hex_lsb_out <= reg_data(4 downto 1);  -- LSB (Datenbits 4 bis 7)
  hex_msb_out <= reg_data(8 downto 5);  -- MSB (Datenbits 0 bis 3)

-- End Architecture 
------------------------------------------- 
end rtl;

