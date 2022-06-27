extends Area2D

#TODO: hurts the player when enter, unless using ability
var Abilities = ResourceLoader.load("res://Actor/Player/Resources/PlayerAbilities.tres")
@export var ability: PlayerAbilities.abiliyList

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
