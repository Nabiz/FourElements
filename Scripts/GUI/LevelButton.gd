class_name LevelButton
extends Button

var level_number

func set_level_number(number):
	level_number = number
	text = str(level_number+1)
	if level_number <= LevelManagerAutoload.unlocked_level:
		disabled = false

func _on_pressed() -> void:
	LevelManagerAutoload.change_level(level_number)
