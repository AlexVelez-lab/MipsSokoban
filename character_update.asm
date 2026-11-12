#character_update
.include "macros.asm"
.include "constants.asm"
.include "character_structure.asm"

.data
	last_update:	.word 0
	last_move:	.word 0, 0
.globl character_update, last_move, box_player_collided
.text
#moves the character, takes buffer as a0
character_update:
	enter 	s0, s1, s2
	
	move	s0, a0
	la	t0, last_move
	sw	zero, character_x(t0)
	sw	zero, character_y(t0)
	#just slows everything down
	jal	buffer_check
	
	beqz	v0, _character_update_end
	sw	zero, last_update
	#increment the movement counter
	lw	t0, move_count
	inc	t0
	sw	t0, move_count
#change character position on input
_character_input_vertical:
	jal	get_sprite_address
	move	s1, v0
	
	#moves character up and down by 5
	lw	t1, up_pressed
	mul	t1, t1, 5
	lw	t2, character_y(s1)
	sub	t2, t2, t1
	lw	t1, down_pressed
	mul	t1, t1, 5
	add	t2, t2, t1
	#check collision, if collision skip to horizontal
	move	s2, t2
	
	lw	a0, character_x(s1)
	move	a1, s2
	jal	check_arena_collision
	bnez	v0, _character_input_horizontal
	
	#saves the new character position and what direction it moved for box_update
	lw	t0, up_pressed
	lw	t1, down_pressed
	#-1 down, 1 up, 0 nothing
	sub	t0, t1, t0
	la	t1, last_move
	sw	t0, character_y(t1)
	sw	s2, character_y(s1)
#things from before, but horizontal
_character_input_horizontal:
	#moves character left to right by 5
	lw	t1, left_pressed
	mul	t1, t1, BLOCK_SIZE
	lw	t2, character_x(s1)
	sub	t2, t2, t1
	lw	t1, right_pressed
	mul	t1, t1, BLOCK_SIZE
	add	t2, t2, t1
	#check collision
	move	s2, t2
	
	move	a0, s2
	lw	a1, character_y(s1)
	jal	check_arena_collision
	bnez	v0, _character_update_end
	
	#saves the new character position and what direction it moved for box_update
	lw	t1, right_pressed
	lw	t0, left_pressed
	#-1 left, 1 right, 0 nothing
	sub	t0, t1, t0
	la	t1, last_move
	sw	t0, character_x(t1)
	sw	s2, character_x(s1)
_character_update_end:
	jal inc_last_update
	
	leave 	s0, s1, s2
#checks to see if a character can move
buffer_check:
	enter
	#cant move by default
	li	v0, 0
	
	lw	t0, up_pressed
	lw	t1, down_pressed
	lw	t2, left_pressed
	lw	t3, right_pressed
	
	add	t0, t0, t1
	add	t2, t2, t3
	add	t0, t0, t2
	#no movement, end
	beqz	t0, buffer_check_end
	#check if counter > buffer
	lw	t1, last_update
	ble	t1, a0, buffer_check_end
	#if yes, you can move
	li	v0, 1
buffer_check_end:
	leave
	
#just incs last update cause I felt like making another function
inc_last_update:
	enter
	
	lw	t0, last_update
	inc	t0
	sw	t0, last_update
	
	leave

#returns player to position from before collision involving box
box_player_collided:
	enter	s0, s1
	
	#last_move = new position, t0 is previous position
	jal	get_sprite_address
	move	s0, v0
	la	s1, last_move
	#changes character x position based on last move
	lw	t0, character_x(s1)
	mul	t0, t0, BLOCK_SIZE
	lw	t1, character_x(s0)
	sub	t1, t1, t0
	sw	t1, character_x(s0)
	#changes character y position based on last move
	lw	t0, character_y(s1)
	mul	t0, t0, BLOCK_SIZE
	lw	t1, character_y(s0)
	sub	t1, t1, t0
	sw	t1, character_y(s0)
	
_box_player_collided_end:
	leave	s0, s1
