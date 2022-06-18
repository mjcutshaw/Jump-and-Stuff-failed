extends Node




@onready var states = {
	BaseState.State.Spawn: $Spawn,
	BaseState.State.Idle: $Idle,
	BaseState.State.Walk: $Walk,
	BaseState.State.Crouch: $Crouch,
	BaseState.State.Jump: $Jump,
	BaseState.State.Apex: $Apex,
	BaseState.State.Fall: $Fall,
	BaseState.State.DashSide: $DashSide,
	BaseState.State.DashDown: $DashDown,
	BaseState.State.DashUp: $DashUp,
	BaseState.State.GroundPound: $GroundPound,
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

	currentState = states[newState]
	currentState.enter()
	currentStateName = currentState.name
	print(previousStateName + " to " + currentStateName)
	player.stateLabel.text = currentStateName
	player.currentState = currentState.name


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


