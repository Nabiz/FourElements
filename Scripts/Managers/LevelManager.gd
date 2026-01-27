class_name LevelManager
extends Node

var current_level
var current_level_index = 0
var unlocked_level = 0
var intro_scene: PackedScene = preload("res://Scenes/GUI/Intro.tscn")
var menu_scene: PackedScene = preload("res://Scenes/GUI/MainMenu.tscn")
@export var level_scenes: Array[PackedScene]

const SAVE_PATH = "user://four_elements.dat"

func _ready() -> void:
	unlocked_level = load_level()

func change_level(level_index):
	MaskManagerAutoload.reset_manager()
	WaterPathManager.reset_manager()
	current_level_index = level_index
	current_level = level_scenes[current_level_index]
	get_tree().change_scene_to_packed(current_level)

func restart_level():
	change_level(current_level_index)

func play_intro():
	get_tree().change_scene_to_packed(intro_scene)

func load_menu():
	get_tree().change_scene_to_packed(menu_scene)


func save_level(level_number: int):
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_32(level_number) # Zapisuje liczbę jako 32-bitowy integer
		file.close()


func load_level() -> int:
	if not FileAccess.file_exists(SAVE_PATH):
		return 0
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file:
		var level = file.get_32()
		file.close()
		return level
	return 0
