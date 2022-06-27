extends AirState

var glideSpeedModifier: int = 2
var glideFallSpeedModifier: int = 6

func enter() -> void:
	super.enter()

	neutral_move_direction_logic()


func exit() -> void:
	super.exit()

	player.previousVelocity = player.velocity


func physics(_delta) -> void:
	super.physics(_delta)

	#TODO: get momentun with neutral moveDirection
	if !player.neutralMoveDirection:
		velocity_logic(moveSpeed/glideSpeedModifier)
	if player.neutralMoveDirection:
		momentum_logic(moveSpeed, false)
	if player.moveDirection != Vector2.ZERO and player.neutralMoveDirection:
		await get_tree().create_timer(.2).timeout
		player.neutralMoveDirection = false
	
	gravity_logic(gravityGlide, _delta)
	fall_speed_logic(terminalVelocity/glideFallSpeedModifier)


func visual(_delta) -> void:
	super.visual(_delta)

	facing(player.lastDirection.x)


func sound(_delta: float) -> void:
	super.sound(_delta)

	


func handle_input(_event: InputEvent) -> int:
	var newState = super.handle_input(_event)
	if newState:
		return newState

	if Input.is_action_just_released("glide"):
		return State.Fall

	return State.Null


func state_check(_delta: float) -> int:
	var newState = super.state_check(_delta)
	if newState:
		return newState

	

	return State.Null
