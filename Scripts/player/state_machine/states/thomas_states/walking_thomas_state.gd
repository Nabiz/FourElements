class_name WalkingThomasState
extends WalkingPlayerState

func handle_input(_event: InputEvent) -> void:
	if(Input.is_action_just_pressed("ui_down")):
		emit_signal("finished", thomas_sm.crawling_state)
	super(_event)
