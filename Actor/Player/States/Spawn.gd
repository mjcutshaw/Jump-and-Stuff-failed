extends BaseState
#TODO: do it

func enter() -> void:
	super.enter()

	var tween = create_tween()
	tween.tween_property(player.characterRig, "scale", Vector2(1,1), .4).from(Vector2(0,0))


func exit() -> void:
	super.exit()

	


func physics(_delta) -> void:
	super.physics(_delta)

	


func visual(_delta) -> void:
	super.visual(_delta)

	


func handle_input(_event: InputEvent) -> int:
	var newState = super.handle_input(_event)
	if newState:
		return newState

	if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
		return State.Walk
	if Input.is_action_just_pressed("jump"):
		return State.Jump

	return State.Null


func state_check(_delta: float) -> int:
	var newState = super.state_check(_delta)
	if newState:
		return newState

	

	return State.Null
