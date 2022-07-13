class_name GroundState
extends MoveState


var acceleration: float = 0.3
var friction: float = 0.2
var crouchFriction: float = 0.02


func enter() -> void:
	super.enter()

	player.reset(Abilities.abiliyList.All)


func exit() -> void:
	super.exit()

	player.coyoteTimer.start()


func physics(_delta) -> void:
	super.physics(_delta)

	player.velocity.y = 10
	
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

	if Input.is_action_just_pressed("jump"):
		if Input.is_action_pressed("move_down"):
				player.pass_through_collisions(Globals.SEMISOLID, false)
		else:
			if player.jumpFlip:
				print("jump flip")
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
