extends MoveState

#TODO: sheepo burrow had you having to jump between burrowing locations and not losing the transformation
#burrow dash our of ground for distance and break into places

func enter() -> void:
	super.enter()

	


func exit() -> void:
	super.exit()

#	player.previousVelocity = player.velocity


func physics(_delta) -> void:
	super.physics(_delta)

	


func visual(_delta) -> void:
	super.visual(_delta)

	


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
