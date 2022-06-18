class_name BaseState
extends Node

enum State {
	Null,
	Spawn,
	Idle,
	Walk,
	Crouch,
	Jump,
	Apex,
	Fall,
	DashSide,
	GroundPound,
}

var PlayerAbilities: Resource = preload ("res://Actor/Player/Resources/PlayerAbilities.tres")
var player: Player


func enter() -> void:
	pass

func exit() -> void:
	pass

func handle_input(_event: InputEvent) -> int:
	return State.Null

func visual(_delta: float) -> void:
	pass

func sound(_delta: float) -> void:
	pass

func physics(_delta: float) -> void:
	pass

func state_check(_delta: float) -> int:
	return State.Null

