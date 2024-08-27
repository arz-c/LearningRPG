## When creating a new Slime node, enable 'editable children' and assign the Slime to each State.

class_name Slime
extends CharacterBody2D


signal died

@export var animation_component: AnimationComponent
@export var animation_player: AnimationPlayer


func _ready() -> void:
	animation_component.facing = animation_component.Directions.DOWN


func _physics_process(_delta: float) -> void:
	animation_component.update_movement_animation(velocity)
	move_and_slide()


func _on_animation_component_special_animation_finished(animation: AnimationComponent.Animations) -> void:
	match animation:
		AnimationComponent.Animations.ATTACK:
			pass
		AnimationComponent.Animations.DIE:
			queue_free()


func _on_health_component_damaged() -> void:
	animation_player.play("damage")


func _on_health_component_died() -> void:
	animation_component.play_death_animation()
	died.emit()
