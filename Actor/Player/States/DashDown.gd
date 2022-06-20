extends DashState

#TODO: dashing with a quick jump press to wave dash
@export  var dash_time = 0.4

var current_dash_time: float = 0



func enter() -> void:
	super.enter()

	player.consume(PlayerAbilities.abiliyList.DashDown, 1)
	current_dash_time = dash_time
	player.velocity.y = max(dashSpeed, abs(player.velocity.y))


func exit() -> void:
	super.exit()

	


func physics(_delta) -> void:
	super.physics(_delta)

	current_dash_time -= _delta
	player.velocity.x = 0


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

	if player.is_on_floor():
		if player.moveDirection.x != 0:
			return State.Walk
		return State.Idle
	
	return State.Fall

#	return State.Null
