class_name DashState
extends MoveState


var dashTime = 0.3
var dashDistance: int = 10 * Globals.TILE_SIZE
var dashSpeed: int = dashDistance/dashTime


func enter() -> void:
	super.enter()

	player.sounds.soundDash.play()
	GameStats.dashes += 1


func exit() -> void:
	super.exit()

	if player.moveDirection == Vector2.ZERO:
		player.neutralMoveDirection = true
	else:
		player.neutralMoveDirection = false
		velocity_logic(moveSpeed)


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

	

	return State.Null
