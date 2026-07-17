class_name ClimbingPlayerState
extends PlayerState

func enter():
	player.position.x = snapped(player.position.x-32, 64) + 32

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_jump") and Input.get_axis("ui_left", "ui_right"):
		emit_signal("finished", player_state_machine.jump_state)


func process(delta) -> void:
	var vertical_input = Input.get_axis("ui_up", "ui_down")
	
	if player.is_on_floor() and not vertical_input:
		if Input.get_axis("ui_left", "ui_right"):
			emit_signal("finished", player_state_machine.walking_state)
		else:
			emit_signal("finished", player_state_machine.idle_state)
	elif not player.is_on_climb():
		emit_signal("finished", player_state_machine.jump_state)
	
	if vertical_input:
		player.velocity.y = vertical_input * player.SPEED

		player.velocity.x = 0
	else:
		player.velocity.y = 0
	
	player.move_and_slide()
