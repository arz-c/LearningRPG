class_name HitboxComponent
extends Area2D


@export var health_component: HealthComponent


func damage(attack: Attack) -> void:
	# Damage associated health component
	if health_component:
		health_component.damage(attack)

	# Apply knockback if attached to a CharacterBody2D
	var parent: Object = get_parent()
	if parent is CharacterBody2D:
		parent.velocity = (global_position - attack.origin).normalized() * attack.knockback
