extends State

class_name AttackState

@export var state_machine : StateMachine
@export var ground_state : State
@export var landing_state : State
@export var air_state : State
@export var move_speed : float =  300.0
@export var jump_speed : float = -600.0
@export var jump_animation : String = "jump"
@export var attack_ground : String = "attack_03"
@export var attack_air : String = "attack_02"


#func state_process(delta):



func state_input(event : InputEvent):
	if event.is_action_released("attack"):
		attack()
	#if event.is_action_pressed("jump"):
	#	jump()
	

func _on_animation_tree_animation_finished(skill):
	if skill == "attack_02":
		next_state = ground_state
	elif skill == "attack_03":
		next_state = ground_state
		
func jump():
	if state_machine.check_if_can_jump():
		character.velocity.y = jump_speed
		playback.travel(jump_animation)
		
func attack():
	if character.is_on_floor() && state_machine.check_if_can_attack():
		playback.travel(attack_ground)
		
	#elif !character.is_on_floor() && state_machine.check_if_can_attack():
	#	playback.travel(attack_air)
