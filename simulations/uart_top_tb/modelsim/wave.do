onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /uart_top_tb/DUT/b2v_inst6/bit_count
add wave -noupdate /uart_top_tb/DUT/b2v_inst/fsm_state
add wave -noupdate /uart_top_tb/key_0
add wave -noupdate -radix binary /uart_top_tb/DUT/b2v_inst12/parallel_out
add wave -noupdate /uart_top_tb/DUT/SYNTHESIZED_WIRE_30
add wave -noupdate -radix hexadecimal /uart_top_tb/DUT/b2v_inst7/hex_lsb_out
add wave -noupdate -radix hexadecimal /uart_top_tb/DUT/b2v_inst7/hex_msb_out
add wave -noupdate /uart_top_tb/DUT/b2v_inst7/parallel_in
add wave -noupdate /uart_top_tb/DUT/b2v_inst/bit_count
add wave -noupdate /uart_top_tb/DUT/b2v_inst/parallel_data
add wave -noupdate /uart_top_tb/DUT/b2v_inst/fsm_state
add wave -noupdate /uart_top_tb/DUT/b2v_inst/next_fsm_state
add wave -noupdate /uart_top_tb/DUT/SYNTHESIZED_WIRE_27
add wave -noupdate /uart_top_tb/DUT/SYNTHESIZED_WIRE_34
add wave -noupdate /uart_top_tb/DUT/SYNTHESIZED_WIRE_32
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {28060 ns} 0} {{Cursor 2} {9914373 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 340
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {454144 ns}
