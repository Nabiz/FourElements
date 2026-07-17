class_name IdlePlayerState
extends PlayerState

func enter() -> void:
	player.velocity = Vector2.ZERO

func handle_input(_event: InputEvent) -> void:
	if Input.get_axis("ui_left", "ui_right"):
		emit_signal("finished", player_state_machine.walking_state)
	elif Input.is_action_just_pressed("ui_jump"):
		emit_signal("finished", player_state_machine.jump_state)
	elif Input.get_axis("ui_up", "ui_down") and player.is_on_climb():
		emit_signal("finished", player_state_machine.climbing_state)
