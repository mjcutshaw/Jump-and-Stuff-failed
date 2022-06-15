class_name Player
extends CharacterBody2D
#TODO: raycast to the ground to put a drop shadow on the ground
#TODO: camera needs to lead the player
var gravity = 4  * Globals.TILE_SIZE
#TODO change to a global gravity

@onready var sm = $StateMachine
@onready var velocityLabel: Label = $VelocityLabel
@onready var stateLabel: Label = $StateLabel
@onready var characterRig: Node2D = $CharacterRig
@onready var soundJump: AudioStreamPlayer2D = $Sounds/SoundJump
@onready var soundLand:AudioStreamPlayer2D = $Sounds/SoundLand
@onready var soundWalk: AudioStreamPlayer2D = $Sounds/SoundWalk
@onready var particlesWalking: GPUParticles2D = $CharacterRig/ParticlesWalking
@onready var particlesLand: GPUParticles2D = $CharacterRig/ParticlesLand
@onready var particlesJump: GPUParticles2D = $CharacterRig/ParticlesJump
@onready var particlesJumpDouble: GPUParticles2D = $CharacterRig/ParticlesJumpDouble
@onready var particlesJumpTriple: GPUParticles2D = $CharacterRig/ParticlesJumpTriple
@onready var coyoteTimer: Timer = $Timers/CoyoteTimer
@onready var jumpBufferTimer: Timer = $Timers/JumpBufferTimer
@onready var jumpConsectutiveTimer: Timer = $Timers/JumpConsectutiveTimer

var moveDirection: Vector2 = Vector2.ZERO
var lastDirection: Vector2 = Vector2.ZERO
var moveStrength: Vector2 = Vector2.ZERO
var previousVelocity: Vector2 = Vector2.ZERO

var jumpBufferTime: float = 0.1
var coyoteTime: float = 0.1
var jumpConsectutiveTime: float = .5

var jumped: bool = false
var jumpedDouble: bool = false
var jumpedTriple: bool = false
var canJumpDouble: bool = false
var canJumpTriple: bool = false

enum a {
	All,
	Jump,
	Dash,
	DashSide,
	DashUp,
	DashDown,
}

var currentState

var jumpCornerCorrectionVertical: int = 10
var jumpCornerCorrectionHorizontal: int = 15

var unlockedJump: bool = true
var unlockedAbilities #todo: add all skills

var maxJump: int = 1
var maxAirJump: int = 0
var maxDash: int = 1

var remainingJump: int
var remainingJumpAir: int
var remainingDashSide: int
var remainingDashUp: int
var remainingDashDown: int


func _ready() -> void:
	sm.init()
	set_timers()


func _unhandled_input(_event: InputEvent) -> void:
	sm.handle_input(_event)


func _physics_process(_delta: float) -> void:
	sm.physics(_delta)
	sm.state_check(_delta)
	velocityLabel.text = str(velocity.round())
	


func _process(_delta: float) -> void:
	sm.visual(_delta)
	sm.sound(_delta)


func set_timers():
	coyoteTimer.wait_time = coyoteTime
	coyoteTimer.one_shot = true
	
	jumpBufferTimer.wait_time = jumpBufferTime
	jumpBufferTimer.one_shot = true
	
	jumpConsectutiveTimer.wait_time = jumpConsectutiveTime
	jumpConsectutiveTimer.one_shot = true



func consume(ability: int, amount: int) -> void:
	#TODO: Use 99 remove all or all a third input to do that
	if ability == a.All:
		set_jump(-amount)
		set_jump_air(-amount)
		set_dash(-amount)
	elif ability == a.Jump:
		set_jump(-amount)
	elif ability == a.JumpAir:
		set_jump_air(-amount)
	elif ability == a.Dash:
		set_dash(-amount)
	elif ability == a.DashSide:
		set_dash_side(-amount)
	elif ability == a.DashUp:
		set_dash_up(-amount)
	elif ability == a.DashDown:
		set_dash_down(-amount)
	else:
		print("Null Ability Consume")
#	Signals.emit_signal("ability_check")


func reset(ability):
	if ability == a.All:
		set_jump(maxJump)
		set_dash(maxDash)
	elif ability == a.Jump:
		set_jump(maxJump)
	elif ability == a.JumpAir:
		set_jump_air(maxJump)
	elif ability == a.Dash:
		set_dash(maxDash)
	elif ability == a.DashSide:
		set_dash_side(maxDash)
	elif ability ==  a.DashUp:
		set_dash_up(maxDash)
	elif ability == a.DashDown:
		set_dash_down(maxDash)
	else:
		print("Null Ability Reset")
#	Signals.emit_signal("ability_check")


func use(ability):
	if ability == a.Jump:
		if remainingJump > 0:
			return true
		else:
			return false
	elif ability == a.JumpAir:
		if remainingJumpAir > 0:
			return true
		else:
			return false
	elif ability == a.DashSide:
		if remainingDashSide > 0:
			return true
		else:
			return false
	elif ability == a.DashUp:
		if remainingDashUp > 0:
			return true
		else:
			return false
	elif ability == a.DashDown:
		if remainingDashDown > 0:
			return true
		else:
			return false
	elif ability == a.Dash:
		print("Specify Dash")
	else:
		print("Null Ability Use")
#	Signals.emit_signal("ability_check")


func set_jump(amount):
	remainingJump = clamp(remainingJump + amount, 0, maxJump)


func set_jump_air(amount):
	remainingJumpAir = clamp(remainingJumpAir + amount, 0, maxJump)


func set_dash(amount):
	set_dash_side(amount)
	set_dash_up(amount)
	set_dash_down(amount)


func set_dash_side(amount):
	remainingDashSide = clamp(remainingDashSide + amount, 0, maxDash)


func set_dash_up(amount):
	remainingDashUp = clamp(remainingDashUp + amount, 0, maxDash)


func set_dash_down(amount):
	remainingDashDown = clamp(remainingDashDown + amount, 0, maxDash)


func attempt_vertical_corner_correction(amount, delta):
	for i in range(1, amount*2+1):
		for j in [-1.0, 1.0]:
			if !test_move(global_transform.translated(Vector2(0, i * j / 2)), Vector2(velocity.x * delta, 0)):
				translate(Vector2(0, i * j / 2))
				if velocity.y * j < 0: velocity.y = 0
				print("pushed up")
				return


#TODO: look into make this only happen if player is moving the stick in that direction. or  bigger hop when do that
func attempt_horizontal_corner_correction(amount, delta):
	for i in range(1, amount*2+1):
		for j in [-1.0, 1.0]:
			if !test_move(global_transform.translated(Vector2(i * j / 2, 0)), Vector2(0, velocity.y * delta)):
				translate(Vector2(i * j / 2, 0))
				if velocity.x * j < 0: velocity.x = 0
				print("pushed side")
				return


func _on_jump_consectutive_timer_timeout():
	jumped = false
	jumpedDouble = false
	jumpedTriple = false
	canJumpDouble = false
	canJumpTriple = false
