extends State

class_name ChargeState

@export var state_machine : StateMachine
@export var ground_state : State
@export var charge_state : State
@export var air_state : State
@export var move_speed : float = 100.0
@export var jump_speed : float = -420.0
@export var charge_animation : String = "charge_air"
@export var jump_animation : String = "jump"
@export var attack_air : String = "attack_02"
@export var attack_ground : String = "attack_03"

var attack_animation : String

func state_process(delta):
	pass
	
func state_input(event : InputEvent):
	if event.is_action_pressed("jump"):
		jump()
	elif event.is_action_released("attack") && character.charging_timer.time_left <= 1.3:
		if !character.is_on_floor():
			attack_animation = "attack_02"
			attack()
		elif character.is_on_floor():
			attack_animation = "attack_03"
			attack()
	elif event.is_action_released("attack") && character.charging_timer.time_left > 1.3:
		if !character.is_on_floor():
			playback.travel("falling")
			next_state = ground_state
		else:
			playback.travel("move")
			next_state = ground_state
	
func on_enter():
#	if has_jumped == true:
#		has_jumped = false
	if is_charging == true:
		is_charging = false
	
func on_exit():
	if is_charging == true:
		is_charging = false

func attack():
	if state_machine.check_if_can_attack():
		playback.travel(attack_animation)
		
func jump():
	if state_machine.check_if_can_jump() && character.is_on_floor():
		has_jumped = true
		character.velocity.y = jump_speed

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == attack_air:
		is_charging = false
		next_state = air_state
		
	elif anim_name == attack_ground:
		is_charging = false
		next_state = ground_state
		
func _on_charging_time_timeout():
	character.charging_timer.stop()
	if character.is_on_floor():
		attack_animation = "attack_03"
		attack()
	elif !character.is_on_floor():
		attack_animation = "attack_02"
		attack()
