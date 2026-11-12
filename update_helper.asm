#update helper
.include "macros.asm"
.include "arena_structures.asm"

.globl	update_helper
.text

update_helper:
	enter	s0
	
	li	a0, BUFFER
	jal	character_update
	
	li	s0, 0
	la	a0, box_position
	add	a0, a0, s0
	jal	box_update
	
	addi	s0, s0, 8
	la	a0, box_position
	add	a0, a0, s0
	jal	box_update
	
	addi	s0, s0, 8
	la	a0, box_position
	add	a0, a0, s0
	jal	box_update
	
	leave	s0
