class_name CrawlingPlayerState
extends PlayerState

var thomas: Thomas

func enter():
	thomas = player as Thomas
	player.velocity = Vector2.ZERO
	thomas.crawling_colision.disabled = false
	thomas.default_colision.disabled = true
	thomas.crawling_sprite.show()
	thomas.sprite.hide()

func exit():
	player.default_colision.disabled = false
	player.crawling_colision.disabled = true
	thomas.crawling_sprite.hide()
	thomas.sprite.show()

func handle_input(event: InputEvent) -> void:
	if event.is_action_released("ui_down") and player.can_stand_up():
		_finish_crawling()

func process(_delta) -> void:
	if player.is_on_floor():
		var horizontal_input = Input.get_axis("ui_left", "ui_right")
		if horizontal_input:
			player.velocity.x = horizontal_input * 0.8 * player.SPEED
		else:
			player.velocity.x = 0
	else:
		emit_signal("finished", player_state_machine.falling_state)
	player.move_and_slide()
	
	if not Input.is_action_pressed("ui_down") and player.can_stand_up():
		_finish_crawling()
	
func _finish_crawling() -> void:
	if Input.get_axis("ui_left", "ui_right"):
		emit_signal("finished", player_state_machine.walking_state)
	else:
		emit_signal("finished", player_state_machine.idle_state)
