extends State

class_name GroundState

@export var state_machine : StateMachine
@export var ground_state : State
@export var air_state : State
@export var charge_state : State
@export var block_state : State
@export var move_speed : float = 200.0
@export var jump_speed : float = -420.0
@export var idle_animation : String = "idle"
@export var run_animation : String = "run"
@export var jump_animation : String = "jump"
@export var falling_animation : String = "falling"
@export var charge_animation : String = "charge_ground"
@export var attack_node : String = "attack_03"
@export var gun_out_animation : String = "gun_out"
@export var gun_shoot_animation : String = "gun_shoot"
@export var gun_in_animation : String = "gun_in"
@export var block_animation : String = "block"

@onready var buffer_timer : Timer = $BufferTimer

func _physics_process(delta):
	# Handle Movement
	character.direction = Input.get_vector("left", "right", "up", "down")
	if state_machine.check_if_can_move():
		character.velocity.x = character.direction.x * move_speed
	if  state_machine.check_if_can_move() && state_machine.current_state == charge_state:
		character.velocity.x = character.direction.x * charge_state.move_speed
	if  state_machine.check_if_can_move() && state_machine.current_state == block_state:
		character.velocity.x = character.direction.x * charge_state.move_speed
	character.move_and_slide()

func state_input(event : InputEvent):
	if event.is_action_pressed("jump"):
		jump()
	elif event.is_action_pressed("attack"):
		charge()
	elif event.is_action_pressed("block"):
		block()
	elif event.is_action_pressed("gunfire"):
		gunfire()

func state_process(delta):
	if is_charging == true:
		is_charging = false
		next_state = charge_state
	elif is_blocking == true:
		is_blocking = false
		next_state = block_state
	elif !character.is_on_floor():
		next_state = air_state
	
func on_enter():
	if is_charging == true:
		is_charging = false
	
func on_exit():
	if is_charging == true:
		is_charging = false

func jump():
	if state_machine.check_if_can_jump() && character.is_on_floor():
		character.velocity.y = jump_speed
		playback.travel(jump_animation)
		has_jumped = true
		
func block():
	playback.travel(block_animation)
	is_blocking = true

func charge():
	if state_machine.check_if_can_charge():
		buffer_timer.start()
		playback.travel(charge_animation)
		is_charging = true
		
func gunfire():
	playback.travel(gun_out_animation)



#func _on_buffer_timer_timeout():
#	is_charging = true
