extends State


@export var enemy_character_body: CharacterBody2D
@export var speed: float = 15
@export var interval_min: float = 1
@export var interval_max: float = 3
@export var detection_radius: float = 60

var player_character_body: CharacterBody2D
var velocity: Vector2
var interval_time: float
var elapsed_time: float


func _ready() -> void:
	state_string = "enemy_idle"
	player_character_body = get_tree().get_first_node_in_group("player")


func _physics_process(delta: float) -> void:
	elapsed_time += delta

	if elapsed_time >= interval_time:
		_randomize_wander()

	if enemy_character_body.position.distance_to(player_character_body.position) \
	   <= detection_radius:
		transitioned.emit(state_string, "enemy_chase")
	
	enemy_character_body.velocity = enemy_character_body.velocity.move_toward(velocity, delta * 50)


func enter(_from_state: String) -> void:
	_randomize_wander()


func exit(_to_state: String) -> void:
	pass


func _randomize_wander() -> void:
	velocity = Vector2.from_angle(randf_range(-PI, PI)) * speed
	interval_time = randf_range(interval_min, interval_max)
	elapsed_time = 0
