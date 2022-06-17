extends AirState
class_name JumpGround
#TODO: Create jump superstate
#TODO: flip player in direction when jump flip
#TODO: break out crouch jumps to own states

func enter() -> void:
	super.enter()

	player.coyoteTimer.stop()
	if player.jumpFlip:
		print("side jump")
		player.jumpFlip = false
	jump_ground_logic()
	
#	player.consume(player.a.Jump , 1)


func exit() -> void:
	super.exit()

	player.soundJump.stop()
	player.soundJump.pitch_scale = 1
	player.previousVelocity = player.velocity
	player.characterRig.rotation = 0 * PI
	player.jumpFlip = false


func physics(_delta) -> void:
	super.physics(_delta)

	velocity_logic(moveSpeed)
	gravity_logic(gravityJump, _delta)
	
	if player.test_move(player.global_transform, Vector2(0, player.velocity.y * _delta)):
		player.attempt_horizontal_corner_correction(player.jumpCornerCorrectionHorizontal, _delta)


func visual(_delta) -> void:
	super.visual(_delta)

	


func sound(_delta: float) -> void:
	super.sound(_delta)

	


func handle_input(_event: InputEvent) -> int:
	var newState = super.handle_input(_event)
	if newState:
		return newState

	if Input.is_action_just_released("jump"):
		if player.jumpedDouble or player.jumpedTriple:
			#FIXME: figure out a better way to push the minium hight for these jumps
			player.velocity.y = max(player.velocity.y, jumpHeightMin * 5)
		else: 
			player.velocity.y = max(player.velocity.y, jumpHeightMin)
		jump_canceled()
		return State.Apex
	if Input.is_action_just_pressed("ground_pound"):
		return State.GroundPound

	return State.Null


func state_check(_delta: float) -> int:
	var newState = super.state_check(_delta)
	if newState:
		return newState

	if player.is_on_ceiling():
		jump_canceled()
		return State.Apex
	elif player.velocity.y > -jumpApexHeight:
		return State.Apex

	return State.Null


func jump_ground_logic():
	#TODO: particles for long and crouch 
	if player.jumpLong:
		player.velocity.y = jumpVelocityMax
		player.velocity.x = moveSpeed * 2.5 * player.moveDirection.x
		player.particlesJumpTriple.restart()
		player.soundJump.pitch_scale = 0.5
		player.soundJump.play()
		player.jumpLong = false
		print("crouch jump")
	elif player.jumpCrouch:
		player.velocity.y = jumpVelocityMax * jumpCrouchVelocityModifier
		player.velocity.x = 0
		player.particlesJumpTriple.restart()
		player.soundJump.pitch_scale = 2
		player.soundJump.play()
		player.jumpCrouch = false
		print("crouch jump")
	elif player.canJumpDouble:
		player.velocity.y = jumpVelocityMax * jumpDoubleVelocityModifier
		player.soundJump.pitch_scale = 1.25
		player.particlesJumpDouble.restart()
		player.soundJump.play()
		player.jumpConsectutiveTimer.stop()
		player.jumpedDouble = true
		player.canJumpDouble = false
		print("double jump")
	elif player.canJumpTriple:
		player.velocity.y = jumpVelocityMax * jumpTripleVelocityModifier
		player.soundJump.pitch_scale = 1.5
		flip()
		player.particlesJumpTriple.restart()
		player.soundJump.play()
		player.jumpConsectutiveTimer.stop()
		player.jumpedTriple = true
		player.canJumpTriple = false
		print("triple jump")
	else:
		player.velocity.y = jumpVelocityMax
		player.jumped = true
		player.soundJump.play()
		player.particlesJump.restart()
		print("single jump")


func jump_canceled():
	player.jumped = false
	player.jumpedDouble = false
	player.jumpedTriple = false


func flip():
	var tween = create_tween()
	tween.tween_property(player.characterRig,"rotation", -2 * PI, 0.5)
