extends WallState


var slideSpeed: int = 7 * Util.TILE_SIZE
var quickSlideSpeed: int = 12 * Util.TILE_SIZE


func enter() -> void:
	super.enter()

	player.particlesWallSlide.restart()


func exit() -> void:
	super.exit()

	player.particlesWallSlide.emitting = false
#	player.previousVelocity = player.velocity


func physics(_delta) -> void:
	super.physics(_delta)

	gravity_logic(gravityFall, _delta)
	cap_wall_slide_speed(slideSpeed)


func visual(_delta) -> void:
	super.visual(_delta)

	facing(player.lastWallDirection.x)


func sound(_delta: float) -> void:
	super.sound(_delta)

	


func handle_input(_event: InputEvent) -> int:
	var newState = super.handle_input(_event)
	if newState:
		return newState

	if Input.is_action_pressed("grab"):
		return State.WallGrab

	return State.Null


func state_check(_delta: float) -> int:
	var newState = super.state_check(_delta)
	if newState:
		return newState

	if player.is_on_floor():
		if player.moveDirection.x != 0:
			return State.Walk
		return State.Idle

	return State.Null


func cap_wall_slide_speed(amount):
	player.velocity.y = min(player.velocity.y, amount)
