class_name HorizontalClimbingPlayerState
extends PlayerState

func enter():
	player.velocity.y = 0
	player.position.y = snapped(player.position.y, 64)

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_jump"):
		emit_signal("finished", player_state_machine.jump_state)
	elif event.is_action_pressed("ui_up", true) or event.is_action_pressed("ui_down", true):
		if player.is_on_climb():
			emit_signal("finished", player_state_machine.vertical_climbing_state)


func process(_delta) -> void:
	if !player.is_on_horizontal_climb():
		emit_signal("finished", player_state_machine.falling_state)
	var horizontal_input = Input.get_axis("ui_left", "ui_right")
	if horizontal_input:
		player.velocity.x = horizontal_input * player.SPEED
		player.velocity.y = 0
	else:
		player.velocity.x = 0
	
	player.move_and_slide()
