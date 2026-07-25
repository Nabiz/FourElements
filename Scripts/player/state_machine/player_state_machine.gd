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
@export var climbing_state: ClimbingPlayerState
@export var dying_state: DyingPlayerState
@export var standby_state: StandbyPlayerState

var states: Array[PlayerState] = []

func change_state(new_state_class):
	for state: PlayerState in states:
		if is_instance_of(state, new_state_class):
			current_state.emit_signal("finished", state)
			return

func _ready() -> void:
	label.text = "State: " + current_state.name
	for state_node: PlayerState in get_children():
		state_node.finished.connect(_transistion_to_next_state)
		states.append(state_node)

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
