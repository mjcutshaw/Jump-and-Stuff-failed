class_name BaseState
extends Node

enum State {
	Null,
	Spawn,
	Die,
	Bonk,
	Idle,
	Walk,
	Crouch,
	Apex,
	Fall,
	Jump,
	JumpAir,
	JumpCrouch,
	JumpFlip,
	JumpLong,
	JumpWall,
	DashClimb,
	DashDown,
	DashJump,
	DashSide,
	DashUp,
	DashWall,
	Glide,
	WallSlide,
	Slide,
}

var pInfo: Resource = preload("res://Actor/Player/Resources/PlayerInfo.tres")
var settings: Resource = preload("res://Resources/Settings.tres")
#TODO: change off actual name
var GameStats: Resource = preload("res://Resources/GameStats.tres")
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

