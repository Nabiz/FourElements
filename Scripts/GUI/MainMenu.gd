extends Control

@export var main_container: VBoxContainer
@export var level_select_container: GridContainer
@export var back_button: Button
var level_button_scene: PackedScene = preload("res://Scenes/GUI/LevelButton.tscn")

func _ready() -> void:
	update_unlocked_levels()
	SoundManagerAutoload.play_music(SoundManagerAutoload.menu_music)

func update_unlocked_levels():
	var level_buttons = level_select_container.get_children()
	for lb in level_buttons:
		lb.queue_free()
	for level_number in range(LevelManagerAutoload.level_scenes.size()):
		var level_button: LevelButton = level_button_scene.instantiate()
		level_select_container.add_child(level_button)
		level_button.set_level_number(level_number)

func _on_play_button_pressed() -> void:
	LevelManagerAutoload.play_intro()

func _on_levels_button_pressed() -> void:
	%Sprites.hide()
	main_container.hide()
	level_select_container.show()
	back_button.show()

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _on_back_button_pressed() -> void:
	%Sprites.show()
	main_container.show()
	level_select_container.hide()
	back_button.hide()
