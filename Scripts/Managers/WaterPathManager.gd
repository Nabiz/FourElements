class_name WaterPathManager
extends Node

static var water_paths: Array[WaterPath] = []

static var instance: WaterPathManager

func _enter_tree() -> void:
	instance = self

static func append_water_path(wp: WaterPath):
	water_paths.append(wp)

static func enable_all_water_paths():
	for wp in water_paths:
		wp.enable_static_body()

static func disable_all_water_paths():
	for wp in water_paths:
		wp.disable_static_body()
