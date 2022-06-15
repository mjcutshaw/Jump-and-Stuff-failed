class_name AirState
extends MoveState






func enter() -> void:
	super.enter()

	


func exit() -> void:
	super.exit()

	


func physics(_delta) -> void:
	super.physics(_delta)

	if player.test_move(player.global_transform, Vector2(player.velocity.x * _delta, 0)):
		player.attempt_vertical_corner_correction(player.jumpCornerCorrectionVertical, _delta)


func visual(_delta) -> void:
	super.visual(_delta)

	facing()


func handle_input(_event: InputEvent) -> int:
	var newState = super.handle_input(_event)
	if newState:
		return newState

	if Input.is_action_just_pressed("jump"):
		if !player.coyoteTimer.is_stopped(): 
			player.coyoteTimer.stop()
			print("coyote jump")
			return State.Jump
		else:
			player.jumpBufferTimer.start()

	return State.Null


func state_check(_delta: float) -> int:
	var newState = super.state_check(_delta)
	if newState:
		return newState

	if player.is_on_floor():
		landed_visuals(player.previousVelocity)
		player.particlesLand.restart()
		player.soundLand.play()
		consecutive_jump_logic()
		if player.moveDirection.x != 0:
			return State.Walk
		else:
			return State.Idle

	return State.Null


func velocity_logic(speed) -> void:
	player.velocity.x = player.moveStrength.x * speed


func gravity_logic(amount, _delta) -> void:
	player.velocity.y += amount * _delta


func fall_speed_logic(amount) -> void:
	player.velocity.y = min(player.velocity.y, amount)


func consecutive_jump_logic():
	if player.jumped:
		player.canJumpDouble = true
		player.jumped = false
		player.jumpConsectutiveTimer.start()
	elif player.jumpedDouble:
		player.canJumpTriple = true
		player.jumpedDouble = false
		player.jumpConsectutiveTimer.start()
