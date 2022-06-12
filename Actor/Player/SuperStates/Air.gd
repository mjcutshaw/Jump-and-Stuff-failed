class_name AirState
extends MoveState


var jumpHeightMax: float = 4.5 * Globals.TILE_SIZE
var jumpHeightMin: int = 10
var jumpTimeToPeak: float = 0.5
var jumpTimeToDescent: float = 0.3
var jumpTimeAtApex: float = 0.8
var jumpApexHeight: float = 40
@onready var gravityJump: float = 2 * jumpHeightMax / pow(jumpTimeToPeak, 2)
@onready var gravityFall: float = 2 * jumpHeightMax / pow(jumpTimeToDescent, 2)
@onready var gravityApex: float = 2 * jumpHeightMax / pow(jumpTimeAtApex, 2)
@onready var gravityGlide: float = gravityFall/10
@onready var gravityGroundPound: float = gravityFall * 2
@onready var jumpVelocityMax: float = -sqrt(2 * gravityJump * jumpHeightMax)
@onready var jumpVelocityMin: float = -sqrt(2 * gravityJump * jumpHeightMin)
var groundPoundJumpHeight: float = jumpVelocityMax * 1.75
@onready var doubleJumpHeight: float = jumpVelocityMax * 1.25
@onready var tripleJumpHeight: float = jumpVelocityMax * 1.5
var slowFallModifier: float = 3.0
var terminalVelocity: int = 20 * Globals.TILE_SIZE
var terminalVelocitySlow: int = 10 * Globals.TILE_SIZE
var terminalVelocityGroundPound: int = terminalVelocity * 2
var wallJumpBoost: float = 1.25
var moveSpeedApex: int = 10 * Globals.TILE_SIZE
var moveSpeedLongJump: int = moveSpeed * 6


func enter() -> void:
	super.enter()

	


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

	

	return State.Null


func state_check(_delta: float) -> int:
	var newState = super.state_check(_delta)
	if newState:
		return newState

	

	return State.Null


func velocity_logic(speed) -> void:
	player.velocity.x = moveStrength.x * speed


func gravity_logic(amount, _delta) -> void:
	player.velocity.y += amount * _delta


func fall_speed_logic(amount) -> void:
	player.velocity.y = min(player.velocity.y, amount)
