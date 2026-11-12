#box update file
.include "macros.asm"
.include "arena_structures.asm"
.include "character_structure.asm"

.data
	box_current_position:	.word 0, 0
	box_new_position:	.word 0, 0

.globl box_update
.text

#updates box when a player collides with it. moves box in the direction the player was last moveing. takes a0 as the box's position mem address
box_update:
	#s0 - box pos, s1 - char pos
	enter 	s0, s1
	#store box and character pos in s reg
	move	s0, a0
	jal	get_sprite_address
	move	s1, v0
	
	#check to see if box and player collide, else skip to end
	lw	a0, box_x(s1)
	lw	a1, box_y(s1)
	move	a2, s0
	jal	check_box_object_collision
	beqz	v0, _box_update_end
	
	#save current position
	move	a0, s0
	jal	save_current_position
	
	#store box movement/player movement
	jal	save_new_position
	
	#check arena collision
	la	t0, box_new_position
	lw	a0, box_x(t0)
	lw	a1, box_y(t0)
	jal	check_arena_collision
	bnez	v0, _box_update_collision
	
	#check box collision with other boxes
	la	t0, box_new_position
	lw	a0, box_x(t0)
	lw	a1, box_y(t0)
	jal	check_if_all_boxes_collide
	bnez	v0, _box_update_collision
	
	#move box
	jal	push_box
	j	_box_update_end
_box_update_collision:
	jal	box_player_collided
_box_update_end:
	
	leave 	s0, s1
#replaces current position with new position
push_box:
	enter
	
	la	t0, box_new_position
	
	lw	t1, box_x(t0)
	sw	t1, box_x(s0)
	
	lw	t1, box_y(t0)
	sw	t1, box_y(s0)
	
	leave

#takes current pos as a0
save_current_position:
	enter	s0
	
	move	t0, a0
	la	s0, box_current_position
	
	lw	t1, box_x(t0)
	sw	t1, box_x(s0)
	lw	t1, box_y(t0)
	sw	t1, box_y(s0)
	
	leave	s0

#calcualts and saves the new position of the box using player movement
save_new_position:
	enter	s0, s1, s2
	
	la	s0, last_move
	la	s1, box_current_position
	la	s2, box_new_position
	
	#calc and save x position
	lw	t0, character_x(s0)
	mul	t0, t0, BLOCK_SIZE
	lw	t2, box_x(s1)
	add	t2, t2, t0
	sw	t2, box_x(s2)
	
	#calc and save y position
	lw	t0, character_y(s0)
	mul	t0, t0, BLOCK_SIZE
	lw	t2, box_y(s1)
	add	t2, t2, t0
	sw	t2, box_y(s2)
	
	leave	s0, s1, s2
#loop through all boxes, see if this move would cause any box to collide
#boolean func, return 1 if true, 0 if false
#takes a0 - x, a1 - y
check_if_all_boxes_collide:
	enter	s0, s1, s2
	
	#s0 is counter
	li	s0, 0
	move	s1, a0
	move	s2, a1
_check_if_all_boxes_collide_loop:
	beq	s0, BOX_COUNT, _check_if_all_boxes_collide_false
	
	#check for collision, if yes, end
	move	a0, s1
	move	a1, s2
	
	mul	t0, s0, 8	#get box address from list
	la	a2, box_position
	add	a2, a2, t0
	
	jal	check_box_object_collision
	bnez	v0, _check_if_all_boxes_collide_true
	
	inc	s0
	j	_check_if_all_boxes_collide_loop
_check_if_all_boxes_collide_false:
	li	v0, 0
	leave	s0, s1, s2
_check_if_all_boxes_collide_true:
	li	v0, 1
	leave	s0, s1, s2
