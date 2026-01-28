extends Control

@export var animation: AnimationPlayer

@export var show_element_index = 0

@export_multiline var full_text: String

func _ready() -> void:
	play_outro()
	%MenuButton.grab_focus()

func play_outro():
	animation.play("outro")

func play_outro_sound():
	SoundManagerAutoload.play_outro()

func play_typewriter_intro():
	var label = %OutroLabel
	label.text = full_text
	label.visible_ratio = 0.0
	
	var tween = create_tween()
	tween.tween_property(label, "visible_ratio", 1.0, 7.0).set_trans(Tween.TRANS_LINEAR)
	
	await tween.finished


func _on_menu_button_pressed() -> void:
	LevelManagerAutoload.load_menu()
	SoundManagerAutoload.sfx_audio3.stop()
