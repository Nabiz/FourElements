class_name Enemy
extends CharacterBody2D

@export var sprite: AnimatedSprite2D
@export var move_duration: float = 1.0
var time = 0.0
const SPEED = 300.0
var direction = -1.0

func _ready() -> void:
	sprite.play("default")
	time = 0.0

func _process(delta: float) -> void:
	time += delta
	if time >= move_duration:
		change_direction()
		time = 0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()

func change_direction():
	sprite.flip_h = !sprite.flip_h
	if sprite.flip_h:
		direction = -1.0
	else:
		direction = 1.0


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		LevelManagerAutoload.restart_level()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is FireBullet:
		LevelObjective.instance.on_kill_enemy()
		area.queue_free()
		queue_free()


func _on_block_kill_area_area_entered(area: Area2D) -> void:
	LevelObjective.instance.on_kill_enemy()
	queue_free()
