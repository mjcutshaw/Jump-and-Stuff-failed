extends AirState

#export (float) var move_speed = 60


func enter() -> void:
	super.enter()

	


func exit() -> void:
	super.exit()

	


func physics(_delta) -> void:
	super.physics(_delta)

	velocity_logic(moveSpeed)
	gravity_logic(gravityFall, _delta)
	fall_speed_logic(terminalVelocity)


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

	if player.is_on_floor():
		if moveDirection.x != 0:
			return State.Walk
		else:
			return State.Idle

	return State.Null
