extends GroundState


func enter() -> void:
	super.enter()

	


func exit() -> void:
	super.exit()

	player.previousVelocity = player.velocity


func physics(_delta) -> void:
	super.physics(_delta)

	player.velocity.x = lerp(player.velocity.x, 0, friction)


func visual(_delta) -> void:
	super.visual(_delta)

	facing(player.facing)


func handle_input(_event: InputEvent) -> int:
	var newState = super.handle_input(_event)
	if newState:
		return newState

	if Input.is_action_just_pressed("jump"):
		return State.Jump
	if Input.is_action_just_pressed("crouch"):
		return State.Crouch

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
