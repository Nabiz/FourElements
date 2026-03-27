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
		
