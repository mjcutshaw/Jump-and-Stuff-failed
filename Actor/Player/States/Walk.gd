extends GroundState

#TODO: looking into dampening the acceleration to get going fast, then takes longer to get to top speed
#TODO: particles follow player into air state

func enter() -> void:
	super.enter()

	


func exit() -> void:
	super.exit()

	player.particlesWalking.emitting = false
	player.soundWalk.stop()
	player.previousVelocity = player.velocity


func physics(_delta) -> void:
	super.physics(_delta)

	


func visual(_delta) -> void:
	super.visual(_delta)

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

	

	return State.Null


func state_check(_delta: float) -> int:
	var newState = super.state_check(_delta)
	if newState:
		return newState

	if player.moveDirection.x == 0:
		return State.Idle

	return State.Null
