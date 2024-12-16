-- Copyright (C) 2024  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- PROGRAM		"Quartus Prime"
-- VERSION		"Version 23.1std.1 Build 993 05/14/2024 SC Lite Edition"
-- CREATED		"Mon Dec 16 12:06:27 2024"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY uart_top IS 
	PORT
	(
		CLOCK_50 :  IN  STD_LOGIC;
		KEY_0 :  IN  STD_LOGIC;
		ARDUINO_IO_11 :  IN  STD_LOGIC;
		LEDR_9 :  OUT  STD_LOGIC;
		ARDUINO_IO_12 :  OUT  STD_LOGIC;
		ARDUINO_IO_10 :  OUT  STD_LOGIC;
		HEX0 :  OUT  STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX1 :  OUT  STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END uart_top;

ARCHITECTURE bdf_type OF uart_top IS 

COMPONENT baud_tick
	PORT(clk : IN STD_LOGIC;
		 reset_n : IN STD_LOGIC;
		 start_bit : IN STD_LOGIC;
		 baud_tick : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT signal_checker
	PORT(clk : IN STD_LOGIC;
		 reset_n : IN STD_LOGIC;
		 data_in : IN STD_LOGIC;
		 led_blink : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT output_register
	PORT(clk : IN STD_LOGIC;
		 reset_n : IN STD_LOGIC;
		 data_valid : IN STD_LOGIC;
		 parallel_in : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 hex_lsb_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		 hex_msb_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;

COMPONENT vhdl_hex2sevseg
	PORT(lt_n : IN STD_LOGIC;
		 blank_n : IN STD_LOGIC;
		 rbi_n : IN STD_LOGIC;
		 data_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 rbo_n : OUT STD_LOGIC;
		 seg_o : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END COMPONENT;

COMPONENT clock_sync
	PORT(data_in : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 sync_out : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT flanken_detekt_vhdl
	PORT(data_in : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 reset_n : IN STD_LOGIC;
		 rising_pulse : OUT STD_LOGIC;
		 falling_pulse : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT bit_counter
GENERIC (width : INTEGER
			);
	PORT(clk : IN STD_LOGIC;
		 reset_n : IN STD_LOGIC;
		 start_bit : IN STD_LOGIC;
		 baud_tick : IN STD_LOGIC;
		 bit_count : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;

COMPONENT uart_controller_fsm
	PORT(clk : IN STD_LOGIC;
		 reset_n : IN STD_LOGIC;
		 falling_pulse : IN STD_LOGIC;
		 baud_tick : IN STD_LOGIC;
		 bit_count : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 parallel_data : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 shift_enable : OUT STD_LOGIC;
		 start_bit : OUT STD_LOGIC;
		 data_valid : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT shiftreg_uart
GENERIC (width : INTEGER
			);
	PORT(clk : IN STD_LOGIC;
		 reset_n : IN STD_LOGIC;
		 shift_enable : IN STD_LOGIC;
		 load_in : IN STD_LOGIC;
		 serial_in : IN STD_LOGIC;
		 parallel_in : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 serial_out : OUT STD_LOGIC;
		 parallel_out : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
	);
END COMPONENT;

COMPONENT modulo_divider
	PORT(clk : IN STD_LOGIC;
		 clk_6m : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_36 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_37 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_38 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_39 :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_40 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_10 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_14 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_41 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_42 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_26 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_28 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_32 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_33 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_35 :  STD_LOGIC_VECTOR(0 TO 9);


BEGIN 
ARDUINO_IO_12 <= KEY_0;
ARDUINO_IO_10 <= '0';
SYNTHESIZED_WIRE_40 <= '1';
SYNTHESIZED_WIRE_33 <= '0';
SYNTHESIZED_WIRE_35 <= "0000000000";



b2v_inst : baud_tick
PORT MAP(clk => SYNTHESIZED_WIRE_36,
		 reset_n => SYNTHESIZED_WIRE_37,
		 start_bit => SYNTHESIZED_WIRE_38,
		 baud_tick => SYNTHESIZED_WIRE_42);


b2v_inst1 : signal_checker
PORT MAP(clk => CLOCK_50,
		 reset_n => KEY_0,
		 data_in => ARDUINO_IO_11,
		 led_blink => LEDR_9);



b2v_inst11 : output_register
PORT MAP(clk => SYNTHESIZED_WIRE_36,
		 reset_n => SYNTHESIZED_WIRE_37,
		 data_valid => SYNTHESIZED_WIRE_5,
		 parallel_in => SYNTHESIZED_WIRE_39,
		 hex_lsb_out => SYNTHESIZED_WIRE_10,
		 hex_msb_out => SYNTHESIZED_WIRE_14);


b2v_inst12 : vhdl_hex2sevseg
PORT MAP(lt_n => SYNTHESIZED_WIRE_40,
		 blank_n => SYNTHESIZED_WIRE_40,
		 rbi_n => SYNTHESIZED_WIRE_40,
		 data_in => SYNTHESIZED_WIRE_10,
		 seg_o => HEX0);


b2v_inst13 : vhdl_hex2sevseg
PORT MAP(lt_n => SYNTHESIZED_WIRE_40,
		 blank_n => SYNTHESIZED_WIRE_40,
		 rbi_n => SYNTHESIZED_WIRE_40,
		 data_in => SYNTHESIZED_WIRE_14,
		 seg_o => HEX1);



b2v_inst15 : clock_sync
PORT MAP(data_in => KEY_0,
		 clk => SYNTHESIZED_WIRE_36,
		 sync_out => SYNTHESIZED_WIRE_37);


b2v_inst16 : clock_sync
PORT MAP(data_in => ARDUINO_IO_11,
		 clk => SYNTHESIZED_WIRE_36,
		 sync_out => SYNTHESIZED_WIRE_41);


b2v_inst3 : flanken_detekt_vhdl
PORT MAP(data_in => SYNTHESIZED_WIRE_41,
		 clk => SYNTHESIZED_WIRE_36,
		 reset_n => SYNTHESIZED_WIRE_37,
		 falling_pulse => SYNTHESIZED_WIRE_26);



b2v_inst5 : bit_counter
GENERIC MAP(width => 4
			)
PORT MAP(clk => SYNTHESIZED_WIRE_36,
		 reset_n => SYNTHESIZED_WIRE_37,
		 start_bit => SYNTHESIZED_WIRE_38,
		 baud_tick => SYNTHESIZED_WIRE_42,
		 bit_count => SYNTHESIZED_WIRE_28);


b2v_inst6 : uart_controller_fsm
PORT MAP(clk => SYNTHESIZED_WIRE_36,
		 reset_n => SYNTHESIZED_WIRE_37,
		 falling_pulse => SYNTHESIZED_WIRE_26,
		 baud_tick => SYNTHESIZED_WIRE_42,
		 bit_count => SYNTHESIZED_WIRE_28,
		 parallel_data => SYNTHESIZED_WIRE_39,
		 shift_enable => SYNTHESIZED_WIRE_32,
		 start_bit => SYNTHESIZED_WIRE_38,
		 data_valid => SYNTHESIZED_WIRE_5);


b2v_inst7 : shiftreg_uart
GENERIC MAP(width => 10
			)
PORT MAP(clk => SYNTHESIZED_WIRE_36,
		 reset_n => SYNTHESIZED_WIRE_37,
		 shift_enable => SYNTHESIZED_WIRE_32,
		 load_in => SYNTHESIZED_WIRE_33,
		 serial_in => SYNTHESIZED_WIRE_41,
		 parallel_in => SYNTHESIZED_WIRE_35,
		 parallel_out => SYNTHESIZED_WIRE_39);



b2v_inst9 : modulo_divider
PORT MAP(clk => CLOCK_50,
		 clk_6m => SYNTHESIZED_WIRE_36);


END bdf_type;