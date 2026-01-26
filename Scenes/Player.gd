class_name Player
extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export_category("ElementSprites")
@export var blank_sprite: Sprite2D
@export var fire_sprite: Sprite2D
@export var water_sprite: Sprite2D
@export var earth_sprite: Sprite2D
@export var air_sprite: Sprite2D

static var instance

func _enter_tree() -> void:
	instance = self

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
