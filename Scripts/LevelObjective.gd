class_name LevelObjective
extends Node

@export var keys: int
@export var enemies: int
@export var finish_area: FinishArea

static var instance: LevelObjective
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

func active_finish():
	finish_area.open_door()

func check_finish():
	if keys == 0 and enemies == 0:
		active_finish()
