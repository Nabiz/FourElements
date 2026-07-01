class_name JumpPlayerState
extends PlayerState

func enter() -> void:
	player.velocity.x = 0
	player.velocity.y = player.jump_velocity
	emit_signal("finished", player_state_machine.falling_state)

func exit() -> void:
	player.jump_velocity = player.JUMP_VELOCITY
