class_name PlayerState
extends Node

@warning_ignore("unused_signal")
signal finished(new_state: PlayerState)

var player_state_machine: PlayerStateMachine
var player: NewPlayer


func _ready() -> void:
	player_state_machine = get_parent() as PlayerStateMachine
	player = player_state_machine.player

func handle_input(_event: InputEvent) -> void:
	pass

func enter() -> void:
	pass

func exit() -> void:
	pass

func process(_delta: float) -> void:
	pass

func physics_process(_delta: float) -> void:
	pass
