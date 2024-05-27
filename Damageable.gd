extends Node

class_name Damageable

signal on_hit(node : Node, damage_taken : int, knockback_direction : Vector2)

@export var health : float = 40:
	get:
		return health
	set(value):
		SignalBus.emit_signal("on_health_changed", get_parent(), value - health)
		health = value

@export var death_animation_name : String = "death"

func hit(damage : int, knockback_direction : Vector2):
	if health > 0:
		health -= damage
		emit_signal("on_hit", get_parent(), damage, knockback_direction)


func _on_animation_tree_animation_finished(anim_name):
	if anim_name == death_animation_name:
		#If character is finished dying, remove from the game.
		get_parent().queue_free()
