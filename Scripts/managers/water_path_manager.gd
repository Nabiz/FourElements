class_name WaterPathManager
extends Node

static var water_paths: Array[WaterPath] = []
static var fires: Array[Fire] = []

static var instance: WaterPathManager

func _enter_tree() -> void:
	instance = self

static func reset_manager():
	water_paths.clear()
	disable_all_water_paths()
	fires.clear()
	enable_all_fire_paths()

static func append_water_path(wp: WaterPath):
	water_paths.append(wp)

static func append_fire(f: Fire):
	fires.append(f)

static func enable_all_water_paths():
	for wp in water_paths:
		wp.enable_static_body()

static func disable_all_water_paths():
	for wp in water_paths:
		wp.disable_static_body()

static func enable_all_fire_paths():
	for f in fires:
		f.enable_static_body()

static func disable_all_fire_paths():
	for f in fires:
		f.disable_static_body()
