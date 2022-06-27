extends Node2D


var Abilities = ResourceLoader.load("res://Actor/Player/Resources/PlayerAbilities.tres")
@export var ability: PlayerAbilities.abiliyList
@onready var detector: Area2D = $Area2D

func _ready() -> void:
	detector.body_entered.connect(ability_rest)


func ability_rest(body) -> void:
	body.reset(ability)
