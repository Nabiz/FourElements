class_name ShootAbility
extends Node2D

@export var player: NewPlayer

@export_category("Elements Objects")
@export var marker_point: Marker2D
@export var fire_bullet_scene: PackedScene
@export var air_bullet_scene: PackedScene
@export var earth_block_scene: PackedScene
@export var water_wave_scene: PackedScene
@export var earth_block_space: Area2D


func spawn_water():
	if MaskManager.current_element == MaskManager.Element.WATER:
		if check_water_space():
			MaskManager.use_ammo()


func spawn_fire_bullet():
	if MaskManager.current_element == MaskManager.Element.FIRE and player.can_shoot:
		MaskManager.use_ammo()
		var bullet: FireBullet = fire_bullet_scene.instantiate()
		bullet.direction = player.face_direction
		bullet.position = player.position + Vector2(0, -16)
		player.get_parent().add_child(bullet)


func check_water_space():
	var x = earth_block_space.get_overlapping_bodies()
	for body in x:
		if body is Fire:
			var water_wave = water_wave_scene.instantiate() as WaterWave
			water_wave.position = body.position
			water_wave.set_flip_direction(player.face_direction)
			water_wave.frame = 0
			player.get_parent().add_child(water_wave)
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
			block.velocity.y = clamp(player.velocity.y, 0, abs(player.velocity.y))
			block.global_position = marker_point.global_position.snapped(Vector2(32,1))
			player.get_parent().add_child(block)


func spawn_air_bullet():
	if MaskManager.current_element == MaskManager.Element.AIR:
		MaskManager.use_ammo()
		var bullet: AirBullet = air_bullet_scene.instantiate()
		bullet.direction = player.face_direction
		bullet.position = player.position + Vector2(0, -16)
		player.get_parent().add_child(bullet)
