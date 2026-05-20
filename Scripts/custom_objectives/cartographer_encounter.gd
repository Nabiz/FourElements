extends Node2D

@export var fire: Fire

func _ready() -> void:
	LevelManagerAutoload.current_level_index = 9

func check_fire():
	if fire:
		LevelManagerAutoload.restart_level()


func _on_dialog_canvas_dialogue_ended() -> void:
	LevelObjective.instance.on_fullify_custom_objective()
