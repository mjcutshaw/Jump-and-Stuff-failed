extends DashState
#LOOKAT: ground dash seperate>
#TODO: grab dash combos from g3.5 
#TODO: previous velocity = velocity on exit
var currentDashTime: float = 0
var dashDirection: int = 0
var jumpBoostTime: float = 0.10
var currentjumpBoostTime: float = 0
var groundDash: bool = false


func enter() -> void:
	super.enter()

	player.consume(pInfo.abiliyList.DashSide, 1)
	player.pass_through_collisions(CollisionLayer.DashSide, false)
	currentDashTime = dashTime
	dashDirection = player.facing
	player.velocity.x = dashDirection * max(dashSpeed, abs(player.velocity.x))
	player.particlesDashSide.restart()
	if player.is_on_floor():
		groundDash = true


func exit() -> void:
	super.exit()

	player.pass_through_collisions(CollisionLayer.DashSide, true)
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
		if groundDash:
			currentjumpBoostTime = jumpBoostTime
		if player.can_use_ability(pInfo.abiliyList.JumpAir):
			currentjumpBoostTime = jumpBoostTime

	return State.Null


func state_check(_delta: float) -> int:
	var newState = super.state_check(_delta)
	if newState:
		return newState

	if currentDashTime > 0:
		return State.Null
	
	if currentjumpBoostTime > 0:
		return State.DashJump
	
	if player.is_on_floor():
		if player.moveDirection.x != 0:
			return State.Walk
		return State.Idle
	
	return State.Fall

#	return State.Null
