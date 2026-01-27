class_name EndLevelPopup
extends CanvasLayer

func _on_button_pressed() -> void:
	var next_level = LevelManagerAutoload.current_level_index+1
	get_tree().paused = false
	if next_level >= LevelManagerAutoload.level_scenes.size():
		LevelManagerAutoload.load_menu()
	else:
		LevelManagerAutoload.change_level(next_level)
