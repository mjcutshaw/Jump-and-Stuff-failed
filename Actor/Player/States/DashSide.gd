extends DashState


var currentDashTime: float = 0
var dashDirection: int = 0
var jumpBoostTime: float = 0.10
var currentjumpBoostTime: float = 0


func enter() -> void:
	super.enter()

	player.consume(Abilities.abiliyList.DashSide, 1)
	player.pass_through_collisions(Globals.DASH_SIDE, false)
	currentDashTime = dashTime
	dashDirection = player.facing
	player.velocity.x = dashDirection * max(dashSpeed, abs(player.velocity.x))
	player.particlesDashSide.restart()


func exit() -> void:
	super.exit()

	player.pass_through_collisions(Globals.DASH_SIDE, true)
	player.particlesDashSide.emitting = false


func physics(_delta) -> void:
	super.physics(_delta)

	currentDashTime -= _delta
	currentjumpBoostTime -= _delta
	player.velocity.y = 0


func visual(_delta) -> void:
	super.visual(_delta)

	facing(dashDirection) 


func handle_input(_event: InputEvent) -> int:
	var newState = super.handle_input(_event)
	if newState:
		return newState

	if Input.is_action_just_pressed("jump"):
		currentjumpBoostTime = jumpBoostTime

	return State.Null


func state_check(_delta: float) -> int:
	var newState = super.state_check(_delta)
	if newState:
		return newState

	if currentDashTime > 0:
		return State.Null
	
	if currentjumpBoostTime > 0:
		return State.JumpDash
	
	if player.is_on_floor():
		if player.moveDirection.x != 0:
			return State.Walk
		return State.Idle
	
	return State.Fall

#	return State.Null
