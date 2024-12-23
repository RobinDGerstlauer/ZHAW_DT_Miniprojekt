# create work library
vlib work

# compile project files
vcom -2008 -explicit -work work ../../support/simulation_pkg.vhd
vcom -2008 -explicit -work work ../../support/standard_driver_pkg.vhd
vcom -2008 -explicit -work work ../../support/user_driver_pkg.vhd
vcom -2008 -explicit -work work ../../../source/clock_sync.vhd
vcom -2008 -explicit -work work ../../../source/shiftreg_uart.vhd
vcom -2008 -explicit -work work ../../../source/output_register.vhd
vcom -2008 -explicit -work work ../../../source/uart_controller_fsm.vhd
vcom -2008 -explicit -work work ../../../source/baud_tick.vhd
vcom -2008 -explicit -work work ../../../source/flanken_detekt_vhdl.vhd
vcom -2008 -explicit -work work ../../../source/vhdl_hex2sevseg.vhd
vcom -2008 -explicit -work work ../../../source/modulo_divider.vhd
vcom -2008 -explicit -work work ../../../source/bit_counter.vhd
vcom -2008 -explicit -work work ../../../source/signal_checker.vhd
vcom -2008 -explicit -work work ../../../source/uart_top.vhd
vcom -2008 -explicit -work work ../../../source/uart_top_tb.vhd


# run the simulation
vsim +acc -t 1ns -lib work work.uart_top_tb
do ./wave.do
run 10 ms
