class_name EndLevelPopup
extends CanvasLayer


@export var next_level_button: Button

func focus_button():
	next_level_button.grab_focus()


func _on_button_pressed() -> void:
	var next_level = LevelManagerAutoload.current_level_index+1
	get_tree().paused = false
	if next_level >= LevelManagerAutoload.level_scenes.size():
		LevelManagerAutoload.play_outro()
	else:
		LevelManagerAutoload.change_level(next_level)
