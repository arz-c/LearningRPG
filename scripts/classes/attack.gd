class_name Attack

var damage: float
var knockback: float
var origin: Vector2

func _init(p_damage, p_knockback, p_origin) -> void:
	damage = p_damage
	knockback = p_knockback
	origin = p_origin
