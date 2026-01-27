class_name FinishArea
extends Area2D

@export var end_level_popup: EndLevelPopup

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var next_level = LevelManagerAutoload.current_level_index+1
		if next_level > LevelManagerAutoload.unlocked_level:
			LevelManagerAutoload.save_level(next_level)
		get_tree().paused = true
		end_level_popup.show()
