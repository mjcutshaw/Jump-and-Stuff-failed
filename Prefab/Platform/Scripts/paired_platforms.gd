extends Node2D

#TODO: when body is on, subtract the change in position from the other
#TODO: change to animated body
@onready var platform1: StaticBody2D = $Semisolid
@onready var platform2: StaticBody2D = $Semisolid2

var startingPosition1: Vector2
var startingPosition2: Vector2


func _ready():
	startingPosition1 = platform1.global_position
	startingPosition2 = platform2.global_position 


func _process(delta):
	pass


func _physics_process(delta):
	pass
