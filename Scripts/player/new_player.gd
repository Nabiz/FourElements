class_name NewPlayer
extends CharacterBody2D

static var instance: NewPlayer

const SPEED = 250.0
var JUMP_VELOCITY = -420.0
const BOOSTED_JUMP_VELOCITY = -510.0
var jump_velocity = JUMP_VELOCITY

@export var animation: AnimationPlayer
@export var gfx_handler: Node2D

@export_category("Sprites")
@export var sprite: Sprite2D

@export var ladder_tile_map: TileMapLayer
@export var horizontal_climb_tile_map: TileMapLayer

@export var state_machine: PlayerStateMachine

var can_move: bool = true
var can_shoot: bool = true
var face_direction = Vector2.RIGHT

func _enter_tree() -> void:
	instance = self

func _process(_delta: float) -> void:
	play_animation()
	check_dead()
	set_face_direction(velocity.x)
	is_on_horizontal_climb()

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
		sprite.show()
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
	$PlayerStateMachine.change_state(DyingPlayerState)
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
			return tile_data.get_custom_data("vertical_climb")
		else:
			return false
	return false

func is_on_horizontal_climb() -> bool:
	if horizontal_climb_tile_map:
		var map_pos = horizontal_climb_tile_map.local_to_map(global_position-Vector2(0,32))
		var tile_data = horizontal_climb_tile_map.get_cell_tile_data(map_pos)
		if tile_data:
			return tile_data.get_custom_data("horizontal_climb")
		else:
			return false
	return false
