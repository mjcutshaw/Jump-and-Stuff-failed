extends AirState

#TODO: make friction when changing directions
#TODO: only cap fall speed with neutral or only with holding down
func enter() -> void:
	super.enter()

	neutral_move_direction_logic()

func exit() -> void:
	super.exit()

	player.previousVelocity = player.velocity


func physics(_delta) -> void:
	super.physics(_delta)

	#TODO: turn into a reusable function
	if !player.neutralMoveDirection:
		velocity_logic(moveSpeed)
	if player.neutralMoveDirection:
		momentum_logic(moveSpeed, false)
	if player.moveDirection != Vector2.ZERO and player.neutralMoveDirection:
		await get_tree().create_timer(0.1).timeout
		player.neutralMoveDirection = false
	gravity_logic(gravityFall, _delta)
	fall_speed_logic(terminalVelocity)


func visual(_delta) -> void:
	super.visual(_delta)

	if player.moveDirection.x == 0:
		facing(player.facing)
	else:
		facing(player.lastDirection.x)


func handle_input(_event: InputEvent) -> int:
	var newState = super.handle_input(_event)
	if newState:
		return newState

	if Input.is_action_just_pressed("ground_pound"):
		return State.GroundPound
	if Input.is_action_pressed("glide"):
		return State.Glide

	return State.Null


func state_check(_delta: float) -> int:
	var newState = super.state_check(_delta)
	if newState:
		return newState

	

	return State.Null
