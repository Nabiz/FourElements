class_name NewPlayer
extends CharacterBody2D

static var instance: NewPlayer

const SPEED = 250.0
const JUMP_VELOCITY = -420.0
const BOOSTED_JUMP_VELOCITY = -510.0
var jump_velocity = JUMP_VELOCITY

@export var animation: AnimationPlayer
@export var gfx_handler: Node2D

@export_category("Sprites")
@export var sprite: Sprite2D
@export_subgroup("Textures")
@export var blank_sprite_texture: Texture
@export var fire_sprite: Texture
@export var water_sprite: Texture
@export var earth_sprite: Texture
@export var air_sprite: Texture

@export_category("Elements Objects")
@export var marker_point: Marker2D
@export var fire_bullet_scene: PackedScene
@export var air_bullet_scene: PackedScene
@export var earth_block_scene: PackedScene
@export var water_wave_scene: PackedScene
@export var earth_block_space: Area2D

var can_shoot: bool = true
var face_direction = Vector2.RIGHT

func _enter_tree() -> void:
	instance = self


func _process(_delta: float) -> void:
	play_animation()
	check_dead()
	set_face_direction(velocity.x)
	if Input.is_action_just_pressed("ui_fire"):
		spawn_water()
		spawn_fire_bullet()
		spawn_earth_block()
		

func change_element(element: MaskManager.Element) -> void:
	change_sprite(element)


func change_sprite(element: MaskManager.Element):
	match element:
		MaskManager.Element.BLANK:
			sprite.texture = blank_sprite_texture
		MaskManager.Element.FIRE:
			sprite.texture = fire_sprite
		MaskManager.Element.WATER:
			sprite.texture = water_sprite
		MaskManager.Element.EARTH:
			sprite.texture = earth_sprite
		MaskManager.Element.AIR:
			sprite.texture = air_sprite
		_:
			sprite.show()


func play_animation():
	if !is_on_floor():
		animation.play("jump")
	elif abs(velocity.x) > 0.1:
		animation.play("run")
	else:
		animation.play("idle")


func spawn_water():
	if MaskManager.current_element == MaskManager.Element.WATER:
		if check_water_space():
			MaskManager.use_ammo()


func spawn_fire_bullet():
	if MaskManager.current_element == MaskManager.Element.FIRE and can_shoot:
		MaskManager.use_ammo()
		var bullet: FireBullet = fire_bullet_scene.instantiate()
		bullet.direction = face_direction
		bullet.position = position + Vector2(0, -16)
		get_parent().add_child(bullet)


func check_water_space():
	var x = earth_block_space.get_overlapping_bodies()
	for body in x:
		if body is Fire:
			var water_wave = water_wave_scene.instantiate() as AnimatedSprite2D
			water_wave.position = body.position
			water_wave.frame = 0
			get_parent().add_child(water_wave)
			body.remove_fire()
			return true
	return false


func check_earth_block_space():
	var x = earth_block_space.get_overlapping_bodies()
	return x.size() == 0


func spawn_earth_block():
	if MaskManager.current_element == MaskManager.Element.EARTH:
		if check_earth_block_space():
			MaskManager.use_ammo()
			var block: EarthBlock = earth_block_scene.instantiate()
			block.velocity.y = clamp(velocity.y, 0, abs(velocity.y))
			block.global_position = marker_point.global_position.snapped(Vector2(32,1))
			get_parent().add_child(block)


func spawn_air_bullet():
	pass
	#if MaskManager.current_element == MaskManager.Element.AIR:
		#MaskManager.use_ammo()
		#var bullet: AirBullet = air_bullet_scene.instantiate()
		#bullet.direction = face_direction
		#bullet.position = position + Vector2(0, -16)
		#get_parent().add_child(bullet)


func check_dead() -> void:
	if global_position.y > 1000:
		LevelManagerAutoload.restart_level()


func die_by_water():
	gfx_handler.hide()
	velocity = Vector2.ZERO
	$WaterDie.show()
	$WaterDie.play("water_splash")


func set_face_direction(direction):
		if direction < -0.05:
			gfx_handler.scale.x = -1
			face_direction = Vector2.LEFT
			marker_point.position.x = -64.0
		elif direction > 0.05:
			gfx_handler.scale.x = 1
			face_direction = Vector2.RIGHT
			marker_point.position.x = 64.0


func _on_water_die_animation_finished() -> void:
	LevelManagerAutoload.restart_level()
