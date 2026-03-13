class_name AirBullet
extends Area2D

var speed = 500
var direction = Vector2.RIGHT

func _physics_process(delta: float) -> void:
	position += speed * direction * delta


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		return
	if body is Enemy:
		body.push(direction)
	queue_free()
