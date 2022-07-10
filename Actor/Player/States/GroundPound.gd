extends AirState

#TODO: hit box to break walls. ground pound enemy mid air to destroy walls

func enter() -> void:
	super.enter()

	player.velocity.x = 0


func exit() -> void:
	super.exit()

	


func physics(_delta) -> void:
	super.physics(_delta)

	player.velocity.x = 0
	player.velocity.y = 2000


func visual(_delta) -> void:
	super.visual(_delta)

	facing(player.lastDirection.x)


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

	

	return State.Null
