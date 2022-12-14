class_name Player
extends CharacterBody2D


@onready var sm: Node = $StateMachine
@onready var aim: Node2D = $Aim
@onready var characterRig: Node2D = $CharacterRig
@onready var sounds: Node2D = $Sounds
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

var Abilities: Resource = preload("res://Actor/Player/Resources/PlayerInfo.tres")

var moveDirection: Vector2 = Vector2.ZERO
var lastDirection: Vector2 = Vector2.ZERO
var moveStrength: Vector2 = Vector2.ZERO
var aimStrength: Vector2 = Vector2.ZERO
var aimDirection: Vector2 = Vector2.ZERO
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
var canGrapple: bool = false

var facing: int

var currentState

var jumpCornerCorrectionVertical: int = 10
var jumpCornerCorrectionHorizontal: int = 15


var remainingJump: int = 0
var remainingJumpAir: int = 0 #TODO: update these two to below
var remainingDashSide: int = 0:
	set(v):
		remainingDashSide = clamp(v, 0, Abilities.maxDash)

var remainingDashUp: int = 0:
	set(v):
		remainingDashUp = clamp(v, 0, Abilities.maxDash)

var remainingDashDown: int = 0:
	set(v):
		remainingDashDown = clamp(v, 0, Abilities.maxDash)


func _ready() -> void:
	sm.init()
	set_timers()
	EventBus.emit_signal("ability_check")

#	DebugOverlay.add_stat("Velocity", self, "velocity")
#	DebugOverlay.add_stat("State", self, "currentState")

func _unhandled_input(_event: InputEvent) -> void:
	sm.handle_input(_event)


func _physics_process(_delta: float) -> void:
	move_and_slide()
	sm.physics(_delta)
	sm.state_check(_delta)
#	facing = characterRig.scale.x
	EventBus.emit_signal("debugVelocity", velocity.round())
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
	#turn into set variable
	if ability == Abilities.abiliyList.All:
		set_jump_air(-amount)
		remainingDashUp -= amount
		remainingDashSide -= amount
		remainingDashDown -= amount
	elif ability == Abilities.abiliyList.JumpAir:
		set_jump_air(-amount)
	elif ability == Abilities.abiliyList.Dash:
		remainingDashUp -= amount
		remainingDashSide -= amount
		remainingDashDown -= amount
	elif ability == Abilities.abiliyList.DashSide:
		remainingDashSide -= amount
	elif ability == Abilities.abiliyList.DashUp:
		remainingDashUp -= amount
	elif ability == Abilities.abiliyList.DashDown:
		remainingDashDown -= amount
	else:
		print("Null Ability Consume")
	EventBus.emit_signal("ability_check")


func reset(ability: int) -> void:
	if ability == Abilities.abiliyList.All:
		set_jump_air(Abilities.maxJumpAir)
		remainingDashUp = Abilities.maxDash
		remainingDashSide = Abilities.maxDash
		remainingDashDown = Abilities.maxDash
	elif ability == Abilities.abiliyList.JumpAir:
		set_jump_air(Abilities.maxJumpAir)
	elif ability == Abilities.abiliyList.Dash:
		remainingDashUp = Abilities.maxDash
		remainingDashSide = Abilities.maxDash
		remainingDashDown = Abilities.maxDash
	elif ability == Abilities.abiliyList.DashSide:
		remainingDashSide = Abilities.maxDash
	elif ability ==  Abilities.abiliyList.DashUp:
		remainingDashUp = Abilities.maxDash
	elif ability == Abilities.abiliyList.DashDown:
		remainingDashDown = Abilities.maxDash
	else:
		print("Null Ability Reset")
	EventBus.emit_signal("ability_check")


func set_jump_air(amount: int) -> void:
	remainingJumpAir = clamp(remainingJumpAir + amount, 0, Abilities.maxJump)



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
	set_collision_mask_value(collisionLayer, collisionBool)
	


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
		pass_through_collisions(CollisionLayer.Semisolid, true)


func one_way_reset_timeout() -> void:
	if moveDirection.y == 1:
		oneWayResetTimer.start()
	else:
		pass_through_collisions(CollisionLayer.Semisolid, true)

func align_with_floor() -> void:
	#FIXME: buggy, might need to use raycast for ground detectionw
	if is_on_floor():
		rotation = get_floor_normal().angle() + PI/2
#	if !is_on_floor():
#		rotation = 0
#		if get_floor_normal().dot(Vector2.UP) < 0.9 and !is_input:
#			velocity = Vector2.ZERO

