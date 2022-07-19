extends GroundState

#TODO: if moveDirection == 0, then the friction is lower or only one ice
var crouchSpeedMin: int = 20


func enter() -> void:
	super.enter()

	


func exit() -> void:
	super.exit()

	player.characterRig.scale.y = 1


func physics(_delta) -> void:
	super.physics(_delta)

	#TODO: slow faster if player changes moveDriection
	player.velocity.x = lerp(player.velocity.x, 0, crouchFriction)
	if abs(player.velocity.x) < crouchSpeedMin:
		player.velocity.x = 0


func visual(_delta) -> void:
	super.visual(_delta)

	player.characterRig.scale.y = 0.5
#	facing(player.lastDirection.x)


func sound(_delta: float) -> void:
	super.sound(_delta)

	


func handle_input(_event: InputEvent) -> int:
	var newState = super.handle_input(_event)
	if newState:
		return newState

	if Input.is_action_just_released("crouch"):
		if player.moveDirection.x != 0:
			return State.Walk
		else:
			return State.Idle
	if Input.is_action_just_pressed("jump"):
		if abs(player.velocity.x) > 30:
			return State.JumpLong
		else:
			return State.JumpCrouch
		

	return State.Null


func state_check(_delta: float) -> int:
	var newState = super.state_check(_delta)
	if newState:
		return newState

	

	return State.Null
