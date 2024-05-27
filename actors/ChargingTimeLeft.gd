extends Label

@export var character : CharacterBody2D

func _process(delta):
	text = "Charge Time: " + str(character.charging_timer.time_left)
