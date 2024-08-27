class_name HealthComponent
extends Node2D


signal damaged
signal died

@export var max_health: float
@export var health_progress_bar: ProgressBar

var health: float:
	set(value):
		health = value
		health_progress_bar.value = value


func _ready() -> void:
	health_progress_bar.max_value = max_health
	health = max_health


func damage(attack: Attack) -> void:
	health -= attack.damage
	damaged.emit()

	if health <= 0:
		# health_progress_bar.visible = false
		died.emit()
