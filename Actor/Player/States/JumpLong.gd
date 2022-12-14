extends JumpState

@export var velocityModifier: float = 1.35
#FIXME: long jump broke in left direction
func enter() -> void:
	super.enter()

	player.velocity.y = jumpVelocityMax
	player.velocity.x = moveSpeed * velocityModifier * player.facing
	player.particlesJumpTriple.restart()
	player.sounds.soundJump.pitch_scale = 0.5
	player.sounds.soundJump.play()


func exit() -> void:
	super.exit()

#	player.previousVelocity = player.velocity


func physics(_delta) -> void:
	super.physics(_delta)

	#TODO: need to have some control to pull back on moveDirection
	momentum_logic(moveSpeed, false)


func visual(_delta) -> void:
	super.visual(_delta)

	


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
