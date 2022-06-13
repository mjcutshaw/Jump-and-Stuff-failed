class_name MoveState
extends BaseState

var moveDirection: Vector2 = Vector2.ZERO
var lastDirection: Vector2 = Vector2.ZERO
var moveStrength: Vector2 = Vector2.ZERO

var moveSpeed: int = 7 * Globals.TILE_SIZE


func enter() -> void:
	super.enter()

	if lastDirection.x == 0:
		lastDirection.x = player.characterRig.scale.x


func exit() -> void:
	super.exit()

	


func physics(_delta) -> void:
	super.physics(_delta)

	player.move_and_slide()
	move_direction_logic()
	move_strength_logic()


func visual(_delta) -> void:
	super.visual(_delta)

	


func handle_input(_event: InputEvent) -> int:
	var newState = super.handle_input(_event)
	if newState:
		return newState

	if Input.is_action_just_pressed("dash"):
		return State.DashSide

	return State.Null


func state_check(_delta: float):
	var new_state = super.state_check(_delta)
	if new_state:
		return new_state

	

	return State.Null


func move_direction_logic() -> void:
	#TODO: look into get_axis
	moveDirection.x = - int(Input.is_action_pressed("move_left")) + int(Input.is_action_pressed("move_right"))
	moveDirection.y = - int(Input.is_action_pressed("move_up")) + int(Input.is_action_pressed("move_down"))
	
	if moveDirection.x != 0:
		lastDirection = moveDirection

func move_strength_logic() -> void:
	moveStrength.x = - Input.get_action_strength("move_left") + Input.get_action_strength("move_right")
	moveStrength.y = - Input.get_action_strength("move_right") + Input.get_action_strength("move_down")
