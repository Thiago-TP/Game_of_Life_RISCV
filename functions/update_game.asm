#	Visits each bitmap pixel and checks whether or not
#	changes must be done as ordered by the game rules:
#		1. Any live cell with two or three live neighbours survives.
#		2. Any dead cell with three live neighbours becomes a live cell.
#		3. All other cells die in the next generation.
update_game:
	addi	sp, sp, -4
	sw		ra, 0(sp)
	
	li		t0, exposed_frame_address
	lw		t0, 0(t0)
	li		t1, 0xFF0
	add		t0, t0, t1
	slli	t0, t0, 20			# t0 = 0xFF1_00000 or 0xFF0_00000 
	addi	t0, t0, bmp_len		# moves one pixel down 
	addi	t0, t0, horizontal_border_len	# moves to the right 
	
	li		t1, bmp_len 			
	li		t2, horizontal_border_len
	add		t2, t2, t2
	sub		t1, t1, t2			# bmp_len - 2*h_border so there can be a black border
	
	li		t2, bmp_hgt
	addi	t2, t2, -2 			# bmp_hgt - 2*v_border so there can be a black border
	
	update_loop:		
		addi	a0, t0, -321	# a0 = address of upper left neighbor
		addi	a1, t0, -320	# a1 = address of upper center neighbor
		addi	a2, t0, -319	# a2 = address of upper right neighbor
		addi	a3, t0, 1		# a3 = address of right neighbor
		addi	a4, t0, 321		# a4 = address of lower right neighbor
		addi	a5, t0, 320		# a5 = address of lower center neighbor
		addi	a6, t0, 319		# a6 = address of lower left neighbor
		addi	a7, t0, -1		# a7 = address of left neighbor
		
		lb		t3, 0(t0)
		beq		t3, zero, cell_is_dead
		j		cell_is_live
		
		return:
			addi	t0, t0, 1
			addi	t1, t1, -1
			bgt		t1, zero, update_loop
			
			# resets t1
			li		t1, bmp_len 			
			li		t3, horizontal_border_len
			add		t3, t3, t3
			sub		t1, t1, t3	
			
			addi	t0, t0, bmp_len
			sub		t0, t0, t1		
			addi	t2, t2, -1
			bgt		t2, zero, update_loop
	
	lw		ra, 0(sp)
	addi	sp, sp, -4		
	ret
	
cell_is_dead:
	jal 	update_dead_cell
	j		return

cell_is_live:
	jal		update_live_cell
	j		return
	
