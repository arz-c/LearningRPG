extends Node2D


@export var slimes_folder: Node
@export var score_text_label: RichTextLabel
@export var enemy_spawn_radius_min: float = 40
@export var enemy_spawn_radius_max: float = 80
var slime_scene = preload("res://scenes/slime.tscn")

var player_character_body: CharacterBody2D
var score: int = 0


func _ready() -> void:
	player_character_body = get_tree().get_first_node_in_group("player")


func _on_enemy_spawn_timer_timeout() -> void:
	var position_length: float = randf_range(enemy_spawn_radius_min, enemy_spawn_radius_max)
	var position_angle: float = randf_range(-PI, PI)
	var new_position: Vector2 = player_character_body.position \
								+ Vector2.from_angle(position_angle) * position_length

	var slime: Slime = slime_scene.instantiate()
	slime.position = new_position
	slime.connect("died", _on_slime_died)
	slimes_folder.add_child(slime)


func _on_slime_died():
	score += 1
	score_text_label.text = "Score: " + str(score)
	
