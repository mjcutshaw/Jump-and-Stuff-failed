extends GroundState


func enter() -> void:
	super.enter()

	player.velocity.x = 0


func exit() -> void:
	super.exit()

	player.previousVelocity = player.velocity


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

	if !player.is_on_floor():
		return State.Fall
	elif player.moveDirection.x != 0:
		return State.Walk

	return State.Null
