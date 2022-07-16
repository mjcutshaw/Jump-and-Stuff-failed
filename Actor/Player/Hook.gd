extends Node2D


@onready var tail: Line2D = $Tail
@onready var head: Sprite2D = $Head

@onready var startLength: float = head.position.x

var hookPosition: Vector2 = Vector2.ZERO :
	set(value):
		hookPosition = value
		var tween = create_tween()
		var to_target: = hookPosition - global_position
		self.length = to_target.length()
		rotation = to_target.angle()
		tween.interpolate_property(
				self, 'length', length, startLength, 
				0.25, Tween.TRANS_QUAD, Tween.EASE_OUT)
		tween.start()
		visible = true


var length: float = 40.0 :
	set (value):
		length = value
		tail.points[-1].x = length
		head.position.x = tail.points[-1].x + tail.position.x
