class_name SwitchableObject
extends StaticBody2D

@export var collision: CollisionShape2D

func _ready():
	collision.call_deferred("set_disabled", true)
	visible = false

func open():
	collision.call_deferred("set_disabled", false)
	visible = true

func close():
	collision.call_deferred("set_disabled", true)
	visible = false
