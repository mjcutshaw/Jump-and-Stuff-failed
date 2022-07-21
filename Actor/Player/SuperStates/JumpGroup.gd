extends AirState
class_name JumpState

func enter() -> void:
	super.enter()

	GameStats.jumps += 1


func exit() -> void:
	super.exit()

	player.sounds.soundJump.stop()
	player.sounds.soundJump.pitch_scale = 1
	player.previousVelocity = player.velocity


func physics(_delta) -> void:
	super.physics(_delta)

	gravity_logic(gravityJump, _delta)
	
	if player.test_move(player.global_transform, Vector2(0, player.velocity.y * _delta)):
		player.attempt_horizontal_corner_correction(player.jumpCornerCorrectionHorizontal, _delta)


func visual(_delta) -> void:
	super.visual(_delta)

#	if wallHop:
#		facing(-player.lastWallDirection.x)
	if player.moveDirection.x == 0:
		facing(player.facing)
	else:
		facing(player.lastDirection.x)


func sound(_delta: float) -> void:
	super.sound(_delta)

	


func handle_input(_event: InputEvent) -> int:
	var newState = super.handle_input(_event)
	if newState:
		return newState

	if Input.is_action_just_released("jump"):
		if player.jumpedDouble or player.jumpedTriple:
			#FIXME: figure out a better way to push the minimum hight for these jumps
			player.velocity.y = max(player.velocity.y, jumpVelocityMin * 5)
		else: 
			player.velocity.y = max(player.velocity.y, jumpVelocityMin)
		jump_canceled()
		return State.Fall
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


func jump_canceled():
	player.jumped = false
	player.jumpedDouble = false
	player.jumpedTriple = false
