class_name WalkingPlayerState
extends PlayerState


func handle_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_jump"):
		emit_signal("finished", player_state_machine.jump_state)

func physics_process(_delta: float) -> void:
	if not player.is_on_floor():
		emit_signal("finished", player_state_machine.falling_state)
	
	var horizontal_input: float = Input.get_axis("ui_left", "ui_right")
	if horizontal_input:
		player.velocity.x = horizontal_input * player.SPEED
		player.move_and_slide()
	else:
		emit_signal("finished", player_state_machine.idle_state)
	
