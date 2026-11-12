#draw boxes
.include "arena_structures.asm"
.include "macros.asm"

.globl	draw_box, check_box_object_collision
.text
#spawns a box, takes the box position as a0
draw_box:
	enter	s0
	
	#get sprite address
	move	s0, a0
	
	jal	check_if_box_on_target
	beq	v0, 1, _draw_box2
	
	#draw
	lw	a0, box_x(s0)
	lw	a1, box_y(s0)
	la	a2, box_pattern
	jal	display_blit_5x5
	
	j	_draw_box_end
_draw_box2:
	lw	a0, box_x(s0)
	lw	a1, box_y(s0)
	la	a2, box_pattern2
	jal	display_blit_5x5
_draw_box_end:
	leave	s0
#returns 1 if player and box collides, returns 0 if it doesn't, takes argument a0, a1 of box position x/y, a2 mem address
check_box_object_collision:
	enter
	
	li	v0, 0
	#check if player/box x values the same
	lw	t0, box_x(a2)
	bne	a0, t0, _check_box_object_collision_end
	#check if player/box y values the same
	lw	t1, box_y(a2)
	bne	a1, t1, _check_box_object_collision_end
	
	li	v0, 1
_check_box_object_collision_end:
	leave

#checks to see if the box is on a target
#could be a loop but too tired
check_if_box_on_target:
	#s0 box x, s1 box y, s2 target list tracker thing
	enter	s0, s1, s2
	
	lw	s0, box_x(a0)
	lw	s1, box_y(a0)
	li	s2, 0
	#target 1
	move	a0, s0
	move	a1, s1
	la	a2, tar_position
	add	a2, a2, s2
	jal	check_box_object_collision
	bnez	v0, _check_if_box_on_target_end
	
	#target 2
	move	a0, s0
	move	a1, s1
	addi	s2, s2, 8
	la	a2, tar_position
	add	a2, a2, s2
	jal	check_box_object_collision
	bnez	v0, _check_if_box_on_target_end
	
	#target 3
	move	a0, s0
	move	a1, s1
	addi	s2, s2, 8
	la	a2, tar_position
	add	a2, a2, s2
	jal	check_box_object_collision
	bnez	v0, _check_if_box_on_target_end
	
	li	v0, 0
_check_if_box_on_target_end:
	leave	s0, s1, s2