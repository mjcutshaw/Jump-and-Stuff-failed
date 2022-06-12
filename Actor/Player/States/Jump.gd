extends AirState


func enter() -> void:
	super.enter()

	player.velocity.y = jumpVelocityMax


func exit() -> void:
	super.exit()

	


func physics(_delta) -> void:
	super.physics(_delta)

	velocity_logic(moveSpeed)
	gravity_logic(gravityJump, _delta)


func visual(_delta) -> void:
	super.visual(_delta)

	


func handle_input(_event: InputEvent) -> int:
	var newState = super.handle_input(_event)
	if newState:
		return newState

	if Input.is_action_just_released("jump"):
		player.velocity.y = max(player.velocity.y, jumpHeightMin)
		return State.Apex

	return State.Null


func state_check(_delta: float) -> int:
	var newState = super.state_check(_delta)
	if newState:
		return newState

	if player.velocity.y > -jumpApexHeight:
		return State.Apex
	if player.is_on_floor():
		if moveDirection.x != 0:
			return State.Walk
		return State.Idle

	return State.Null
