#draw targets
.include "arena_structures.asm"
.include "macros.asm"

.globl	draw_target
.text
#spawns a target, takes the box position as a0
draw_target:
	enter
	
	#get sprite address
	move	t0, a0
	#draw
	lw	a0, target_x(t0)
	lw	a1, target_y(t0)
	la	a2, target_pattern
	jal	display_blit_5x5_trans
	
	leave
