extends DashState
#TODO: slide jump
#TODO: crouch walk?
#TODO: checks to not end slide in one block gap or need crouch walk
#todo: make roll/spin instead

var transformTime: float = 0.2
var currentDashTime: float = 0
var dashDirection: int = 0

func enter() -> void:
	super.enter()

	player.pass_through_collisions(CollisionLayer.DashSide, false) #Lookat: own layer?
	currentDashTime = dashTime
	dashDirection = player.facing
	player.velocity.x = dashDirection * max(dashSpeed, abs(player.velocity.x))
	player.particlesDashSide.restart()


func exit() -> void:
	super.exit()

	player.pass_through_collisions(CollisionLayer.DashSide, true)
	player.particlesDashSide.emitting = false


func physics(_delta) -> void:
	super.physics(_delta)

	currentDashTime -= _delta
	player.velocity.y = 0


func visual(_delta) -> void:
	super.visual(_delta)

	var tween = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT).set_parallel(true)
#	tween.tween_property(player.characterRig, "position", Vector2(0,-16), transformTime).from_current()
	tween.tween_property(player.characterRig, "scale", Vector2(2 * dashDirection,0.5), transformTime).from_current()


func sound(_delta: float) -> void:
	super.sound(_delta)

	


func handle_input(_event: InputEvent) -> int:
	var newState = super.handle_input(_event)
	if newState:
		return newState

	if Input.is_action_just_pressed("jump"):
		return State.Jump #TODO: special jump burrow 

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

	return State.Null


