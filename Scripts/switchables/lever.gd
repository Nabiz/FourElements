class_name Lever
extends Area2D

@export var is_turned = false
@export var handle_sprite: Sprite2D

@export var switchable_object: SwitchableObject = null

var can_switch = false

func _ready() -> void:
	_update_handle_sprite_rotation()

func turn_lever():
	is_turned = !is_turned
	_update_handle_sprite_rotation()
	if is_turned:
		switchable_object.open()
	else:
		switchable_object.close()

func _update_handle_sprite_rotation():
	if is_turned:
		handle_sprite.rotation = 45
	else:
		handle_sprite.rotation = -45

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_down") and can_switch:
		turn_lever()

func _on_area_entered(area: Area2D) -> void:
	if area is AirBullet:
		if is_turned == (area.direction.x < 0):
			turn_lever()
		area.queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		can_switch = true


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		can_switch = false
