class_name DashState
extends MoveState

#TODO: create collision layers for abilities
var dashTime = 0.6
var dashSpeed: int = moveSpeed * 2.5

#TODO:  convert to these
var distance:= 6 * Globals.TILE_SIZE
var duration:= 0.3
@onready var speed:= distance/duration


func enter() -> void:
	super.enter()

	player.soundDash.play()


func exit() -> void:
	super.exit()

	if player.moveDirection == Vector2.ZERO:
		player.neutralMoveDirection = true
	else:
		player.neutralMoveDirection = false
		player.velocity = player.previousVelocity


func physics(_delta) -> void:
	super.physics(_delta)

	


func visual(_delta) -> void:
	super.visual(_delta)

	


func handle_input(_event: InputEvent) -> int:
	var newState = super.handle_input(_event)
	if newState:
		return newState

	

	return State.Null


func state_check(_delta: float) -> int:
	var newState = super.state_check(_delta)
	if newState:
		return newState

	#TODO: move stuff from dash states once timer is added

	return State.Null
