class_name WaterWave
extends AnimatedSprite2D

func _process(_delta: float) -> void:
	if frame == 4:
		queue_free()

func set_flip_direction(direction: Vector2) -> void:
	flip_h = direction.x < 0
