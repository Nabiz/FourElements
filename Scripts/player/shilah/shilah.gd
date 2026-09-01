extends NewPlayer
class_name Shilah

@export var shoot_ability: ShootAbility

@export_subgroup("Textures")
@export var blank_sprite_texture: Texture
@export var fire_sprite: Texture
@export var water_sprite: Texture
@export var earth_sprite: Texture
@export var air_sprite: Texture

func _process(delta: float) -> void:
	super(delta)
	check_shot()

func check_shot():
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
