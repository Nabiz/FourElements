class_name PlayerStateMachine
extends Node

@export var current_state: PlayerState
@export var player: NewPlayer
@export var label: Label

@export_subgroup("States")
@export var idle_state: IdlePlayerState
@export var walking_state: WalkingPlayerState
@export var jump_state: JumpPlayerState
@export var falling_state: FallingPlayerState

func _ready() -> void:
	label.text = "State: " + current_state.name
	for state_node: PlayerState in get_children():
		state_node.finished.connect(_transistion_to_next_state)

func _unhandled_input(event: InputEvent) -> void:
	current_state.handle_input(event)

func _process(delta: float) -> void:
	current_state.process(delta)

func _physics_process(delta: float) -> void:
	current_state.physics_process(delta)

func _transistion_to_next_state(next_state: PlayerState):
	current_state.exit()
	current_state = next_state
	label.text = "State: " + current_state.name
	current_state.enter()
