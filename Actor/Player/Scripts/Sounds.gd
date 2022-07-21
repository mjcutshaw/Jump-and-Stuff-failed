extends Node2D
class_name PlayerSounds

@onready var soundJump: AudioStreamPlayer2D = $SoundJump
@onready var soundLand: AudioStreamPlayer2D = $SoundLand
@onready var soundWalk: AudioStreamPlayer2D = $SoundWalk
@onready var soundBonk: AudioStreamPlayer2D = $SoundBonk
@onready var soundDash: AudioStreamPlayer2D = $SoundDash

func  test():
	print("hello")
