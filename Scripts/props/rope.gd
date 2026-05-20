extends Area2D

@export var animation_player: AnimationPlayer
@export var collision_shape: CollisionShape2D


func remove_rope():
	visible = false
	animation_player.play("1")


func _on_area_entered(area: Area2D) -> void:
	if area is FireBullet:
		collision_shape.call_deferred("set_disabled", true)
		remove_rope()
