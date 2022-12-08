extends AirState

#TODO: make friction when changing directions
func enter() -> void:
	super.enter()

	neutral_move_direction_logic()

func exit() -> void:
	super.exit()

	player.previousVelocity = player.velocity


func physics(_delta) -> void:
	super.physics(_delta)

	neutral_air_momentum_logic()
	if player.moveDirection.y != 1: ## No velocity when holding down ##
		fall_speed_logic(terminalVelocity)
	gravity_logic(gravityFall, _delta)


func visual(_delta) -> void:
	super.visual(_delta)

	if player.moveDirection.x == 0:
		facing(player.facing)
	else:
		facing(player.lastDirection.x)


func handle_input(_event: InputEvent) -> int:
	var newState = super.handle_input(_event)
	if newState:
		return newState

	if Input.is_action_pressed("glide"):
		return State.Glide
	if Input.is_action_just_pressed("jump") and player.can_use_ability(pInfo.abiliyList.JumpAir):
		return State.JumpAir

	return State.Null


func state_check(_delta: float) -> int:
	var newState = super.state_check(_delta)
	if newState:
		return newState

	

	return State.Null
