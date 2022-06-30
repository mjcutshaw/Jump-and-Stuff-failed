extends MoveState
class_name WallState



func enter() -> void:
	super.enter()

	


func exit() -> void:
	super.exit()

#	player.previousVelocity = player.velocity


func physics(_delta) -> void:
	super.physics(_delta)

	


func visual(_delta) -> void:
	super.visual(_delta)

	


func sound(_delta: float) -> void:
	super.sound(_delta)

	


func handle_input(_event: InputEvent) -> int:
	var newState = super.handle_input(_event)
	if newState:
		return newState

	if Input.is_action_just_pressed("jump"):
		return State.JumpWall

	return State.Null


func state_check(_delta: float) -> int:
	var newState = super.state_check(_delta)
	if newState:
		return newState

	if !player.is_on_wall():
		player.wallCoyoteTimer.start()
		return State.Fall
	if  player.moveDirection.x < 0:
		if player.facing == -1:
			player.velocity += Vector2(-20,-10)
			player.wallCoyoteTimer.start()
			return State.Fall
	elif player.moveDirection.x > 0:
		if player.facing == 1:
			player.velocity += Vector2(20, -10)
			player.wallCoyoteTimer.start()
			return State.Fall

	return State.Null
