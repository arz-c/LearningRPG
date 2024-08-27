extends State


@export var enemy_character_body: CharacterBody2D
@export var attack_area: Area2D
@export var damage: float = 10
@export var cooldown: float = 0.5
@export var radius: float = 40

var player_character_body: CharacterBody2D
var elapsed_time: float


func _ready() -> void:
	state_string = "enemy_attack"
	player_character_body = get_tree().get_first_node_in_group("player")
	attack_area.connect("area_entered", _on_attack_area_area_entered)


func _physics_process(delta: float) -> void:
	elapsed_time += delta

	if elapsed_time >= cooldown:
		elapsed_time = 0
		attack_area.monitoring = true

	if enemy_character_body.position.distance_to(player_character_body.position) <= radius:
		enemy_character_body.velocity = enemy_character_body.velocity.move_toward(
												Vector2.ZERO,
											delta * 50)
	else:
		transitioned.emit(state_string, "enemy_chase")


func enter(_from_state: String) -> void:
	elapsed_time = 0


func exit(_to_state: String) -> void:
	attack_area.monitoring = false


func _on_attack_area_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		var attack: Attack = Attack.new(damage, 0, enemy_character_body.position)
		area.damage(attack)

		attack_area.set_deferred("monitoring", false)
