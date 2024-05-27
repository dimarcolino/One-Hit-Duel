extends CharacterBody2D

class_name Player

@export var move_speed = 200.0
@export var state : State

@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : StateMachine = $StateMachine
@onready var charging_timer : Timer = $ChargingTime

# Get the gravity from the project settings to be synced with RigidBody nodes.

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2 = Vector2.ZERO

signal facing_direction_changed(facing_right : bool)

func _process(delta):
	pass

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Handles Movement.
	#direction = Input.get_vector("left", "right", "up", "down")
	#if direction.x != 0 && state_machine.check_if_can_move():
	#	velocity.x = direction.x * move_speed
	#else:
	#	velocity.x = move_toward(velocity.x, 0, move_speed)

	#move_and_slide()
	update_animation_parameters()
	update_face_direction()
	
func _input(event):
	if event.is_action_pressed("attack"):
		state.is_charging = true
		charging_timer.start()
	elif event.is_action_released("attack"):
		#print_debug(charging_timer.time_left)
		charging_timer.stop()
	
func update_face_direction():
	if direction == Vector2.LEFT:
		sprite.flip_h = true
	elif direction == Vector2.RIGHT:
		sprite.flip_h = false
	emit_signal("facing_direction_changed", !sprite.flip_h)

func update_animation_parameters():
	animation_tree.set("parameters/move/blend_position", direction.x)
