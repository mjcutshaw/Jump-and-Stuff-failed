extends GroundState


func enter() -> void:
	super.enter()

	player.velocity.x = 0


func exit() -> void:
	super.exit()

	


func physics(_delta) -> void:
	super.physics(_delta)

	


func visual(_delta) -> void:
	super.visual(_delta)

	


func handle_input(_event: InputEvent) -> int:
	var newState = super.handle_input(_event)
	if newState:
		return newState

	if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
		return State.Walk
	elif Input.is_action_just_pressed("jump"):
		return State.Jump
	elif Input.is_action_just_pressed("dash"):
		return State.Dash

	return State.Null


func state_check(_delta: float) -> int:
	var newState = super.state_check(_delta)
	if newState:
		return newState

	if !player.is_on_floor():
		return State.Fall

	return State.Null
