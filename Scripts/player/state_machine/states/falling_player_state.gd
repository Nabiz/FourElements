class_name FallingPlayerState
extends PlayerState

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_jump") and MaskManager.current_element == MaskManager.Element.AIR:
		MaskManager.use_ammo()
		player.jump_velocity = player.BOOSTED_JUMP_VELOCITY
		emit_signal("finished", player_state_machine.jump_state)
	
	elif Input.get_axis("ui_up", "ui_down") and player.is_on_climb():
		emit_signal("finished", player_state_machine.climbing_state)

func physics_process(delta: float) -> void:
	var horizontal_input: float = Input.get_axis("ui_left", "ui_right")
	if horizontal_input:
		player.velocity.x = horizontal_input * player.SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
	player.velocity += player.get_gravity() * delta
	player.move_and_slide()
	
	if player.is_on_floor():
		if horizontal_input:
			emit_signal("finished", player_state_machine.walking_state)
		else:
			emit_signal("finished", player_state_machine.idle_state)
