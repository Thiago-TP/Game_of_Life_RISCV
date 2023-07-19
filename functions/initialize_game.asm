#	Prints on the bitmap the initial configuration of the game.
#	The indexes of the live bytes, as well as their quantity,
#	are stored in initial_configuration.
initialize_game:
	addi	sp, sp, -4
	sw		ra, 0(sp)
	
	# shows frame 1
	li		t0, exposed_frame_address
	li		t1, 1
	sw 		t1, 0(t0)
	
	# draws vertical and horizontal bars in frame 0
	li 		a0, 0
	call	make_bars
	
	# t0 stores the indexes of live cells, 
	# t1 stores their quantity
	la		t0, initial_configuration
	lw		t1, 0(t0)
	addi 	t0, t0, 4
	
	# t2 = base address of frame 0
	li		t2, frame0_address
	
	# t3 holds the color value
	li 		t3, live_cell_value
	
	make_live_loop: 
		lw		t4, 0(t0)					# t4 <- next index value
		add		t4, t4, t2					# t4 <- next pixel's address (0xFF0...)
		sb		t3, 0(t4)					# pixel at t4 is colored
		addi 	t0, t0, 4					# t0 points to the next index
		addi	t1, t1, -1					# one less pixel to go
		bgt		t1, zero, make_live_loop	# if there are any pixels left, repeat
		
	# shows frame 0		
	li		t0, exposed_frame_address
	sw 		zero, 0(t0)
	
	# draws vertical and horizontal bars in frame 1
	li 		a0, 1
	call	make_bars
	
	lw		ra, 0(sp)
	addi	sp, sp, 4
	ret

