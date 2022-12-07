extends DashState

#TODO: dashing with a quick jump press to wave dash
var currentDashTime: float = 0


func enter() -> void:
	super.enter()

	player.consume(pInfo.abiliyList.DashDown, 1)
	player.pass_through_collisions(CollisionLayer.DashDown, false)
	currentDashTime = dashTime
	player.velocity.y = max(dashSpeed, abs(player.velocity.y))
	player.particlesDashDown.restart()


func exit() -> void:
	super.exit()

	player.pass_through_collisions(CollisionLayer.DashDown, true)
	player.particlesDashDown.emitting = false


func physics(_delta) -> void:
	super.physics(_delta)

	currentDashTime -= _delta
	player.velocity.x = 0


func visual(_delta) -> void:
	super.visual(_delta)

	facing(player.lastDirection.x)


func handle_input(_event: InputEvent) -> int:
	var newState = super.handle_input(_event)
	if newState:
		return newState

	

	return State.Null


func state_check(_delta: float) -> int:
	var newState = super.state_check(_delta)
	if newState:
		return newState

	if currentDashTime > 0:
		return State.Null

	if player.is_on_floor():
		if player.moveDirection.x != 0:
			return State.Walk
		return State.Idle
	
	return State.Fall

#	return State.Null
