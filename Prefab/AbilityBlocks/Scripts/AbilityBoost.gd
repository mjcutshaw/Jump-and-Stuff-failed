extends AbilityBlockBase

#FIXME: kinda works really badly
@onready var raycastBoost: RayCast2D = $RayCast2D
@export var rotateBlock: bool = false
var boostDirection: Vector2
var boostAmount: int = 2000



func _ready() -> void:
	detector.body_entered.connect(boost)
	valid_block(get_name(), global_position)


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
	
