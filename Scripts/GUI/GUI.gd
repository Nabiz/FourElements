class_name GUI
extends CanvasLayer

@export var element_texture_rect: TextureRect
@export var ammo_label: Label

@export var key_label: Label
@export var enemy_label: Label

@export_subgroup("Elements")
@export var blank_texture: CompressedTexture2D
@export var fire_texture: CompressedTexture2D
@export var water_texture: CompressedTexture2D
@export var earth_texture: CompressedTexture2D
@export var air_texture: CompressedTexture2D

static var instance: GUI
func _enter_tree() -> void:
	instance = self

func _process(delta: float) -> void:
	%CloudLayer.motion_offset.x -= 25 * delta

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

func update_key(value: int):
	key_label.text = str(value)

func update_enemies(value: int):
	enemy_label.text = str(value)

func _on_reset_button_pressed() -> void:
	LevelManagerAutoload.restart_level()

func _on_menu_button_pressed() -> void:
	get_tree().paused = false
	LevelManagerAutoload.load_menu()
