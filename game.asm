.include "constants.asm"
.include "macros.asm"

.data
  	box_position:	.word 20, 10
			.word 40, 10
			.word 10, 10
	
  	tar_position:	.word 30, 20
 			.word 30, 25
			.word 30, 15
	#0 for no, 1 for yes
	game_started:	.word 0
.globl game, box_position, tar_position
.text

game:
	enter
	
_game_start:
	jal	handle_input
	
	lw	t0, game_started
	beq	t0, 1, _game_while
	
	li	a0, 5
	li	a1, 30
	lstr	a2, "PRESS C"
	jal 	display_draw_text
	
	li	a0, 5
	li	a1, 40
	lstr	a2, "TO START"
	jal 	display_draw_text
	
	lw	t0, c_pressed
	bne	t0, 1, _game_frame
	li	t0, 1
	sw	t0, game_started
	j	_game_frame
_game_while:
	# Move stuff
	jal	update_helper
	# Draw stuff
	jal	draw_helper
	
	# Leave if x was pressed
	lw	t0, x_pressed
	bnez	t0, _game_end
	
	# check win
	jal	check_win
	beq	v0, 1, _game_win
_game_frame:
	jal	display_update_and_clear
	jal	wait_for_next_frame

	j	_game_start

_game_end:
	# Clear the screen
	jal	display_update_and_clear
	jal	wait_for_next_frame
	
	leave
_game_win:
	#clear screen
	jal	display_update_and_clear
	jal	wait_for_next_frame
	
	li	a0, 5
	li	a1, 10
	lstr	a2, "YOU WIN!"
	jal 	display_draw_text
	
	jal	draw_bottom
	
	j	_game_win
	
