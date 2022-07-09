extends JumpState
#TODO: rename to jumpWall
var wallHop: bool = false

func enter() -> void:
	super.enter()

#	if player.moveDirection.y == -1:
		#TODO: make up jump different
	if player.moveDirection.x == -player.lastWallDirection.x:
		player.velocity = Vector2(50 * player.lastWallDirection.x, jumpVelocityMax)
		wallHop = true
	else:
		player.velocity.y = jumpVelocityMax
		player.velocity.x = moveSpeed * player.lastWallDirection.x
	player.particlesJumpWall.restart()


func exit() -> void:
	super.exit()

	wallHop = false
#	player.previousVelocity = player.velocity


func physics(_delta) -> void:
	super.physics(_delta)

	if !wallHop:
		if player.moveDirection.x == 0:
			momentum_logic(moveSpeed, false)
		else:
			momentum_logic(moveSpeed, true)


func visual(_delta) -> void:
	super.visual(_delta)

#	if wallHop:
#		facing(-player.lastWallDirection.x)
#	else:
#		facing(player.lastWallDirection.x)


func sound(_delta: float) -> void:
	super.sound(_delta)

	


func handle_input(_event: InputEvent) -> int:
	var newState = super.handle_input(_event)
	if newState:
		return newState

	

	return State.Null


func state_check(_delta: float) -> int:
	var newState = super.state_check(_delta)
	if newState:
		return newState

	

	return State.Null
