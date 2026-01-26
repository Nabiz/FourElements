class_name FireBullet
extends Area2D

var speed = 100
var direction = Vector2.RIGHT

func _physics_process(delta: float) -> void:
	position += speed * direction * delta

func _on_timer_timeout() -> void:
	queue_free()
