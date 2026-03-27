class_name DialogueArea
extends Area2D

var can_open_dialogue: bool = false
@export var dialogue_canvas: DialogueCanvas

@export var hint_label: Label

@export var character_array = ["Thomas", "Chief", "Thomas", "Chief"]
@export var sentence_array = ["Cześć, Mam na imię Thomas i jestem kartografem!",
"A ja jestem wódz indian. Skąd znasz nasz język?",
"Jestem uczonym, który zwiedza Amerykę i poznaje lokalne ludy. Także ich języki. Miło mi Cię poznać",
"Witaj blada twarz! Nie rób kłopotów na moim terenie. Dobrze Cię widzieć"]

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_down") and can_open_dialogue:
		if dialogue_canvas.visible == false:
			dialogue_canvas.start_dialogue(character_array, sentence_array)
			hint_label.hide()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		can_open_dialogue = true
		hint_label.show()

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		can_open_dialogue = false
		hint_label.hide()
