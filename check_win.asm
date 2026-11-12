#check win
.include "macros.asm"
.include "arena_structures.asm"

.globl	check_win
.text

#checks to see if every box overlaps with a target, if yes, return 1
check_win:
	#s0 - for box counter, s1 for target counter, s2 for correct placement counter
	enter	s0, s1, s2
	
	li	s0, 0
_check_win_for_box:
	#exits when s0 is did all 3, increments by 4, resets s1 every loop
	beq	s0, 24, _check_win_true
	li	s1, 0
_check_win_for_target:
	beq	s1, 24, _check_win_false
	
	#get box position x and y
	la	t1, box_position
	add	t1, t1, s0
	lw	a0, box_x(t1)
	lw	a1, box_y(t1)
	
	#get target address
	la	a2, tar_position
	add	a2, a2, s1
	
	#box is on a target, next box
	jal	check_box_object_collision
	bnez	v0, _check_win_next
	
	addi	s1, s1, 8
	j	_check_win_for_target
	
_check_win_next:
	addi	s0, s0, 8
	j	_check_win_for_box
_check_win_false:
	li	v0, 0
	j	_check_win_end
_check_win_true:
	li	v0, 1
_check_win_end:
	
	leave	s0, s1, s2
