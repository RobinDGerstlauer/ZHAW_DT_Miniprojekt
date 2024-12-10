-------------------------------------------
-- Block code:  shiftreg_uart.vhd
-- History:     Angepasst für UART-Empfänger
-- Function: Universelles Schieberegister für UART.
--            Dieses Modul dient als Schieberegister für den Empfang von seriellen Signalen.
--            Unterstützt parallele Ausgabe (parallel_out), seriellen Eingang (serial_in) und Steuerung über shift_enable.
-------------------------------------------
-- Library & Use Statements
-------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
 
 
-- Entity Declaration 
-------------------------------------------
entity shiftreg_uart is
  generic (
    width : positive := 4);
  port(clk, reset_n : in  std_logic;  -- Attention, this block has a set_n input for initialisation!!
    shift_enable  : in  std_logic;  -- Aktiviert das Schieben
	 load_in       : in  std_logic;  -- Signal zum Laden neuer Daten
	 serial_in     : in  std_logic;  -- Serieller Eingang
    parallel_in   : in  std_logic_vector(width-1 downto 0);  -- Parallele Eingabedaten
	 parallel_out  : out std_logic_vector(width-1 downto 0);  -- Paralleler Ausgang
    serial_out    : out std_logic   -- Serieller Ausgang
  );
end shiftreg_uart;
 
 
-- Architecture Declaration
-------------------------------------------
architecture rtl of shiftreg_uart is
-- Signals & Constants Declaration
-------------------------------------------
  signal shiftreg, next_shiftreg : std_logic_vector(width-1 downto 0);  -- add one bit for walk-1 detection
 
 
-- Begin Architecture
-------------------------------------------
begin
 
  --------------------------------------------------
  -- PROCESS FOR COMBINATORIAL LOGIC
  --------------------------------------------------
  shift_comb : process(all)
  begin
    if load_in = '1' then
      -- Lade parallel_in in das Schieberegister
      next_shiftreg <= parallel_in;
		elsif shift_enable = '1' then
        -- Schiebe MSB -> LSB und lade serial_in ins MSB
        next_shiftreg <= serial_in & shiftreg(width-1 downto 1);
		else
        -- Behalte den aktuellen Registerzustand
        next_shiftreg <= shiftreg;
    end if;
end process shift_comb;
 
  --------------------------------------------------
  -- PROCESS FOR REGISTERS
  --------------------------------------------------
  shift_dffs : process(clk, reset_n)
  begin
    if reset_n = '0' then
      shiftreg <= (others => '0');  -- Initialisiere Schieberegister auf 0
    elsif rising_edge(clk) then
      shiftreg <= next_shiftreg;   -- Aktualisiere mit den berechneten Werten
    end if;
  end process shift_dffs;
 
  --------------------------------------------------
  -- CONCURRENT ASSIGNMENTS
  --------------------------------------------------
  -- take LSB of shiftreg as serial output
    -- Serieller Ausgang ist das LSB des Schieberegisters
  serial_out <= shiftreg(0);
 
  -- Paralleler Ausgang ist der gesamte Registerinhalt
  parallel_out <= shiftreg;
 
-- End Architecture 
------------------------------------------- 
end rtl;
 