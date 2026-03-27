class_name MaskPickup
extends Area2D

@export var element: MaskManager.Element = MaskManager.Element.FIRE
@export var collision: CollisionShape2D
@export var audio_player: AudioStreamPlayer

@export var sprties: Node2D
@export_subgroup("Sprites")
@export var fire_sprite: Sprite2D
@export var water_sprite: Sprite2D
@export var earth_sprite: Sprite2D
@export var air_sprite: Sprite2D

@export_subgroup("Sounds")
@export var fire_sound: AudioStream
@export var water_sound: AudioStream
@export var earth_sound: AudioStream
@export var air_sound: AudioStream

func _ready() -> void:
	match element:
		MaskManager.Element.FIRE:
			audio_player.stream = fire_sound
			fire_sprite.show()
		MaskManager.Element.WATER:
			audio_player.stream = water_sound
			water_sprite.show()
		MaskManager.Element.EARTH:
			audio_player.stream = earth_sound
			earth_sprite.show()
		MaskManager.Element.AIR:
			audio_player.stream = air_sound
			air_sprite.show()

func _process(_delta: float) -> void:
	if MaskManager.current_element == MaskManager.Element.BLANK:
		enable_mask()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		MaskManager.on_mask_picked(self)
		audio_player.play()

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		disable_mask()

func enable_mask():
	%Outline.show()
	collision.set_deferred("disabled", false)
	sprties.modulate = Color(1,1,1,1)

func disable_mask():
	%Outline.hide()
	collision.set_deferred("disabled", true)
	sprties.modulate = Color(1,1,1,0.2)
	
