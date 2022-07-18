extends Node2D


@export var color: Color = Color.BLUE


func _draw() -> void:
	draw_arc(Vector2(0, 0), 14, 1, 360, 10, color, 5)
