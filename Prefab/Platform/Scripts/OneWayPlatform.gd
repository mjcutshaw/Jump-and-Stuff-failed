@tool
extends StaticBody2D
class_name OneWayPlatform

#FIXME: able to pull parts from classnames, but doesn't work bringing in the prefab
# might need to make set get

@onready var detectorCollision: CollisionShape2D = $Area2D/CollisionShape2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var detector: Area2D = $Area2D

@export var width: int = 1 :
	get: return width
	set(v):
		width = v
		set_shape()
		update()

@export var height: int = 1 :
	get: return height
	set(v):
		height = v
		set_shape()
		update()

@export var halfBlock: bool = false:
	get: return halfBlock
	set(v):
		halfBlock = v

var widthGrid: int
var heightGrid


func set_shape():
	widthGrid = width * Globals.TILE_SIZE
	
	if halfBlock:
		heightGrid = height * Globals.TILE_SIZE * 0.5
	else: 
		heightGrid = height * Globals.TILE_SIZE
		
	$CollisionShape2D.shape.size.x = widthGrid
	$CollisionShape2D.shape.size.y = heightGrid
	
	$Area2D/CollisionShape2D.shape = $CollisionShape2D.shape
	$Area2D/CollisionShape2D.shape.size = $CollisionShape2D.shape.size




func  _ready() -> void:
	detector.body_entered.connect(player_enter)


func player_enter(body: Player) -> void:
	body.one_way_reset()


