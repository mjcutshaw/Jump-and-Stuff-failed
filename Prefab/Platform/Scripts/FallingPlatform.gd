extends CharacterBody2D

#FIXME: player is not falling with platform. player is still grounded and won't fall with the platform
#TODO: off screen

@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var collisionArea: CollisionShape2D = $Area2D/CollisionShape2D
@onready var colorRect: ColorRect = $ColorRect
@onready var resetTimer: Timer = $ResetTimer
@onready var collapseTimer: Timer = $CollapseTimer
@onready var startingPosition: Vector2 = global_position

@export var width: int = 1
@export var height: int = 1
@export var halfBlock: bool = false
@export var onlyFallWhenOn: bool = true
@export var offScreenReset: bool = true
@export var timedReset: bool = true
@export var resetTime: int = 4
@export var timedCollapse: bool = false
@export var collapseTime: int = 1

var widthGrid: int
var heightGrid

enum state {idle, collapse, fall, reset}

func  _ready():
	resetTimer.wait_time = resetTime
	collapseTimer.wait_time = collapseTime
	widthGrid = width * Global.TILE_SIZE
	
	if halfBlock:
		heightGrid = height * Global.TILE_SIZE * 0.5
	else: 
		heightGrid = height * Global.TILE_SIZE
		
	collision.shape.size.x = widthGrid
	collision.shape.size.y = heightGrid
	
	colorRect.size.x = widthGrid
	colorRect.size.y = heightGrid


func _physics_process(_delta):
	move_and_slide()
	


func idle():
	velocity = Vector2.ZERO


func collapse():
	state.name = state.collapse
	collapseTimer.start()


func fall():
	state.name = state.fall
	velocity.y += 100
	resetTimer.start()
	print(fall)


func reset():
	velocity = Vector2.ZERO
	state.name = state.reset
	global_position = startingPosition


func _on_area_2d_body_entered(_body):
	if timedCollapse:
		collapse()
	else:
		fall()


func _on_area_2d_body_exited(_body):
	if onlyFallWhenOn:
		idle()
	resetTimer.start()


func _on_reset_timer_timeout():
	reset()


func _on_collapse_timer_timeout():
	fall()
