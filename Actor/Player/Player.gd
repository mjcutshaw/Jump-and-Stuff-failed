class_name Player
extends CharacterBody2D

#TODO: make movement velocity, enviroment velocity. change state velocity to movement velocity
#TODO: add hitbox and hurtbox
@onready var sm = $StateMachine
@onready var characterRig: Node2D = $CharacterRig
@onready var soundJump: AudioStreamPlayer2D = $Sounds/SoundJump
@onready var soundLand:AudioStreamPlayer2D = $Sounds/SoundLand
@onready var soundWalk: AudioStreamPlayer2D = $Sounds/SoundWalk
@onready var soundBonk: AudioStreamPlayer2D = $Sounds/SoundBonk
@onready var soundDash: AudioStreamPlayer2D = $Sounds/SoundDash
@onready var particlesWalking: GPUParticles2D = $CharacterRig/Particles/ParticlesWalking
@onready var particlesLand: GPUParticles2D = $CharacterRig/Particles/ParticlesLand
@onready var particlesJump: GPUParticles2D = $CharacterRig/Particles/ParticlesJump
@onready var particlesJumpWall: GPUParticles2D =  $CharacterRig/Particles/ParticlesJumpWall
@onready var particlesJumpDouble: GPUParticles2D = $CharacterRig/Particles/ParticlesJumpDouble
@onready var particlesJumpTriple: GPUParticles2D = $CharacterRig/Particles/ParticlesJumpTriple
@onready var particlesDashSide: GPUParticles2D =  $CharacterRig/Particles/ParticlesDashSide
@onready var particlesDashUp: GPUParticles2D =  $CharacterRig/Particles/ParticlesDashUp
@onready var particlesDashDown: GPUParticles2D =  $CharacterRig/Particles/ParticlesDashDown
@onready var particlesWallSlide: GPUParticles2D =  $CharacterRig/Particles/ParticlesWallSlide
@onready var particlesWallClimb: GPUParticles2D =  $CharacterRig/Particles/ParticlesWallClimb
@onready var coyoteTimer: Timer = $Timers/CoyoteTimer
@onready var jumpBufferTimer: Timer = $Timers/JumpBufferTimer
@onready var jumpConsectutiveTimer: Timer = $Timers/JumpConsectutiveTimer
@onready var wallCoyoteTimer: Timer = $Timers/WallCoyoteTimer
@onready var oneWayResetTimer: Timer = $Timers/OneWayTimer
@onready var statelabel: Label = $StateLabel

var Abilities = ResourceLoader.load("res://Actor/Player/Resources/PlayerAbilities.tres")

var moveDirection: Vector2 = Vector2.ZERO
var lastDirection: Vector2 = Vector2.ZERO
var moveStrength: Vector2 = Vector2.ZERO
var previousVelocity: Vector2 = Vector2.ZERO
var wallDirection: Vector2 = Vector2.ZERO
var lastWallDirection: Vector2 = Vector2.ZERO

var jumpBufferTime: float = 0.1
var coyoteTime: float = 0.1
var jumpConsectutiveTime: float = 0.5
var oneWayResetTime: float = 0.05

var jumped: bool = false
var jumpedDouble: bool = false
var jumpedTriple: bool = false
var canJumpDouble: bool = false
var canJumpTriple: bool = false
var jumpFlip: bool = false
var neutralMoveDirection: bool = false

var facing: int

var currentState

var jumpCornerCorrectionVertical: int = 10
var jumpCornerCorrectionHorizontal: int = 15


var remainingJump: int = 0
var remainingJumpAir: int = 0
var remainingDashSide: int = 0
var remainingDashUp: int = 0
var remainingDashDown: int = 0


func _ready() -> void:
	sm.init()
	set_timers()
	EventBus.emit_signal("ability_check")
#	DebugOverlay.add_stat("Velocity", self, "velocity")
#	DebugOverlay.add_stat("State", self, "currentState")

func _unhandled_input(_event: InputEvent) -> void:
	sm.handle_input(_event)


func _physics_process(_delta: float) -> void:
	sm.physics(_delta)
	sm.state_check(_delta)
#	facing = characterRig.scale.x
	$VelocityLabel.text = str(velocity.round())
#	$FacingLabel.text = str(facing)


func _process(_delta: float) -> void:
	sm.visual(_delta)
	sm.sound(_delta)


func set_timers() -> void:
	coyoteTimer.wait_time = coyoteTime
	wallCoyoteTimer.wait_time = coyoteTime * 2
	jumpBufferTimer.wait_time = jumpBufferTime
	jumpConsectutiveTimer.wait_time = jumpConsectutiveTime
	oneWayResetTimer.wait_time = oneWayResetTime
	
	oneWayResetTimer.timeout.connect(one_way_reset_timeout)


