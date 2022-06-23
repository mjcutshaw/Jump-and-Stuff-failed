extends Area2D

#TODO: boost the player in a specific direction, can be ability based
var Abilities: Resource = preload ("res://Actor/Player/Resources/PlayerAbilities.tres")
@export var ability: PlayerAbilities.abiliyList

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
