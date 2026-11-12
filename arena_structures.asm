#arena structures
.include "constants.asm"
.eqv	box_x		0	# This is the offset of variable box_x
.eqv	box_y		4	# This is the offset of variable box_y
.eqv	target_x		0	# This is the offset of variable box_x
.eqv	target_y		4	# This is the offset of variable box_y
.data

arena_matrix:	
		.word	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
		.word	1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1
		.word	1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1
		.word	1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1
		.word	1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1
		.word	1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1
		.word	1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1
		.word	1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1
		.word	1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1
		.word	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
		
wall_pattern:	.byte	COLOR_YELLOW, COLOR_YELLOW, COLOR_YELLOW, COLOR_YELLOW, COLOR_YELLOW
		.byte	COLOR_YELLOW, COLOR_BLACK,  COLOR_YELLOW, COLOR_BLACK,  COLOR_YELLOW
		.byte	COLOR_YELLOW, COLOR_YELLOW, COLOR_YELLOW, COLOR_YELLOW, COLOR_YELLOW
		.byte	COLOR_BLACK,  COLOR_YELLOW, COLOR_YELLOW, COLOR_YELLOW, COLOR_BLACK
		.byte	COLOR_YELLOW, COLOR_BLACK,  COLOR_BLACK,  COLOR_BLACK,  COLOR_YELLOW

box_pattern:
		.byte	COLOR_BROWN, COLOR_BROWN, COLOR_BROWN, COLOR_BROWN, COLOR_BROWN
		.byte	COLOR_BROWN, COLOR_TAN,   COLOR_TAN,   COLOR_TAN,   COLOR_BROWN
		.byte	COLOR_BROWN, COLOR_TAN,   COLOR_TAN,   COLOR_TAN,   COLOR_BROWN
		.byte	COLOR_BROWN, COLOR_TAN,   COLOR_TAN,   COLOR_TAN,   COLOR_BROWN
		.byte	COLOR_BROWN, COLOR_BROWN, COLOR_BROWN, COLOR_BROWN, COLOR_BROWN

box_pattern2:
		.byte	COLOR_BROWN, COLOR_BROWN, COLOR_BROWN, COLOR_BROWN, COLOR_BROWN
		.byte	COLOR_BROWN, COLOR_TAN,   COLOR_BLUE,  COLOR_TAN,   COLOR_BROWN
		.byte	COLOR_BROWN, COLOR_BLUE,  COLOR_BLUE,  COLOR_BLUE,  COLOR_BROWN
		.byte	COLOR_BROWN, COLOR_TAN,   COLOR_BLUE,  COLOR_TAN,   COLOR_BROWN
		.byte	COLOR_BROWN, COLOR_BROWN, COLOR_BROWN, COLOR_BROWN, COLOR_BROWN
		
target_pattern:
		.byte	COLOR_BLUE,  COLOR_NONE,  COLOR_NONE,  COLOR_NONE,  COLOR_BLUE
		.byte	COLOR_NONE,  COLOR_BLUE,  COLOR_NONE,  COLOR_BLUE,  COLOR_NONE
		.byte	COLOR_NONE,  COLOR_NONE,  COLOR_BLUE,  COLOR_NONE,  COLOR_NONE
		.byte	COLOR_NONE,  COLOR_BLUE,  COLOR_NONE,  COLOR_BLUE,  COLOR_NONE
		.byte	COLOR_BLUE,  COLOR_NONE,  COLOR_NONE,  COLOR_NONE,  COLOR_BLUE
