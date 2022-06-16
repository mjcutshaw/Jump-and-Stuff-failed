extends AirState


func enter() -> void:
	super.enter()

	


func exit() -> void:
	super.exit()

	player.previousVelocity = player.velocity


func physics(_delta) -> void:
	super.physics(_delta)

	velocity_logic(moveSpeed)
	gravity_logic(gravityApex, _delta)


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

	if player.velocity.y > jumpApexHeight:
		return State.Fall

	return State.Null
