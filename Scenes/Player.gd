class_name Player
extends CharacterBody2D


const SPEED = 250.0
const JUMP_VELOCITY = -400.0

var face_direction = Vector2.RIGHT

@export var marker_point: Marker2D
@export var sprites: Node

@export_category("ElementSprites")
@export var blank_sprite: Sprite2D
@export var fire_sprite: Sprite2D
@export var water_sprite: Sprite2D
@export var earth_sprite: Sprite2D
@export var air_sprite: Sprite2D

var fire_bullet_scene: PackedScene = preload("res://Scenes/FireBullet.tscn")
var earth_block_scene: PackedScene = preload("res://Scenes/EarthBlock.tscn")

static var instance
func _enter_tree() -> void:
	instance = self

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_fire"):
		spawn_fire_bullet()
		spawn_earth_block()

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

func change_element(element: MaskManager.Element) -> void:
	change_sprite(element)

func change_sprite(element: MaskManager.Element):
	blank_sprite.hide()
	fire_sprite.hide()
	water_sprite.hide()
	earth_sprite.hide()
	air_sprite.hide()
	match element:
		MaskManager.Element.BLANK:
			blank_sprite.show()
		MaskManager.Element.FIRE:
			fire_sprite.show()
		MaskManager.Element.WATER:
			water_sprite.show()
		MaskManager.Element.EARTH:
			earth_sprite.show()
		MaskManager.Element.AIR:
			air_sprite.show()
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
		bullet.position = position
		get_parent().add_child(bullet)

func spawn_earth_block():
	if MaskManager.current_element == MaskManager.Element.EARTH:
		MaskManager.use_ammo()
		var block: EarthBlock = earth_block_scene.instantiate()
		block.global_position = marker_point.global_position
		get_parent().add_child(block)

func _set_face_direction(direction):
		if direction < -0.05:
			sprites.scale.x = -1
			face_direction = Vector2.LEFT
			marker_point.position.x = -48
		elif direction > 0.05:
			sprites.scale.x = 1
			face_direction = Vector2.RIGHT
			marker_point.position.x = 48
