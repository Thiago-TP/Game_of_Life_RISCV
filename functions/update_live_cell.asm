# 	Checks if a live cell must die. The rules are:
#	1. Any live cell with two or three live neighbours survives.
#	2. Any dead cell with three live neighbours becomes a live cell.
#	3. All other cells die in the next generation.
#	This function should not modifiy t0-t2.
#	---> Function arguments:
# 		a0 = address of upper left neighbor
# 		a1 = address of upper center neighbor
# 		a2 = address of upper right neighbor
# 		a3 = address of right neighbor
# 		a4 = address of lower right neighbor
# 		a5 = address of lower center neighbor
# 		a6 = address of lower left neighbor
# 		a7 = address of left neighbor
#	---> Function variables:
#		t3 = counter of live neighbors
#		t4 = state of cell in a0-a7

update_live_cell:
	add		t3, zero, zero	# set counter to 0
	
	lbu		t4, 0(a0)		# t4 = state of a neighbor
	add		t3, t3, t4		# updates counter
	
	lbu		t4, 0(a1)		# t4 = state of a neighbor
	add		t3, t3, t4		# updates counter
	
	lbu		t4, 0(a2)		# t4 = state of a neighbor
	add		t3, t3, t4		# updates counter
	
	lbu		t4, 0(a3)		# t4 = state of a neighbor
	add		t3, t3, t4		# updates counter
	
	lbu		t4, 0(a4)		# t4 = state of a neighbor
	add		t3, t3, t4		# updates counter
	
	lbu		t4, 0(a5)		# t4 = state of a neighbor
	add		t3, t3, t4		# updates counter
	
	lbu		t4, 0(a6)		# t4 = state of a neighbor
	add		t3, t3, t4		# updates counter
	
	lbu		t4, 0(a7)		# t4 = state of a neighbor
	add		t3, t3, t4		# updates counter

	# if counter is <2* or >3*color_value, the alive center cell dies in the hidden frame
	li		t4, live_cell_value
	add		t4, t4, t4
	beq		t3, t4, stay_live
	
	addi	t4, t4, live_cell_value
	beq		t3, t4, stay_live
	
	addi	t3, a0, 321		# t3 = address of center cell in current frame
	li		t4, 0x00100000
	xor		t3, t3, t4		# t3 = address of center cell in other frame
	li		t4, dead_cell_value
	sb		t4, 0(t3)		# cell is killed
	
	ret

stay_live:
	addi	t3, a0, 321		# t3 = address of center cell in current frame
	li		t4, 0x00100000
	xor		t3, t3, t4		# t3 = address of center cell in other frame
	li		t4, live_cell_value
	sb		t4, 0(t3)		# cell remains live
	
	ret

