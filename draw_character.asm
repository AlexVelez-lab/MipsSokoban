#draw character
.include "macros.asm"
.include "constants.asm"
.include "character_structure.asm"

.data
sprite:		.byte	COLOR_NONE, COLOR_NONE, COLOR_NONE, COLOR_NONE, COLOR_NONE
		.byte	COLOR_NONE, COLOR_RED,   COLOR_NONE, COLOR_RED,   COLOR_NONE
		.byte	COLOR_NONE, COLOR_NONE, COLOR_NONE, COLOR_NONE, COLOR_NONE
		.byte	COLOR_NONE, COLOR_RED,   COLOR_RED,   COLOR_RED,   COLOR_NONE
		.byte	COLOR_RED,   COLOR_NONE, COLOR_NONE, COLOR_NONE, COLOR_RED
position:	.word 	30, 30
.globl	draw_character, get_sprite_address
.text
#draws the character
draw_character:
	enter
	
	#get sprite address
	la	t0, position
	#draw
	lw	a0, character_x(t0)
	lw	a1, character_y(t0)
	la	a2, sprite
	jal	display_blit_5x5_trans
	
	leave
get_sprite_address:
	enter
	la	v0, position
	leave
