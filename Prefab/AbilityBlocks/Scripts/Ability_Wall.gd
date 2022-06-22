extends StaticBody2D

#TODO: other ability blocks
var Abilities: Resource = preload ("res://Actor/Player/Resources/PlayerAbilities.tres")
@export var ability: PlayerAbilities.abiliyList
@onready var detector: Area2D = $Area2D

func _ready() -> void:
	detector.body_entered.connect(destroy)
	
	if ability == Abilities.abiliyList.Null:
		print("null ability wall")
	elif ability == Abilities.abiliyList.DashSide:
		set_collission(Globals.DASH_SIDE, true)
		set_collission(Globals.DASH_UP, false)
		set_collission(Globals.DASH_DOWN, false)
		self.modulate = Globals.dashSideColor
	elif ability == Abilities.abiliyList.DashUp:
		set_collission(Globals.DASH_UP, true)
		set_collission(Globals.DASH_SIDE, false)
		set_collission(Globals.DASH_DOWN, false)
		self.modulate = Globals.dashUpColor
	elif ability == Abilities.abiliyList.DashDown:
		set_collission(Globals.DASH_DOWN, true)
		set_collission(Globals.DASH_UP, false)
		set_collission(Globals.DASH_SIDE, false)
		self.modulate = Globals.dashDownColor


func set_collission(collisionLayer, collisionBool):
	set_collision_layer_value(collisionLayer, collisionBool)

func destroy(_body):
	queue_free()
	
