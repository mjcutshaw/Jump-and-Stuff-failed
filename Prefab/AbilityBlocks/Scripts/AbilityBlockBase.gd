extends Node2D
class_name AbilityBlockBase

#TODO: change name from ability block

var Abilities = ResourceLoader.load("res://Actor/Player/Resources/PlayerInfo.tres")
@export var ability: PlayerAbilities.abiliyList
@onready var detector: Area2D = $%Detector
var blockColor: Color


func block_color() -> void:
	if ability == Abilities.abiliyList.All:
		blockColor = AbilityColor.allColor
	elif ability == Abilities.abiliyList.DashSide:
		blockColor = AbilityColor.dashSideColor
	elif ability == Abilities.abiliyList.DashUp:
		blockColor = AbilityColor.dashUpColor
	elif ability == Abilities.abiliyList.DashDown:
		blockColor = AbilityColor.dashDownColor
	elif ability == Abilities.abiliyList.Grapple:
		blockColor = AbilityColor.grappleColor
	elif ability == Abilities.abiliyList.Jump:
		blockColor = AbilityColor.jumpColor
	elif ability == Abilities.abiliyList.SwimDash:
		blockColor = AbilityColor.swimDashColor
	elif ability == Abilities.abiliyList.Burrow:
		blockColor = AbilityColor.burrowColor
	elif ability == Abilities.abiliyList.Pogo:
		blockColor = AbilityColor.pogoColor
	elif ability == Abilities.abiliyList.Spin:
		blockColor = AbilityColor.spinColor
	elif ability == Abilities.abiliyList.Bash:
		blockColor = AbilityColor.bashColor
	else:
		print("null " + str(self.name) + " " + str(global_position))
#TODO: see if we can get this to work
func valid_block(block, location) -> void:
	if ability == Abilities.abiliyList.Null:
		print("null " + str(block) + " " + str(location))
		set_deferred("monitoring", false)



