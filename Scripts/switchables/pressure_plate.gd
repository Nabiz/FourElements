class_name PressurePlate
extends Area2D

var is_pressed: bool = false
@export var switchable_object: SwitchableObject = null

@export_subgroup("Sprites")
@export var sprite: Sprite2D
@export var pressed_sprite: Sprite2D

func _ready() -> void:
	print(get_overlapping_bodies())

func _on_body_entered(_body: Node2D) -> void:
	if get_overlapping_bodies().size() > 1:
		is_pressed = true
		sprite.hide()
		pressed_sprite.show()
		switchable_object.open()

func _on_body_exited(_body: Node2D) -> void:
	if get_overlapping_bodies().size() == 1:
		is_pressed = false
		sprite.show()
		pressed_sprite.hide()
		switchable_object.close()
