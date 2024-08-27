class_name Player
extends CharacterBody2D


const SPEED: float = 100

@export var animation_component: AnimationComponent
@export var sword_area: Area2D

var hitboxes_already_hit: Array[HitboxComponent]
var dead: bool = false


func _ready() -> void:
	animation_component.facing = animation_component.Directions.DOWN


func _physics_process(_delta: float) -> void:
	if dead:
		return

	# Get keyboard input and handle movement/animation
	var move_direction: Vector2 = Input.get_vector("move_left", "move_right", \
												   "move_up", "move_down")
	if move_direction:
		velocity = move_direction * SPEED
	else:
		velocity -= velocity.normalized() * SPEED
	
	animation_component.update_movement_animation(velocity)
	move_and_slide()


func _input(event: InputEvent) -> void:
	if event.is_action("attack"):
		_sword_attack()


func _on_sword_area_area_entered(area: Area2D) -> void:
	if area is HitboxComponent and area not in hitboxes_already_hit:
		var sword_attack: Attack = Attack.new(20, 40, position)
		area.damage(sword_attack)

		hitboxes_already_hit.append(area)


func _on_animation_component_attack_finished() -> void:
	sword_area.monitoring = false
	hitboxes_already_hit = []


func _on_animation_component_special_animation_finished(animation: AnimationComponent.Animations) -> void:
	match animation:
		AnimationComponent.Animations.ATTACK:
			sword_area.monitoring = false
			hitboxes_already_hit = []
		AnimationComponent.Animations.DIE:
			Engine.time_scale = 1
			get_tree().reload_current_scene()


func _on_health_component_died() -> void:
	Engine.time_scale = 0.3
	animation_component.play_death_animation()
	dead = true


func _sword_attack():
	var direction: Vector2 = get_global_mouse_position() - global_position

	sword_area.rotation = direction.angle()
	sword_area.monitoring = true

	animation_component.play_attack_animation(direction)
