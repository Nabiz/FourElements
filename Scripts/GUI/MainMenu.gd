extends Control


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass


func _on_play_button_pressed() -> void:
	LevelManagerAutoload.play_intro()


func _on_levels_button_pressed() -> void:
	pass # Replace with function body.


func _on_exit_button_pressed() -> void:
	get_tree().quit()
