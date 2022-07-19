@tool
extends Node2D

#TODO: accessability chnage size and make a line
#TODO: change to line 2D

@export var center: Vector2 = Vector2(50, 0):
	get: return center
	set(v):
		center = v
		update() 

@export var radius: int = 14:
	get: return radius
	set(v):
		radius = v
		update()

#TODO: turn color into settings
@export var color: Color = Color.DARK_GREEN:
	get: return color
	set(v):
		color = v
		update()

@export var width: int = 8:
	get: return width
	set(v):
		width = v
		update()

func _draw():
	draw_arc(center, radius, -360, 360, 3, color, width)
	

