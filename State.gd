extends Node

class_name State

@export var can_move : bool = true
@export var can_jump : bool = false
@export var can_attack : bool = false
@export var can_charge : bool = true
@export var can_block : bool = true

var character : CharacterBody2D
var playback : AnimationNodeStateMachinePlayback
var next_state : State
var current_state : State
var has_jumped : bool = false
var is_charging : bool = false
var is_blocking : bool = false

signal interrupt_state(new_state : State)

func state_process(delta):
	pass
	
func state_input(event : InputEvent):
	pass
	
func on_enter():
	pass
	
func on_exit():
	pass
