class_name GroundState
extends MoveState

var acceleration: float = 0.4
var friction: float = 0.6

func enter() -> void:
	super.enter()

	


func exit() -> void:
	super.exit()

	player.coyoteTimer.start()


func physics(_delta) -> void:
	super.physics(_delta)

	player.velocity.y += player.gravity
	velocity_logic()


func visual(_delta) -> void:
	super.visual(_delta)

	facing()


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

	if !player.jumpBufferTimer.is_stopped():
		player.jumpBufferTimer.stop()
		print("buffer jump")
		return State.Jump
	if !player.is_on_floor():
		return State.Fall

	return State.Null


func velocity_logic() -> void:
	if player.moveDirection.x != 0:
		player.velocity.x = lerp(player.velocity.x, moveSpeed * player.moveStrength.x, acceleration)
	elif player.moveDirection.x == 0:
		player.velocity.x = lerp(player.velocity.x, 0, friction)
	else:
		print ("ground velocity error")
