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
@onready var soundBonk: AudioStreamPlayer2D = $Sounds/SoundBonk
@onready var soundDash: AudioStreamPlayer2D = $Sounds/SoundDash
@onready var particlesWalking: GPUParticles2D = $CharacterRig/Particles/ParticlesWalking
@onready var particlesLand: GPUParticles2D = $CharacterRig/Particles/ParticlesLand
@onready var particlesJump: GPUParticles2D = $CharacterRig/Particles/ParticlesJump
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

var Abilities: Resource = preload ("res://Actor/Player/Resources/PlayerAbilities.tres")

var moveDirection: Vector2 = Vector2.ZERO
var lastDirection: Vector2 = Vector2.ZERO
var moveStrength: Vector2 = Vector2.ZERO
var previousVelocity: Vector2 = Vector2.ZERO
var wallDirection: Vector2 = Vector2.ZERO
var lastWallDirection: Vector2 = Vector2.ZERO

var jumpBufferTime: float = 0.1
var coyoteTime: float = 0.1
var jumpConsectutiveTime: float = .5

var jumped: bool = false
var jumpedDouble: bool = false
var jumpedTriple: bool = false
var canJumpDouble: bool = false
var canJumpTriple: bool = false
var jumpFlip: bool = false
var jumpCrouch: bool = false
var jumpLong: bool = false
var dashJumpBoost: bool = false

var facing: int

var currentState

var jumpCornerCorrectionVertical: int = 10
var jumpCornerCorrectionHorizontal: int = 15

#TODO: turn into a reusable resource
var unlockedJump: bool = false
var unlockedJumpAir: bool = false
var unlockedJumpCrouch: bool = false
var unlockedJumpLong: bool = false
var unlockedJumpWall: bool = false
var unlockedDashSide: bool = false
var unlockedDashUp: bool = false
var unlockedDashDown: bool = true
var unlockedDashWall: bool = false
var unlockedGlide: bool = false
var unlockedGroundPound: bool = false
var unlockedGrapple: bool = false
var unlockedClimb: bool = false


var remainingJump: int
var remainingJumpAir: int
var remainingDashSide: int = 0
var remainingDashUp: int
var remainingDashDown: int


func _ready() -> void:
	sm.init()
	set_timers()
	EventBus.emit_signal("ability_check")


func _unhandled_input(_event: InputEvent) -> void:
	sm.handle_input(_event)


func _physics_process(_delta: float) -> void:
	sm.physics(_delta)
	sm.state_check(_delta)
	velocityLabel.text = str(velocity.round())
	facing = characterRig.scale.x


func _process(_delta: float) -> void:
	sm.visual(_delta)
	sm.sound(_delta)


func set_timers() -> void:
	coyoteTimer.wait_time = coyoteTime
	coyoteTimer.one_shot = true
	
	jumpBufferTimer.wait_time = jumpBufferTime
	jumpBufferTimer.one_shot = true
	
	jumpConsectutiveTimer.wait_time = jumpConsectutiveTime
	jumpConsectutiveTimer.one_shot = true


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


#TODO: look into make this only happen if player is moving the stick in that direction. or  bigger hop when do that
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
