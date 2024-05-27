extends State

class_name BlockState

@export var state_machine : StateMachine
@export var ground_state : State
@export var air_state : State

func state_input(event : InputEvent):
	if event.is_action_released("block"):
		playback.travel("move")
		next_state = ground_state
	elif event.is_action_pressed("jump"):
		jump()

func jump():
	if state_machine.check_if_can_jump() && character.is_on_floor():
		has_jumped = true
		character.velocity.y = ground_state.jump_speed

func on_enter():
	pass
