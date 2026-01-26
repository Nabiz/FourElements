class_name GUI
extends CanvasLayer

@export var element_texture_rect: TextureRect
@export var ammo_label: Label

@export_subgroup("Elements")
@export var blank_texture: CompressedTexture2D
@export var fire_texture: CompressedTexture2D
@export var water_texture: CompressedTexture2D
@export var earth_texture: CompressedTexture2D
@export var air_texture: CompressedTexture2D

static var instance
func _enter_tree() -> void:
	instance = self

func change_element(element: MaskManager.Element) -> void:
	match element:
		MaskManager.Element.FIRE:
			element_texture_rect.set_texture(fire_texture)
		MaskManager.Element.WATER:
			element_texture_rect.set_texture(water_texture)
		MaskManager.Element.EARTH:
			element_texture_rect.set_texture(earth_texture)
		MaskManager.Element.AIR:
			element_texture_rect.set_texture(air_texture)
		_:
			element_texture_rect.set_texture(blank_texture)
			
func update_ammo(value: int):
	ammo_label.text = str(value)
