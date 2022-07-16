extends Node




@onready var states = {
	BaseState.State.Spawn: $Spawn,
	BaseState.State.Die: $Die,
	BaseState.State.Bonk: $Bonk,
	BaseState.State.Idle: $Idle,
	BaseState.State.Walk: $Walk,
	BaseState.State.Crouch: $Crouch,
	BaseState.State.Jump: $Jump,
	BaseState.State.JumpCrouch: $JumpCrouch,
	BaseState.State.JumpDash: $JumpDash,
	BaseState.State.JumpLong: $JumpLong,
	BaseState.State.JumpAir: $JumpAir,
	BaseState.State.JumpWall: $JumpWall,
	BaseState.State.Apex: $Apex,
	BaseState.State.Fall: $Fall,
	BaseState.State.DashSide: $DashSide,
	BaseState.State.DashDown: $DashDown,
	BaseState.State.DashUp: $DashUp,
	BaseState.State.GroundPound: $GroundPound,
	BaseState.State.Glide: $Glide,
	BaseState.State.WallSlide: $WallSlide,
	BaseState.State.WallGrab: $WallGrab,
	BaseState.State.WallDash: $WallDash,
	BaseState.State.WallClimb: $WallClimb,
}

var currentState: BaseState
var previousState: BaseState
var currentStateName: String
var previousStateName: String
@onready var player: Player = get_parent()


func change_state(newState: int) -> void:
	if currentState:  
		currentState.exit()
		previousState = currentState
		previousStateName = previousState.name
		
		#TODO: look into not calling super state exit if super states are the same
		if currentState.get_groups() != previousState.get_groups():
			print("different super state")
	
	currentState = states[newState]
	currentState.enter()
	currentStateName = currentState.name
#	print(previousStateName + " to " + currentStateName)
	player.currentState = currentState.name
	player.statelabel.text = currentState.name


func init() -> void:
	for child in get_children():
		child.player = player

	change_state(BaseState.State.Spawn)


func handle_input(_event: InputEvent) -> void:
	var newState = currentState.handle_input(_event)
	if newState != BaseState.State.Null:
		change_state(newState)


func physics(_delta) -> void:
	currentState.physics(_delta)


func state_check(_delta) -> void:
	var newState = currentState.state_check(_delta)
	if newState != BaseState.State.Null:
		change_state(newState)


func visual(_delta) -> void:
	currentState.visual(_delta)


func sound(_delta) -> void:
	currentState.sound(_delta)


