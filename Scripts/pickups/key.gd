extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		LevelObjective.instance.on_pick_key()
	queue_free()
