class_name State
extends Node


signal transitioned(from_state: String, to_state: String)

var state_string: String


func _physics_process(_delta: float) -> void:
	pass


func enter(_from_state: String) -> void:
	pass


func exit(_to_state: String) -> void:
	pass
