extends Node


@onready var states = {
	BaseState.State.Spawn: $Spawn,
	BaseState.State.Idle: $Idle,
	BaseState.State.Walk: $Walk,
	BaseState.State.Jump: $Jump,
	BaseState.State.Apex: $Apex,
	BaseState.State.Fall: $Fall,
	BaseState.State.DashSide: $DashSide,
}

var currentState: BaseState
var previousState: BaseState


func change_state(newState: int) -> void:
	if currentState:
		currentState.exit()
		previousState = currentState

	currentState = states[newState]
	currentState.enter()
	print(currentState)


func init(player: Player) -> void:
	for child in get_children():
		child.player = player

	change_state(BaseState.State.Idle)



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
	
