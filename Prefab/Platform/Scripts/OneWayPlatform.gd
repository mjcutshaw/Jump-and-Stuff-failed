@tool
extends StaticBody2D

#FIXME: tool script not updating size in editor
# might need to make set get

@onready var detectorCollision: CollisionShape2D = $Area2D/CollisionShape2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var detector: Area2D = $Area2D

@export var width: int = 1
@export var height: int = 1
@export var halfBlock: bool = false

var widthGrid: int
var heightGrid


func  _ready() -> void:
	widthGrid = width * Globals.TILE_SIZE
	
	if halfBlock:
		heightGrid = height * Globals.TILE_SIZE * 0.5
	else: 
		heightGrid = height * Globals.TILE_SIZE
		
	collision.shape.size.x = widthGrid
	collision.shape.size.y = heightGrid
	
	detectorCollision.shape = collision.shape
	detectorCollision.shape.size = collision.shape.size
	detector.body_entered.connect(player_enter)


func player_enter(body: Player) -> void:
	body.one_way_reset()
	
