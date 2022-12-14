extends Node2D
class_name DropShadow

@onready var raycastRight: RayCast2D = $RayCast2D
@onready var raycastLeft: RayCast2D = $RayCast2D2
#TODO: change sdaow to draw 
@onready var shadow: Sprite2D = $Sprite2D

var castLength: int = 500
var collide1: int
var collide2: int
var collide3: int

func _ready() -> void:
	raycastLeft.target_position.y = castLength
	raycastRight.target_position.y = castLength


func _process(_delta: float) -> void:
	shadow.scale.x = lerp(.5, shadow.position.y, .01)
	shadow.scale.y = lerp(.05, shadow.position.y, .005 )
	
	if raycastRight.is_colliding() or raycastLeft.is_colliding():
		shadow.visible = true
		collide1 = raycastRight.get_collision_point().y
		collide2 = raycastLeft.get_collision_point().y
		collide3 = min(collide1, collide2)
		if !raycastRight.is_colliding():
			shadow.global_position.y = collide2
		if !raycastLeft.is_colliding():
			shadow.global_position.y = collide1
		else:
			shadow.global_position.y = collide3
	else:
		shadow.visible = false
