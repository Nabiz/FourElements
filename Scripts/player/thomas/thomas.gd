extends NewPlayer
class_name Thomas

@export var default_colision: CollisionShape2D
@export var crawling_colision: CollisionShape2D

@export var crawling_sprite: Sprite2D
@export var stand_up_area: Area2D

@export var sleeping_dart_scene: PackedScene

func _ready() -> void:
	JUMP_VELOCITY = -550.0

func shoot():
	if can_shoot:
		var dart: SleepingDart = sleeping_dart_scene.instantiate()
		dart.direction = face_direction
		dart.position = position + Vector2(0, -16)
		get_parent().add_child(dart)

func play_animation():
	if state_machine.current_state is VerticalClimbingPlayerState:
		$GFXHandler/ClimbSprite.show()
		sprite.hide()
		if abs(velocity.y) > 0.1:
			$GFXHandler/ClimbSprite.play("climbing")
		else:
			$GFXHandler/ClimbSprite.play("climb_idle")
	else:
		$GFXHandler/ClimbSprite.hide()
		if not crawling_sprite.visible:
			sprite.show()
		if !is_on_floor():
			animation.play("jump")
		elif abs(velocity.x) > 0.1:
			animation.play("run")
		else:
			animation.play("idle")

func can_stand_up():
	if stand_up_area.get_overlapping_bodies():
		return false
	return true
