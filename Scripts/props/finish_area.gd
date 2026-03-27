class_name FinishArea
extends Area2D

@export var end_level_popup: EndLevelPopup
@export var close_door: Sprite2D
@export var teleport: Sprite2D
var is_open = false

func _ready() -> void:
	close_door.visible = true
	teleport.visible = false
	is_open = false

func _on_body_entered(body: Node2D) -> void:
	if body is Player and is_open:
		var next_level = LevelManagerAutoload.current_level_index+1
		if next_level > LevelManagerAutoload.unlocked_level:
			LevelManagerAutoload.save_level(next_level)
		get_tree().paused = true
		end_level_popup.show()
		end_level_popup.focus_button()

func open_door():
	close_door.visible = false
	is_open = true
	teleport.visible = true
