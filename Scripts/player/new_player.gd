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

@export var shoot_ability: ShootAbility

@export var ladder_tile_map: TileMapLayer

var can_shoot: bool = true
var face_direction = Vector2.RIGHT

func _enter_tree() -> void:
	instance = self


func _process(_delta: float) -> void:
	play_animation()
	check_dead()
	set_face_direction(velocity.x)
	if Input.is_action_just_pressed("ui_fire"):
		shoot_ability.spawn_water()
		shoot_ability.spawn_fire_bullet()
		shoot_ability.spawn_earth_block()
		shoot_ability.spawn_air_bullet()
		

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

func check_dead() -> void:
	if global_position.y > 1000:
		LevelManagerAutoload.restart_level()


func die_by_water():
	gfx_handler.hide()
	$PlayerStateMachine.current_state.emit_signal("finished", $PlayerStateMachine.dying_state)
	$WaterDie.show()
	$WaterDie.play("water_splash")


func set_face_direction(direction):
		if direction < -0.05:
			gfx_handler.scale.x = -1
			face_direction = Vector2.LEFT
		elif direction > 0.05:
			gfx_handler.scale.x = 1
			face_direction = Vector2.RIGHT


func _on_water_die_animation_finished() -> void:
	LevelManagerAutoload.restart_level()


func is_on_climb() -> bool:
	if ladder_tile_map:
		var map_pos = ladder_tile_map.local_to_map(global_position+Vector2(0,16))
		var tile_data = ladder_tile_map.get_cell_tile_data(map_pos)
		if tile_data:
			return tile_data.get_custom_data("is_ladder")
		else:
			return false
	return false
