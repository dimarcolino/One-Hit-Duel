extends State
#
class_name LandingState

@export var state_machine : StateMachine
@export var ground_state : State
@export var air_state : State
@export var attack_state : State
@export var jump_speed : float = -600.0
@export var jump_animation : String = "jump"
@export var landing_animation : String = "landing"
@export var attack_node : String = "attack_03"

#func state_process(delta):
	#if character.is_on_floor():
	#	playback.travel(landing_animation)
		
func state_input(event : InputEvent):
	if event.is_action_pressed("jump"):
		jump()
	if event.is_action_pressed("attack"):
		attack()

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == landing_animation:
		next_state = ground_state

func jump():
	if state_machine.check_if_can_jump():
		character.velocity.y = jump_speed
		playback.travel(jump_animation)

func attack():
	if state_machine.check_if_can_attack():
		playback.travel(attack_node)
