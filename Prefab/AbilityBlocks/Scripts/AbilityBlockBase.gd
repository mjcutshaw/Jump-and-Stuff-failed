extends Node2D
class_name AbilityBlockBase

#TODO: change name from ability block

var Abilities = ResourceLoader.load("res://Resources/PlayerAbilities.tres")
@export var ability: PlayerAbilities.abiliyList
@onready var detector: Area2D = $%Detector

#TODO: see if we can get this to work
func valid_block(block, location) -> void:
	if ability == 0:
		print("null " + str(block) + " " + str(location))
		set_deferred("monitoring", false)
