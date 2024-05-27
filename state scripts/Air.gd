extends State

class_name AirState

@export var state_machine : StateMachine
@export var ground_state : State
@export var charge_state : State
@export var block_state : State
@export var falling_animation : String = "falling"
@export var landing_animation: String = "landing"
@export var charge_animation : String = "charge_air"
@export var attack_node : String = "attack_02"
@export var block_animation : String = "block"

var animation : String

func state_input(event : InputEvent):
	if event.is_action_pressed("attack"):
		is_charging = true
		charge()
	elif event.is_action_pressed("block"):
		block()

func state_process(delta):
	if is_charging == true:
		is_charging = false
		next_state = charge_state
		animation = "charge"
	if is_blocking == true:
		is_blocking = false
		next_state = block_state
	elif character.is_on_floor():
		animation = "falling"
		next_state = ground_state
		playback.travel("move")
	elif character.velocity.y > 0 && animation != "charge":
		playback.travel("falling")

func on_enter():
	pass
	
func on_exit():
	pass
		
func block():
	playback.travel(block_animation)
	is_blocking = true
		
func charge():
	if state_machine.check_if_can_charge():
		playback.travel(charge_animation)
		is_charging = true
