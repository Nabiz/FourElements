class_name WaterPath
extends Node2D

@export var static_body: StaticBody2D

func _ready() -> void:
	disable_static_body()
	WaterPathManager.instance.append_water_path(self)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player and MaskManager.current_element == MaskManager.Element.WATER:
		MaskManager.use_ammo()

func enable_static_body():
	static_body.set_collision_layer_value(1, true)

func disable_static_body():
	static_body.set_collision_layer_value(1, false)
