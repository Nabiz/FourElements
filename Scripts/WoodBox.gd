class_name WoodBox
extends StaticBody2D

@export var sprite: Sprite2D
@export var animation: AnimationPlayer
var progress = 0

func _ready() -> void:
	progress = 0
	sprite.material.set_shader_parameter("is_active", false)

func _process(delta: float) -> void:
	if animation.is_playing():
		progress += delta
		sprite.material.set_shader_parameter("progress", progress)
	

func play_destroy_animation():
	%SpriteOutlined.visible = false
	animation.play("destroy")

func active_burn_shader():
	sprite.material.set_shader_parameter("is_active", true)

func destroy():
	queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is FireBullet:
		progress = 0
		%CoverSprite.hide()
		play_destroy_animation()
