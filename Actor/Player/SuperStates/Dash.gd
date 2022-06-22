class_name DashState
extends MoveState

var dashTime = 0.6
var dashSpeed: int = moveSpeed * 2


func enter() -> void:
	super.enter()

	


func exit() -> void:
	super.exit()

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
