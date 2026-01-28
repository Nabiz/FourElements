extends Control

@export var animation: AnimationPlayer

@export var textureRect: TextureRect
@export var element_label: Label

@export var show_element_index = 0
@export var elements: Array[Texture]
@onready var elements_texts: Array[String] = ["Ogień!", "Woda!", "Ziemia!", "Powietrze!"]
@onready var colors: Array[Color] = [Color.DARK_RED, Color.ROYAL_BLUE, Color.SADDLE_BROWN, Color.SKY_BLUE]

@export_multiline var full_text: String

func _ready() -> void:
	play_intro()
	%PlayButton.grab_focus()

func _on_play_button_pressed() -> void:
	LevelManagerAutoload.change_level(0)
	SoundManagerAutoload.sfx_audio3.stop()

func play_intro():
	animation.play("intro")

func play_intro_sound():
	SoundManagerAutoload.play_intro()

func present_element():
	textureRect.texture = elements[show_element_index]
	element_label.add_theme_color_override("font_color", colors[show_element_index])
	element_label.text = elements_texts[show_element_index]

func play_typewriter_intro():
	var label = %IntroLabel
	label.text = full_text
	label.visible_ratio = 0.0
	
	var tween = create_tween()
	tween.tween_property(label, "visible_ratio", 1.0, 10.0).set_trans(Tween.TRANS_LINEAR).from(0.24)
	
	await tween.finished