func can_use_ability(ability: int) -> bool:
	if ability == Abilities.abiliyList.DashSide and remainingDashSide > 0 and Abilities.unlockedDashSide:
		return true
	elif ability == Abilities.abiliyList.DashDown and remainingDashDown > 0 and Abilities.unlockedDashDown:
		return true
	elif ability == Abilities.abiliyList.DashUp and remainingDashUp > 0 and Abilities.unlockedDashUp:
		return true
	return false

func consume(ability: int, amount: int) -> void:
	#TODO: Use 99 remove all or all a third input to do that
	if ability == Abilities.abiliyList.All:
		set_jump_air(-amount)
		set_dash(-amount)
	elif ability == Abilities.abiliyList.JumpAir:
		set_jump_air(-amount)
	elif ability == Abilities.abiliyList.Dash:
		set_dash(-amount)
	elif ability == Abilities.abiliyList.DashSide:
		set_dash_side(-amount)
	elif ability == Abilities.abiliyList.DashUp:
		set_dash_up(-amount)
	elif ability == Abilities.abiliyList.DashDown:
		set_dash_down(-amount)
	else:
		print("Null Ability Consume")
	EventBus.emit_signal("ability_check")


func reset(ability: int) -> void:
	if ability == Abilities.abiliyList.All:
		set_dash(Abilities.maxDash)
		set_jump_air(Abilities.maxJumpAir)
	elif ability == Abilities.abiliyList.JumpAir:
		set_jump_air(Abilities.maxJumpAir)
	elif ability == Abilities.abiliyList.Dash:
		set_dash(Abilities.maxDash)
	elif ability == Abilities.abiliyList.DashSide:
		set_dash_side(Abilities.maxDash)
	elif ability ==  Abilities.abiliyList.DashUp:
		set_dash_up(Abilities.maxDash)
	elif ability == Abilities.abiliyList.DashDown:
		set_dash_down(Abilities.maxDash)
	else:
		print("Null Ability Reset")
	EventBus.emit_signal("ability_check")


func set_jump_air(amount: int) -> void:
	remainingJumpAir = clamp(remainingJumpAir + amount, 0, Abilities.maxJump)


func set_dash(amount: int) -> void:
	set_dash_side(amount)
	set_dash_up(amount)
	set_dash_down(amount)


func set_dash_side(amount: int) -> void:
	remainingDashSide = clamp(remainingDashSide + amount, 0, Abilities.maxDash)


func set_dash_up(amount: int) -> void:
	remainingDashUp = clamp(remainingDashUp + amount, 0, Abilities.maxDash)


func set_dash_down(amount: int) -> void:
	remainingDashDown = clamp(remainingDashDown + amount, 0, Abilities.maxDash)


func attempt_vertical_corner_correction(amount: int, delta) -> void:
	for i in range(1, amount*2+1):
		for j in [-1.0, 1.0]:
			if !test_move(global_transform.translated(Vector2(0, i * j / 2)), Vector2(velocity.x * delta, 0)):
				translate(Vector2(0, i * j / 2))
				if velocity.y * j < 0: velocity.y = 0
				print("pushed up")
				return


func attempt_horizontal_corner_correction(amount: int, delta) -> void:
	for i in range(1, amount*2+1):
		for j in [-1.0, 1.0]:
			if !test_move(global_transform.translated(Vector2(i * j / 2, 0)), Vector2(0, velocity.y * delta)):
				translate(Vector2(i * j / 2, 0))
				if velocity.x * j < 0: velocity.x = 0
				print("pushed side")
				return


func pass_through_collisions(collisionLayer, collisionBool):
	coyoteTimer.stop()
	self.set_collision_mask_value(collisionLayer, collisionBool)


func _on_jump_consectutive_timer_timeout() -> void:
	jumped = false
	jumpedDouble = false
	jumpedTriple = false
	canJumpDouble = false
	canJumpTriple = false

func one_way_reset() -> void:
	if moveDirection.y == 1:
		oneWayResetTimer.start()
	else:
		pass_through_collisions(Globals.SEMISOLID, true)


func one_way_reset_timeout() -> void:
	if moveDirection.y == 1:
		oneWayResetTimer.start()
	else:
		pass_through_collisions(Globals.SEMISOLID, true)

func align_with_floor() -> void:
	#FIXME: change to character rig and might need to use raycast for ground detectionw
	if is_on_floor():
		characterRig.rotation = get_floor_normal().angle() + PI/2
#	if !is_on_floor():
#		rotation = 0
#		if get_floor_normal().dot(Vector2.UP) < 0.9 and !is_input:
#			velocity = Vector2.ZERO

