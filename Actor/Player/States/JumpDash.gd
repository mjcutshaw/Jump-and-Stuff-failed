extends JumpState


func enter() -> void:
	super.enter()

	player.velocity.y = jumpVelocityMax
#	player.velocity.x = moveSpeed * dashJumpBoostVelocityModifier * player.lastDirection.x
	player.velocity.x = player.facing * max(moveSpeed * dashJumpBoostVelocityModifier, abs(player.velocity.x))
	#FIXME: facing is reading wrong when going left
	player.particlesJumpTriple.restart()
	player.sounds.soundJump.pitch_scale = 0.25
	player.sounds.soundJump.play()


func exit() -> void:
	super.exit()

#	player.previousVelocity = player.velocity


func physics(_delta) -> void:
	super.physics(_delta)

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

	if dashBufferState != BaseState.State.Null:
		if player.can_use_ability(pInfo.abiliyList.DashJump) and dashBufferState == BaseState.State.DashJump:
			dashBufferState = BaseState.State.Null
			return BaseState.State.DashJump
		if player.can_use_ability(pInfo.abiliyList.DashSide) and dashBufferState == BaseState.State.DashSide:
			dashBufferState = BaseState.State.Null
			return BaseState.State.DashSide
		if player.can_use_ability(pInfo.abiliyList.DashUp) and dashBufferState == BaseState.State.DashUp:
			dashBufferState = BaseState.State.Null
			return BaseState.State.DashUp
		if player.can_use_ability(pInfo.abiliyList.DashDown) and dashBufferState == BaseState.State.DashDown:
			dashBufferState = BaseState.State.Null
			return BaseState.State.DashDown
#	if player.dashContactTimer.is_stopped() and player.is_on_floor():
#		return State.Idle
#		#TODO add stun state

	return State.Null
