#draw boxes and targets
.include "macros.asm"
.include "arena_structures.asm"

.data
	move_count: .word 0

.globl	draw_helper, move_count, draw_bottom
.text

#draws stuff so the game.asm doesnt get too cluttered
#these should be loops but i cant be bothered
draw_helper:
	enter	s0
	jal	draw_arena
	
	li	s0, 0
	la	a0, tar_position
	add	a0, a0, s0
	jal	draw_target
	
	addi	s0, s0, 8
	la	a0, tar_position
	add	a0, a0, s0
	jal	draw_target
	
	addi	s0, s0, 8
	la	a0, tar_position
	add	a0, a0, s0
	jal	draw_target
	
	li	s0, 0
	la	a0, box_position
	add	a0, a0, s0
	jal	draw_box
	
	addi	s0, s0, 8
	la	a0, box_position
	add	a0, a0, s0
	jal	draw_box
	
	addi	s0, s0, 8
	la	a0, box_position
	add	a0, a0, s0
	jal	draw_box
	
	jal	draw_character
	
	jal	draw_bottom
	leave	s0
draw_bottom:
	enter
	
	li	a0, 5
	li	a1, 55
	lstr	a2, "MOVES: "
	jal 	display_draw_text
	
	li	a0, 40
	li	a1, 55
	lw	a2, move_count
	jal	display_draw_int
	
	li	a0, 0
	li	a1, 50
	li	a2, 64
	li	a3, COLOR_BLUE
	jal 	display_draw_hline
	
	leave
