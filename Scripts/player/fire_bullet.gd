class_name FireBullet
extends Area2D

var speed = 500
var direction = Vector2.RIGHT

func _physics_process(delta: float) -> void:
	position += speed * direction * delta
	if direction.x < 0:
		%Sprite2D.flip_h = true

func _on_timer_timeout() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		return
	queue_free()
