class_name MaskPickup
extends Area2D

@export var element: MaskManager.Element = MaskManager.Element.FIRE
@export var collision: CollisionShape2D

@export var sprties: Node2D
@export_subgroup("Sprites")
@export var fire_sprite: Sprite2D
@export var water_sprite: Sprite2D
@export var earth_sprite: Sprite2D
@export var air_sprite: Sprite2D

func _ready() -> void:
	match element:
		MaskManager.Element.FIRE:
			fire_sprite.show()
		MaskManager.Element.WATER:
			water_sprite.show()
		MaskManager.Element.EARTH:
			earth_sprite.show()
		MaskManager.Element.AIR:
			air_sprite.show()

func _process(_delta: float) -> void:
	if MaskManager.current_element == MaskManager.Element.BLANK:
		enable_mask()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		MaskManager.on_mask_picked(self)

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		disable_mask()

func enable_mask():
	collision.set_deferred("disabled", false)
	sprties.modulate = Color(1,1,1,1)

func disable_mask():
	collision.set_deferred("disabled", true)
	sprties.modulate = Color(1,1,1,0.2)
	
