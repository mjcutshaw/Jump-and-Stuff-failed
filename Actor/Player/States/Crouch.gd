extends GroundState

#TODO: if moveDirection == 0, then the friction is lower or only one ice
var crouchSpeedMin: int = 20
var transformTime: float = 0.2

func enter() -> void:
	super.enter()

	


func exit() -> void:
	super.exit()

	player.characterRig.scale.y = 1


func physics(_delta) -> void:
	super.physics(_delta)

	#TODO: slow faster if player changes moveDirection
	
	player.velocity.x = move_toward(player.velocity.x, 0, crouchFriction)
	if abs(player.velocity.x) < crouchSpeedMin:
		player.velocity.x = 0


func visual(_delta) -> void:
	super.visual(_delta)

	var tween = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT).set_parallel(true)
#	tween.tween_property(player.characterRig, "position", Vector2(0,-16), transformTime).from_current()
	tween.tween_property(player.characterRig, "scale", Vector2(1 * player.facing, 0.5), transformTime).from_current()
	#TODO: change to player, need to change all instances

func sound(_delta: float) -> void:
	super.sound(_delta)

	


func handle_input(_event: InputEvent) -> int:
	var newState = super.handle_input(_event)
	if newState:
		return newState

	if Input.is_action_just_pressed("jump"):
		if abs(player.velocity.x) > 30:
			return State.JumpLong
		else:
			return State.JumpCrouch
	if Input.is_action_just_pressed("slide"):
		return State.Slide

	return State.Null


func state_check(_delta: float) -> int:
	var newState = super.state_check(_delta)
	if newState:
		return newState

	if Input.is_action_just_released("crouch"):
		if player.moveDirection.x != 0:
			return State.Walk
		else:
			return State.Idle

	return State.Null


