extends StaticBody2D

#FIXME: color rect not aligned
#TODO: add a timer to keep from cheesing the ability reset

@export var width: int = 1
@export var height: int = 1
@export var halfBlock: bool = false

@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var collisionArea: CollisionShape2D = $Area2D/CollisionShape2D
@onready var colorRect: ColorRect = $ColorRect

var widthGrid: int
var heightGrid

func  _ready():
	widthGrid = width * Globals.TILE_SIZE
	
	if halfBlock:
		heightGrid = height * Globals.TILE_SIZE * 0.5
	else: 
		heightGrid = height * Globals.TILE_SIZE
		
	collision.shape.size.x = widthGrid
	collision.shape.size.y = heightGrid
	
	collisionArea.shape.size.x = widthGrid
	collisionArea.shape.size.y = heightGrid
	
	colorRect.size.x = widthGrid
	colorRect.size.y = heightGrid


func _on_area_2d_body_exited(body):
	body.airState.doubleJumpTimer.stop()
	body.airState.tripleJumpTimer.stop()


func _on_area_2d_body_entered(body):
	body.semisolidResetTimer.start()
