class_name MoveState
extends BaseState


var moveSpeed: int = 10 * Globals.TILE_SIZE

var jumpHeightMax: float = 4.5 * Globals.TILE_SIZE
var jumpHeightMin: int = 10
var jumpTimeToPeak: float = 0.5
var jumpTimeToDescent: float = 0.25
var jumpTimeAtApex: float = 0.8
var jumpApexHeight: float = 40
var jumpDoubleVelocityModifier: float = 1.25
var jumpTripleVelocityModifier: float = 1.5
var jumpCrouchVelocityModifier: float = 1.75
@onready var gravityJump: float = 2 * jumpHeightMax / pow(jumpTimeToPeak, 2)
@onready var gravityFall: float = 2 * jumpHeightMax / pow(jumpTimeToDescent, 2)
@onready var gravityApex: float = 2 * jumpHeightMax / pow(jumpTimeAtApex, 2)
@onready var jumpVelocityMax: float = -sqrt(2 * gravityJump * jumpHeightMax)
@onready var jumpVelocityMin: float = -sqrt(2 * gravityJump * jumpHeightMin)
var terminalVelocity: int = 30 * Globals.TILE_SIZE
var moveSpeedApex: int = 13 * Globals.TILE_SIZE


func enter() -> void:
	super.enter()

	if player.lastDirection.x == 0:
		player.lastDirection.x = player.characterRig.scale.x


func exit() -> void:
	super.exit()

	


func physics(_delta) -> void:
	super.physics(_delta)

	player.move_and_slide()
	move_direction_logic()
	move_strength_logic()


func visual(_delta) -> void:
	super.visual(_delta)

	squash_and_strech(_delta)
	speed_bend()


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
	#FIXME: moveDirection is randomly change when held
	player.moveDirection.x = - int(Input.is_action_pressed("move_left")) + int(Input.is_action_pressed("move_right"))
	player.moveDirection.y = - int(Input.is_action_pressed("move_up")) + int(Input.is_action_pressed("move_down"))
	
	if player.moveDirection.x != 0:
		player.lastDirection = player.moveDirection


func move_strength_logic() -> void:
	player.moveStrength.x = - Input.get_action_strength("move_left") + Input.get_action_strength("move_right")
	player.moveStrength.y = - Input.get_action_strength("move_right") + Input.get_action_strength("move_down")


func facing() -> void:
	#todo: turn into variables
	if player.moveDirection.x != 0:
		player.characterRig.scale.x = player.moveDirection.x
	else:
		player.characterRig.scale.x = player.lastDirection.x

#TODO: look into turning these into tweens

func squash_and_strech(_delta):
	#TODO: not squishing the on the x
	if !player.is_on_floor():
		player.characterRig.scale.y = range_lerp(abs(player.velocity.y), 0, abs(jumpVelocityMax), 0.75, 1.25)
		player.characterRig.scale.x = range_lerp(abs(player.velocity.y), 0, abs(jumpVelocityMax), 1.25, 0.75)
	
	player.characterRig.scale.x = lerp(player.characterRig.scale.x, 1.0, 1.0 - pow(0.01, _delta))
	player.characterRig.scale.y = lerp(player.characterRig.scale.y, 1.0, 1.0 - pow(0.01, _delta))


func landed_visuals(fallVelocity):
	#FIXME: change previous velocity to fall speed
	player.characterRig.scale.x = range_lerp(abs(fallVelocity.y), 0.0, abs(jumpHeightMax), 1.2, 1.25)
	player.characterRig.scale.y = range_lerp(abs(fallVelocity.y), 0.0, abs(jumpHeightMax), 0.8, 0.5)


func speed_bend():
	#TODO: variable to decide direction
	#TODO: need to move smoothly back to zero
	player.characterRig.skew = range_lerp(-player.velocity.x, 0, abs(moveSpeed), 0.0, 0.1)
