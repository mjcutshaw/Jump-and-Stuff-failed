extends DashState

#TODO: give actual variables and numbers(time is not the way to do it)
#TODO: break into left and right for extra challange on rando

var current_dash_time: float = 0
var dashDirection: int = 0
var jumpBoostTime: float = 0.10
var currentjumpBoostTime: float = 0



func enter() -> void:
	super.enter()

	player.consume(PlayerAbilities.abiliyList.DashSide, 1)
	player.pass_through_collisions(Globals.DASH_SIDE, false)
	current_dash_time = dashTime
	dashDirection = player.moveDirection.x
	player.velocity.x = player.facing * max(dashSpeed, abs(player.velocity.x))
	player.particlesDashSide.restart()


func exit() -> void:
	super.exit()

	player.pass_through_collisions(Globals.DASH_SIDE, true)
	player.particlesDashSide.emitting = false


func physics(_delta) -> void:
	super.physics(_delta)

	current_dash_time -= _delta
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
		pass

	return State.Null


func state_check(_delta: float) -> int:
	var newState = super.state_check(_delta)
	if newState:
		return newState

	if current_dash_time > 0:
		return State.Null
	
	if currentjumpBoostTime > 0:
		player.dashJumpBoost = true
		return State.Jump
	
	if player.is_on_floor():
		if player.moveDirection.x != 0:
			return State.Walk
		return State.Idle
	
	return State.Fall

#	return State.Null
