class_name AnimationComponent
extends AnimatedSprite2D

# Emitted when an animation finishes and 'currently_playing' is not Animations.DEFAULT
signal special_animation_finished(p_animation: Animations)

enum Directions {LEFT, RIGHT, DOWN, UP}
enum Animations {DEFAULT, ATTACK, DIE}

var facing: Directions
var currently_playing: Animations = Animations.DEFAULT


## Update idle/move animation according to given velocity.
## Does nothing if an attack/die animation is currently playing.
## Assumes the following animations exist:
##  'idle_up', 'idle_right', 'idle_down',
##  'move_up', 'move_right', 'move_down'.
func update_movement_animation(velocity: Vector2) -> void:
	if currently_playing != Animations.DEFAULT:
		return

	var angle: float = round(rad_to_deg(velocity.angle()))

	if velocity == Vector2.ZERO:
		match facing:
			Directions.UP:
				play("idle_up")
			Directions.RIGHT:
				play("idle_right")
				flip_h = false
			Directions.DOWN:
				play("idle_down")
			Directions.LEFT:
				play("idle_right")
				flip_h = true
	else:
		if -135 < angle and angle < -45:
			play("move_up")
			facing = Directions.UP
		elif -45 <= angle and angle <= 45:
			play("move_right")
			flip_h = false
			facing = Directions.RIGHT
		elif 45 < angle and angle < 135:
			play("move_down")
			facing = Directions.DOWN
		else:
			play("move_right")
			flip_h = true
			facing = Directions.LEFT


## Play attack animation in the given direction.
## Assumes the following animations exist:
##  'attack_up', 'attack_right', 'attack_down'.
func play_attack_animation(direction: Vector2) -> void:
	var angle: float = round(rad_to_deg(direction.angle()))

	if -135 < angle and angle < -45:
		play("attack_up")
	elif -45 <= angle and angle <= 45:
		play("attack_right")
		flip_h = false
	elif 45 < angle and angle < 135:
		play("attack_down")
	else:
		play("attack_right")
		flip_h = true

	currently_playing = Animations.ATTACK


## Play death animation.
## Assumes the following animations exist:
##  'die'.
func play_death_animation() -> void:
	play("die")
	currently_playing = Animations.DIE


func _on_animation_finished() -> void:
	if currently_playing != Animations.DEFAULT:
		special_animation_finished.emit(currently_playing)
		currently_playing = Animations.DEFAULT
