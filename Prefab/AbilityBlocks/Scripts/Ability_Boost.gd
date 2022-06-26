extends Area2D

#FIXME: kinda works really badly
var Abilities: Resource = preload ("res://Actor/Player/Resources/PlayerAbilities.tres")
@onready var raycastBoost: RayCast2D = $RayCast2D
@export var ability: PlayerAbilities.abiliyList
@export var rotateBlock: bool = false
var boostDirection: Vector2
var boostAmount: int = 2000



func _ready() -> void:
	body_entered.connect(boost)
	


func _physics_process(delta: float) -> void:
	
	
	if rotateBlock:
		rotate(.1)

func boost(body) -> void:
	#TODO: probably overkill for what i am trying to do
	var rGlobalOrigin = raycastBoost.to_global(Vector2.ZERO)
	var rGlobalCastToEndpoint = raycastBoost.to_global(raycastBoost.target_position)
	boostDirection = rGlobalCastToEndpoint - rGlobalOrigin
	boostDirection.x = signi(boostDirection.x)
	boostDirection.y = signi(boostDirection.y)
	body.velocity = boostDirection * boostAmount
	
