#	Draws thick vertical bars in the bitmap.
#	---> Function arguments
#		a0 = printing frame
#		horizontal_border_len = bar's thickness
make_bars:
	li		t0, 0xFF0
	add		t0, t0, a0
	slli	t0, t0, 20
	
	li		t1, horizontal_border_len
	li		t2, bmp_hgt
	li		t3, bars_color
	left_bar_loop:
		sb		t3, 0(t0)
		addi	t1, t1, -1
		addi	t0, t0, 1
		bgt		t1, zero, left_bar_loop
		
		li		t1, horizontal_border_len
		addi	t0, t0, bmp_len
		sub		t0, t0, t1
		addi	t2, t2, -1
		bgt		t2, zero, left_bar_loop
	
	li		t0, 0xFF0
	add		t0, t0, a0
	slli	t0, t0, 20
	
	li		t1, horizontal_border_len
	
	addi	t0, t0, bmp_len
	sub		t0, t0, t1
	li		t2, bmp_hgt
	right_bar_loop:
		sb		t3, 0(t0)
		addi	t1, t1, -1
		addi	t0, t0, 1
		bgt		t1, zero, right_bar_loop
		
		li		t1, horizontal_border_len
		addi	t0, t0, bmp_len
		sub		t0, t0, t1
		addi	t2, t2, -1
		bgt		t2, zero, right_bar_loop
	
	ret
		
