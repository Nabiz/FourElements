class_name Fire
extends StaticBody2D

func _enter_tree() -> void:
	WaterPathManager.append_fire(self)


func enable_static_body():
	set_collision_layer_value(1, true)


func disable_static_body():
	set_collision_layer_value(1, false)


func remove_fire():
	WaterPathManager.fires.erase(self)
	queue_free()
		

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is FireBullet:
		area.queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		var player = body as Player
		player.can_shoot = false

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		var player = body as Player
		MaskManager.use_ammo()
		player.can_shoot = true
	if body is NewPlayer:
		var player = body as NewPlayer
		MaskManager.use_ammo()
		#player.can_shoot = true
