extends AirState

#TODO: variables
func enter() -> void:
	super.enter()

	


func exit() -> void:
	super.exit()

	


func physics(_delta) -> void:
	super.physics(_delta)

	velocity_logic(moveSpeed/2)
	gravity_logic(gravityGlide, _delta)
	fall_speed_logic(terminalVelocity/6)


func visual(_delta) -> void:
	super.visual(_delta)

	


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
