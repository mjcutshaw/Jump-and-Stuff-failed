extends WallState

#TODO: has a bad interaction with exiting into glide

func enter() -> void:
	super.enter()

	


func exit() -> void:
	super.exit()

#	player.previousVelocity = player.velocity


func physics(_delta) -> void:
	super.physics(_delta)

#	if player.moveDirection.y == 1:
	player.velocity.y = moveSpeed * player.moveDirection.y


func visual(_delta) -> void:
	super.visual(_delta)

	facing(-player.lastWallDirection.x)


func sound(_delta: float) -> void:
	super.sound(_delta)

	


func handle_input(_event: InputEvent) -> int:
	var newState = super.handle_input(_event)
	if newState:
		return newState

	if Input.is_action_just_released("grab"):
		return State.WallSlide

	return State.Null


func state_check(_delta: float) -> int:
	var newState = super.state_check(_delta)
	if newState:
		return newState

	

	return State.Null
