class_name MoveState
extends BaseState


var moveSpeed: int = pInfo.baseSpeed * Util.TILE_SIZE

var jumpHeightMax: float = 4.5 * Util.TILE_SIZE
var jumpHeightMin: int = 10
var jumpTimeToPeak: float = 0.5
var jumpTimeToDescent: float = 0.25
var jumpTimeAtApex: float = 0.8
var jumpApexHeight: float = 40
var jumpDoubleVelocityModifier: float = 1.25
var jumpTripleVelocityModifier: float = 1.5

var dashJumpBoostVelocityModifier: float = 1.25
@onready var gravityJump: float = 2 * jumpHeightMax / pow(jumpTimeToPeak, 2)
@onready var gravityFall: float = 2 * jumpHeightMax / pow(jumpTimeToDescent, 2)
@onready var gravityApex: float = 2 * jumpHeightMax / pow(jumpTimeAtApex, 2)
@onready var gravityGlide: float = gravityFall/10
@onready var jumpVelocityMax: float = -sqrt(2 * gravityJump * jumpHeightMax)
@onready var jumpVelocityMin: float = -sqrt(2 * gravityJump * jumpHeightMin)
var terminalVelocity: int = 30 * Util.TILE_SIZE
var moveSpeedApex: int = 13 * Util.TILE_SIZE

var dashBufferState: int

func enter() -> void:
	super.enter()

	if player.lastDirection.x == 0:
		player.lastDirection.x = player.characterRig.scale.x
	


func exit() -> void:
	super.exit()

	


func physics(_delta) -> void:
	super.physics(_delta)

	
	get_move_input()
#	wall_direction_logic()


func visual(_delta) -> void:
	super.visual(_delta)

	squash_and_strech(_delta)
	speed_bend()
	player.align_with_floor()


func handle_input(_event: InputEvent) -> int:
	var newState = super.handle_input(_event)
	if newState:
		return newState

	

	return State.Null


func state_check(_delta: float):
	var new_state = super.state_check(_delta)
	if new_state:
		return new_state

	

	return State.Null

func get_move_input() -> void:
	var deadzoneRadius: float = 0.2
	#TODO: make deadzone radius in settings
	var inputStrength: = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	player.moveStrength =  inputStrength if inputStrength.length() > deadzoneRadius else Vector2.ZERO
	
	player.moveDirection =  player.moveStrength.normalized()
	
	if player.moveDirection != Vector2.ZERO:
		player.lastDirection = player.moveDirection


func velocity_logic(speed) -> void:
	#TODO: variable to use moveDirection
	player.velocity.x = player.moveDirection.x * speed


func momentum_logic(speed, useMoveDirection: bool) -> void:
	#TODO: need to get accel and deccel, lerp function
	if useMoveDirection:
		player.velocity.x = player.moveDirection.x * max(abs(speed), abs(player.velocity.x))
	if !useMoveDirection:
		if player.velocity.x == 0:
			player.velocity.x = player.velocity.x
		else:
			player.velocity.x =  max(abs(speed), abs(player.velocity.x)) * player.facing

func neutral_move_direction_logic() -> void:
	if player.moveDirection == Vector2.ZERO:
		player.neutralMoveDirection = true
	else:
		player.neutralMoveDirection = false


func dash_pressed_buffer() -> void:
#	var initial_direction = player.aimDirection.round()
	await get_tree().create_timer(0.1).timeout
	dash_pressed_logic()

func dash_pressed_logic() -> void: #TODO: change to aimdirection #FIXME: being double triggered
	if Input.is_action_pressed("jump"):
		dashBufferState = BaseState.State.DashJump
	elif player.moveDirection.round() == Vector2.UP:
		dashBufferState = BaseState.State.DashUp
	elif player.moveDirection.round() == Vector2.DOWN:
		dashBufferState = BaseState.State.DashDown
	elif player.is_on_floor():
		dashBufferState = BaseState.State.DashSide #Todo: fix the double
	elif !player.is_on_floor():
		dashBufferState = BaseState.State.DashSide
	else:
		dashBufferState = BaseState.State.Null
		EventBus.emit_signal("error", "null dash pressed logic")


func wall_direction_logic() -> void:
	player.wallDirection = player.get_wall_normal()
	
	if player.wallDirection.x != 0:
		player.lastWallDirection = player.wallDirection


func facing(face) -> void:
	player.characterRig.scale.x = face
	player.facing = player.characterRig.scale.x

#TODO: look into turning these into tweens

func squash_and_strech(_delta):
#	#TODO: not squishing the on the x
	if !player.is_on_floor():
		player.characterRig.scale.y = remap(abs(player.velocity.y), 0, abs(jumpVelocityMax), 0.75, 1.25)
		player.characterRig.scale.x = remap(abs(player.velocity.y), 0, abs(jumpVelocityMax), 1.25, 0.75)

	player.characterRig.scale.x = lerp(player.characterRig.scale.x, 1.0, 1.0 - pow(0.01, _delta))
	player.characterRig.scale.y = lerp(player.characterRig.scale.y, 1.0, 1.0 - pow(0.01, _delta))
	pass


func landed_visuals(fallVelocity):
#	#FIXME: change previous velocity to fall speed
	player.characterRig.scale.x = remap(abs(fallVelocity.y), 0.0, abs(jumpHeightMax), 1.2, 1.25)
	player.characterRig.scale.y = remap(abs(fallVelocity.y), 0.0, abs(jumpHeightMax), 0.8, 0.5)

	#TODO: find a better place for vibrations
	if settings.toggleVibration:
		Input.start_joy_vibration(0,0.5,0,0.2)
	pass


func speed_bend():
#	#TODO: variable to decide direction
#	#TODO: try using tween
	player.characterRig.skew = remap(-player.velocity.x, 0, abs(moveSpeed), 0.0, 0.1)
	pass


func gravity_logic(amount, _delta) -> void:
	player.velocity.y += amount * _delta

