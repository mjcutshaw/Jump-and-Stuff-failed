@tool
extends Node2D

#TODO: accessability chnage size and make a line

@export var center: Vector2 = Vector2(50, 0):
	get: return center
	set(v):
		center = v
		queue_redraw() 

@export var radius: int = 14:
	get: return radius
	set(v):
		radius = v
		queue_redraw()

#TODO: turn color into settings
@export var color: Color = Color.DARK_GREEN:
	get: return color
	set(v):
		color = v
		queue_redraw()

@export var width: int = 8:
	get: return width
	set(v):
		width = v
		queue_redraw()

func _draw():
	draw_arc(center, radius, -360, 360, 3, color, width)
	

