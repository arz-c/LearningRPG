class_name StateMachineComponent
extends Node

@export var initial_state: State

var states: Dictionary  # key: String, value: State
var current_state: State


func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.state_string] = child
			child.connect("transitioned", _on_state_transitioned)
			child.set_physics_process(false)

	current_state = initial_state
	initial_state.set_physics_process(true)
	initial_state.enter('')


func _on_state_transitioned(from_state: String, to_state: String) -> void:
	states[from_state].set_physics_process(false)
	states[from_state].exit(to_state)

	states[to_state].set_physics_process(true)
	states[to_state].enter(from_state)

	current_state = states[to_state]
