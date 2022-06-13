extends DashState

@export  var dash_time = 0.4

var current_dash_time: float = 0
var dash_direction: int = 0



func enter() -> void:
	super.enter()

	current_dash_time = dash_time
	
#	if player.animations.flip_h:
#		dash_direction = -1
#	else:
	dash_direction = 1


func exit() -> void:
	super.exit()

	


func physics(_delta) -> void:
	super.physics(_delta)

	current_dash_time -= _delta


func visual(_delta) -> void:
	super.visual(_delta)

	


func handle_input(_event: InputEvent) -> int:
	var newState = super.handle_input(_event)
	if newState:
		return newState

	

	return State.Null


func state_check(_delta: float) -> int:
	var newState = super.state_check(_delta)
	if newState:
		return newState

	if current_dash_time > 0:
		return State.Null

	if moveDirection.x != 0:
		return State.Walk
	return State.Idle

#	return State.Null
