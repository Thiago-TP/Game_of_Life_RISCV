#	Conway's game of life in Assembly RISC-V -- main module
#	Thiago Tomás de Paula, 2023/06/19	

.data
	# word array indicating which pixels are initially 'alive'
    .include "../initial_configuration/initial_configuration.data"
    
    # handy mnemonic handling for addresses and important constants
    .eqv	frame0_address			0xFF000000
    .eqv	frame1_address			0xFF100000
    .eqv	polling_address			0xFF200000
    .eqv	exposed_frame_address	0xFF200604
    .eqv	bmp_len					320			# in pixels
    .eqv	bmp_hgt					240			# in pixels
    .eqv	horizontal_border_len	20			# in pixels (vertical border is 1)
    .eqv	live_cell_value			0x07		# color/value of a live cell
    .eqv	dead_cell_value			0x00		# color/value of a dead cell
    .eqv	bars_color				0x02		# color/value of a bar
    
.text
	
	call	initialize_game						# shows the initial state of the game 
	
	# pauses the game for a bit
	li		a0, 1000
	li		a7, 32
	ecall
	
	game_loop:
		call	update_game						# draws the next state in the hidden frame
		
		# switches frames
		li		t0, exposed_frame_address 
		lw		t1, 0(t0)
		xori	t1, t1, 1						# inverts frame number, 0->1, or 1->0
		sw		t1, 0(t0)
		
		j		game_loop
	
	# functions
	.include "../functions/initialize_game.asm"
	.include "../functions/make_bars.asm"
	.include "../functions/update_game.asm"
	.include "../functions/update_dead_cell.asm"
	.include "../functions/update_live_cell.asm"

