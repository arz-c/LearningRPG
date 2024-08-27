extends State


@export var enemy_character_body: CharacterBody2D
@export var speed: float = 15
@export var radius_min: float = 30
@export var radius_max: float = 60

var player_character_body: CharacterBody2D


func _ready() -> void:
	state_string = "enemy_chase"
	player_character_body = get_tree().get_first_node_in_group("player")


func _physics_process(delta: float) -> void:
	var enemy_to_player: Vector2 = player_character_body.position - enemy_character_body.position

	if enemy_to_player.length() > radius_max:
		transitioned.emit(state_string, "enemy_idle")

	if enemy_to_player.length() >= radius_min:
		enemy_character_body.velocity = enemy_character_body.velocity.move_toward(
											(player_character_body.position \
											- enemy_character_body.position).normalized() * speed,
										delta * 50)
	else:
		transitioned.emit(state_string, "enemy_attack")


func enter(_from_state: String) -> void:
	pass


func exit(_to_state: String) -> void:
	pass
