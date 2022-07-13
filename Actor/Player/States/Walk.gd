extends GroundState

#TODO: looking into dampening the acceleration to get going fast, then takes longer to get to top speed
#FIXME: jump flip is not correctly implemented and only works flipping from the right
#TODO: create ledge stop detection. to quickly stop in movedirection = 0 when coming to a ledge
#TODO: make friction when changing directions
#TODO: timer that slows the player down after being in it for too long
#TODO: walk on fluids, might be its own state

var goIdle: bool = false
var rotation: float

func enter() -> void:
	super.enter()

	


func exit() -> void:
	super.exit()

	player.particlesWalking.emitting = false
	player.soundWalk.stop()
	player.previousVelocity = player.velocity
	goIdle = false


func physics(_delta) -> void:
	super.physics(_delta)
	#TODO: https://kidscancode.org/godot_recipes/2d/2d_align_surface/
#	rotation = player.get_floor_normal().angle() + PI/2
#	player.set_up_direction(player.transform.y * 128)
#	player.velocity = player.velocity.rotated(rotation)
	

	if player.moveDirection.x == 0:
		await get_tree().create_timer(.2).timeout
		goIdle = true
	if player.moveDirection.x != sign(player.velocity.x) and player.velocity.x > 0 and player.moveDirection.x != 0:
		await get_tree().create_timer(.1).timeout
		if Input.is_action_pressed("jump"):
			print("jump flip phyics")
			player.jumpFlip = true
		else:
			velocity_logic(moveSpeed)
	else:
		#change to reusable function
		player.velocity.x = max(lerp(abs(player.velocity.x), moveSpeed, acceleration), abs(player.velocity.x)) * player.moveStrength.x

func visual(_delta) -> void:
	super.visual(_delta)

	facing(player.lastDirection.x)
	player.particlesWalking.emitting = true
	


func sound(_delta: float) -> void:
	super.sound(_delta)

	if !player.soundWalk.playing:
		player.soundWalk.pitch_scale = randf_range(0.8, 1.2)
		player.soundWalk.play()


func handle_input(_event: InputEvent) -> int:
	var newState = super.handle_input(_event)
	if newState:
		return newState

	if Input.is_action_just_pressed("crouch"):
		return State.Crouch
	

	return State.Null


func state_check(_delta: float) -> int:
	var newState = super.state_check(_delta)
	if newState:
		return newState

	if player.jumpFlip:
		return State.Jump
	if player.moveDirection.x == 0 and goIdle:
		return State.Idle

	return State.Null
