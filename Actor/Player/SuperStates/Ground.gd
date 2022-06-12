class_name GroundState
extends MoveState

var acceleration: float = 0.4
var friction: float = 0.6

func enter() -> void:
	super.enter()

	


func exit() -> void:
	super.exit()

	


func physics(_delta) -> void:
	super.physics(_delta)

	player.velocity.y += player.gravity
	velocity_logic()


func visual(_delta) -> void:
	super.visual(_delta)

	


func handle_input(_event: InputEvent) -> int:
	var newState = super.handle_input(_event)
	if newState:
		return newState

	if Input.is_action_just_pressed("jump"):
		return State.Jump

	return State.Null


func state_check(_delta: float) -> int:
	var newState = super.state_check(_delta)
	if newState:
		return newState

	if !player.is_on_floor():
		return State.Fall

	return State.Null


func velocity_logic() -> void:
	if moveDirection.x != 0:
		player.velocity.x = lerp(player.velocity.x, moveSpeed * moveStrength.x, acceleration)
	elif moveDirection.x == 0:
		player.velocity.x = lerp(player.velocity.x, 0, friction)
	else:
		print ("ground velocity error")
