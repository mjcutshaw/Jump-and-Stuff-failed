extends JumpState

#TODO: consecutive jump states
func enter() -> void:
	super.enter()

	player.coyoteTimer.stop()
	if player.jumpFlip:
		print("side jump")
		player.jumpFlip = false
#	jump_ground_logic()
	player.velocity.y = jumpVelocityMax
	player.jumped = true
	player.sounds.soundJump.play()
	player.particlesJump.restart()



func exit() -> void:
	super.exit()

	player.characterRig.rotation = 0 * PI
	player.jumpFlip = false


func physics(_delta) -> void:
	super.physics(_delta)

	momentum_logic(moveSpeed, true)


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


func jump_ground_logic():
	if player.canJumpDouble:
		player.velocity.y = jumpVelocityMax * jumpDoubleVelocityModifier
		player.sounds.soundJump.pitch_scale = 1.25
		player.particlesJumpDouble.restart()
		player.sounds.soundJump.play()
		player.jumpConsectutiveTimer.stop()
		player.jumpedDouble = true
		player.canJumpDouble = false
		print("double jump")
	elif player.canJumpTriple:
		player.velocity.y = jumpVelocityMax * jumpTripleVelocityModifier
		player.sounds.soundJump.pitch_scale = 1.5
		flip()
		player.particlesJumpTriple.restart()
		player.sounds.soundJump.play()
		player.jumpConsectutiveTimer.stop()
		player.jumpedTriple = true
		player.canJumpTriple = false
		print("triple jump")
	else:
		player.velocity.y = jumpVelocityMax
		player.jumped = true
		player.sounds.soundJump.play()
		player.particlesJump.restart()
		print("single jump")


func flip():
	var tween = create_tween()
	tween.tween_property(player.characterRig,"rotation", -2 * PI, 0.5)
