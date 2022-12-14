class_name AirState
extends MoveState

#TODO: needs accel
#TODO: will need locks/grace period to switch movedirction to velocity direction after being redirected

func enter() -> void:
	super.enter()

	


func exit() -> void:
	super.exit()

	


func physics(_delta) -> void:
	super.physics(_delta)

	GameStats.timeInAir += _delta
	
	if player.test_move(player.global_transform, Vector2(player.velocity.x * _delta, 0)):
		player.attempt_vertical_corner_correction(player.jumpCornerCorrectionVertical, _delta)


func visual(_delta) -> void:
	super.visual(_delta)

	squash_and_strech(_delta)
	



func handle_input(_event: InputEvent) -> int:
	var newState = super.handle_input(_event)
	if newState:
		return newState

	#TODO: make extention of wall detection for jumping
	if Input.is_action_just_pressed("jump"):
		if !player.wallCoyoteTimer.is_stopped():
			player.wallCoyoteTimer.stop()
			print("wall coyote jump")
			return State.JumpWall
		if !player.coyoteTimer.is_stopped(): 
			player.coyoteTimer.stop()
			print("coyote jump")
			return State.Jump
		else:
			player.jumpBufferTimer.start()
	if Input.is_action_just_pressed("dash"): 
		dash_pressed_buffer()

	return State.Null


func state_check(_delta: float) -> int:
	var newState = super.state_check(_delta)
	if newState:
		return newState

	if player.is_on_wall():
		if abs(player.previousVelocity.x) > moveSpeed:
			return State.Bonk
		else:
			return State.WallSlide
		
	if player.is_on_floor():
		landed_visuals(player.previousVelocity)
		player.particlesLand.restart()
		player.sounds.soundLand.play()
		consecutive_jump_logic()
		if player.moveDirection.x != 0:
			return State.Walk
		elif Input.is_action_pressed("crouch"): #Lookat: best way?
			return State.Crouch
		else:
			return State.Idle
	
	if dashBufferState != BaseState.State.Null:
		if player.can_use_ability(pInfo.abiliyList.DashSide) and dashBufferState == BaseState.State.DashSide:
			dashBufferState = BaseState.State.Null
			return BaseState.State.DashSide
		if player.can_use_ability(pInfo.abiliyList.DashUp) and dashBufferState == BaseState.State.DashUp:
			dashBufferState = BaseState.State.Null
			return BaseState.State.DashUp
		if player.can_use_ability(pInfo.abiliyList.DashDown) and dashBufferState == BaseState.State.DashDown:
			dashBufferState = BaseState.State.Null
			return BaseState.State.DashDown
		

	return State.Null


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


func neutral_air_momentum_logic():
	if !player.neutralMoveDirection:
		velocity_logic(moveSpeed)
	if player.neutralMoveDirection: ## Carry momentum with nuetral moveDirection ##
		momentum_logic(moveSpeed, false)
	if player.moveDirection != Vector2.ZERO and player.neutralMoveDirection: ## Cancael out nuetral momentum
		await get_tree().create_timer(0.1).timeout
		player.neutralMoveDirection = false
