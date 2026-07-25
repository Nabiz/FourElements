class_name DialogueCanvas
extends CanvasLayer


@export var character_label: Label
@export var sentence_label: Label

var current_statement_index = 0
var character_array
var sentence_array

signal dialogue_ended

func _input(event: InputEvent) -> void:
	if visible:
		if event.is_action_pressed("ui_up"):
			end_dialogue()
		elif event.is_action_released("ui_select"):
			next_statement()


func start_dialogue(new_cahracter_array, new_sentence_array):
	character_array = new_cahracter_array
	sentence_array = new_sentence_array
	NewPlayer.instance.state_machine.change_state(StandbyPlayerState)
	current_statement_index = 0
	update_statement()
	show()


func next_statement():
	NewPlayer.instance.state_machine.change_state(StandbyPlayerState)
	current_statement_index += 1
	if current_statement_index >= sentence_array.size():
		end_dialogue()
	else:
		update_statement()


func update_statement():
	character_label.text = character_array[current_statement_index]
	sentence_label.text = sentence_array[current_statement_index]


func end_dialogue():
	hide()
	NewPlayer.instance.state_machine.change_state(IdlePlayerState)
	emit_signal("dialogue_ended")


func _on_next_label_pressed() -> void:
	next_statement()
