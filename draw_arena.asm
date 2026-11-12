#draw arena
.include "macros.asm"
.include "arena_structures.asm"

.globl	draw_arena, check_arena_collision
.text

#for(item:row) {
# for(item:column) {
#  draw_block where specified
# }
#}
draw_arena:
	enter	s0, s1
	
	li	s0, 0 #row counter
_draw_arena_loop_row:
	beq	s0, 10, _draw_arena_end
	li	s1, 0	#column counter
_draw_arena_loop_column:
	beq	s1, 13, _draw_arena_next
	
	mul	t0, s0, 13
	add	t0, t0, s1
	mul	t0, t0, 4
	lw	t1, arena_matrix(t0)
	
	#if matrix at reg address = 1, draw_block, else skip
	bne	t1, 1, _draw_skip
	
	# a0 = x, a1 = y
	mul	a0, s1, BLOCK_SIZE
	mul	a1, s0,	BLOCK_SIZE
	la	a2, wall_pattern
	jal	display_blit_5x5
_draw_skip:
	inc	s1
	j	_draw_arena_loop_column
_draw_arena_next:
	inc	s0
	j	_draw_arena_loop_row
_draw_arena_end:
	leave	s0, s1

#returns 1 if collides, returns 0 if it doesn't, takes argument a0, a1 of character position
check_arena_collision:
	enter
	
	#gets row and column
	div	t0, a1, BLOCK_SIZE		
	div	t1, a0, BLOCK_SIZE		
	#puts value of that from arena_matrix into v0
	mul	t0, t0, 13
	add	t0, t1, t0
	mul	t0, t0, 4
	lw	v0, arena_matrix(t0)
	
	leave
	
