class_name LevelManager
extends Node

var current_level
var current_level_index = 0
var intro_scene: PackedScene = preload("res://Scenes/GUI/Intro.tscn")
var menu_scene: PackedScene = preload("res://Scenes/GUI/MainMenu.tscn")
@export var level_scenes: Array[PackedScene]

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
