class_name Player
extends CharacterBody2D


const SPEED = 250.0
const JUMP_VELOCITY = -420.0

var face_direction = Vector2.RIGHT

@export var marker_point: Marker2D
@export var sprites: Node
@export var animation: AnimationPlayer

@export_category("ElementSprites")
@export var blank_sprite: Sprite2D
@export var blank_sprite_texture: Texture
@export var fire_sprite: Texture
@export var water_sprite: Texture
@export var earth_sprite: Texture
@export var air_sprite: Texture

var fire_bullet_scene: PackedScene = preload("res://Scenes/FireBullet.tscn")
var earth_block_scene: PackedScene = preload("res://Scenes/EarthBlock.tscn")

static var instance
func _enter_tree() -> void:
	instance = self

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_fire"):
		spawn_fire_bullet()
		spawn_earth_block()
	play_animation()
	if global_position.y > 1000:
		LevelManagerAutoload.restart_level()

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_select"):
		double_jump()
	basic_movement(delta)

func basic_movement(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		_set_face_direction(direction)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()

func play_animation():
	if !is_on_floor():
		animation.play("jump")
	elif abs(velocity.x) > 0.1:
		animation.play("run")
	else:
		animation.play("idle")

func change_element(element: MaskManager.Element) -> void:
	change_sprite(element)

func change_sprite(element: MaskManager.Element):
	match element:
		MaskManager.Element.BLANK:
			blank_sprite.texture = blank_sprite_texture
		MaskManager.Element.FIRE:
			blank_sprite.texture = fire_sprite
		MaskManager.Element.WATER:
			blank_sprite.texture = water_sprite
		MaskManager.Element.EARTH:
			blank_sprite.texture = earth_sprite
		MaskManager.Element.AIR:
			blank_sprite.texture = air_sprite
		_:
			blank_sprite.show()

func double_jump():
	if MaskManager.current_element == MaskManager.Element.AIR:
		if !is_on_floor():
			MaskManager.use_ammo()
			velocity.y = 1.2 * JUMP_VELOCITY

func spawn_fire_bullet():
	if MaskManager.current_element == MaskManager.Element.FIRE:
		MaskManager.use_ammo()
		var bullet: FireBullet = fire_bullet_scene.instantiate()
		bullet.direction = face_direction
		bullet.position = position + Vector2(0, -16)
		get_parent().add_child(bullet)

func check_earth_block_space():
	var x = %EarhtBlockSpace.get_overlapping_bodies()
	return x.size() == 0

func spawn_earth_block():
	if MaskManager.current_element == MaskManager.Element.EARTH:
		if check_earth_block_space():
			MaskManager.use_ammo()
			var block: EarthBlock = earth_block_scene.instantiate()
			block.global_position = marker_point.global_position
			get_parent().add_child(block)

func _set_face_direction(direction):
		if direction < -0.05:
			sprites.scale.x = -1
			face_direction = Vector2.LEFT
			marker_point.position.x = -64.0
		elif direction > 0.05:
			sprites.scale.x = 1
			face_direction = Vector2.RIGHT
			marker_point.position.x = 64.0
