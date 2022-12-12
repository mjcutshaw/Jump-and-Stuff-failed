class_name GroundState
extends MoveState


var acceleration: float = 0.3 * Util.TILE_SIZE
var friction: float = 0.2 * Util.TILE_SIZE
var crouchFriction: float = 0.1 * Util.TILE_SIZE


func enter() -> void:
	super.enter()

	player.reset(pInfo.abiliyList.All) #TODO: signal


func exit() -> void:
	super.exit()

	player.coyoteTimer.start() #TODO: change to jump


func physics(_delta) -> void:
	super.physics(_delta)

#	player.velocity.y = 10
	
#	if player.moveDirection.x != sign(player.velocity.x) and player.velocity.x > 0 and player.moveDirection.x != 0:
#		await get_tree().create_timer(.1).timeout
#		if Input.is_action_pressed("jump"):
#			print("jump flip phyics")
#			player.jumpFlip = true
#		else:
#			velocity_logic()
#	else:
#		velocity_logic()


func visual(_delta) -> void:
	super.visual(_delta)

	squash_and_strech(_delta)
	


func handle_input(_event: InputEvent) -> int:
	var newState = super.handle_input(_event)
	if newState:
		return newState

	if Input.is_action_just_pressed("dash") and !Input.is_action_pressed("crouch"): #TODO: move to node states
		dash_pressed_buffer()
	

	return State.Null


func state_check(_delta: float) -> int:
	var newState = super.state_check(_delta)
	if newState:
		return newState

	if !player.jumpBufferTimer.is_stopped():
		player.jumpBufferTimer.stop()
		print("buffer jump")
		return State.Jump
	if !player.is_on_floor():
		return State.Fall
	
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
#	if !player.bufferJumpTimer.is_stopped():
#		player.bufferJumpTimer.stop()
#		return State.Jump
#	if !player.is_on_floor():
#		player.coyoteJumpTimer.start()
#		return State.Fall
#	if player.inWater:
#		return State.Swim
#	if player.fallDamage:
#		return State.FallDamage

	return State.Null
