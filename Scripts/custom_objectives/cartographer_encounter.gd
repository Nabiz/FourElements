extends Node2D

@export var fire: Fire
@export var bubbles: CPUParticles2D

func _ready() -> void:
	LevelManagerAutoload.current_level_index = 9

func check_fire():
	if fire:
		LevelManagerAutoload.restart_level()


func _on_dialog_canvas_dialogue_ended() -> void:
	LevelObjective.instance.on_fullify_custom_objective()


func _on_fire_tree_exited() -> void:
	bubbles.emitting = false


func _on_water_area_body_entered(body: Node2D) -> void:
	if body is Player and fire:
		LevelManagerAutoload.restart_level()
