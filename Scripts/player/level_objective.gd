class_name LevelObjective
extends Node

static var instance: LevelObjective

@export var keys: int
@export var enemies: int
@export var custom_objective: bool = false
@export var finish_area: FinishArea


func _enter_tree() -> void:
	instance = self


func _ready() -> void:
	check_finish()
	GUI.instance.update_key(keys)
	GUI.instance.update_enemies(enemies)


func on_pick_key():
	keys -= 1
	GUI.instance.update_key(keys)
	SoundManagerAutoload.play_sound(SoundManagerAutoload.key)
	check_finish()


func on_kill_enemy():
	enemies -= 1
	GUI.instance.update_enemies(enemies)
	SoundManagerAutoload.play_sound(SoundManagerAutoload.death)
	check_finish()


func on_fullify_custom_objective():
	custom_objective = false
	check_finish()


func active_finish():
	finish_area.open_door()
	if LevelManagerAutoload.current_level_index == 9:
		finish_area._on_body_entered(Player.instance)


func check_finish():
	if keys == 0 and enemies == 0 and !custom_objective:
		active_finish()
