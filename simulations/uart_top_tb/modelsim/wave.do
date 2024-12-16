onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /uart_top_tb/key_0
add wave -noupdate /uart_top_tb/DUT/SYNTHESIZED_WIRE_32
add wave -noupdate /uart_top_tb/DUT/b2v_inst7/width
add wave -noupdate /uart_top_tb/DUT/b2v_inst7/serial_out
add wave -noupdate /uart_top_tb/DUT/b2v_inst7/shiftreg
add wave -noupdate /uart_top_tb/DUT/b2v_inst11/reg_data
add wave -noupdate /uart_top_tb/DUT/b2v_inst11/next_data
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
WaveRestoreZoom {101284 ns} {555428 ns}
