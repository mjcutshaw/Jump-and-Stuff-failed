extends Node2D

#@onready var frame: AnimatedSprite2D = $AnimatedSprite2D
#var transformTime: float = 0.2
#
#func to_walk() -> void:
#	var tween = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT).set_parallel(true)
#	tween.tween_property(frame, "position", Vector2(0,-32), transformTime).from_current()
#	tween.tween_property(frame, "scale", Vector2(0.5, 0.5), transformTime).from_current()
#
#func to_slide() -> void:
#	var tween = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT).set_parallel(true)
#	tween.tween_property(frame, "position", Vector2(0,-16), transformTime).from_current()
#	tween.tween_property(frame, "scale", Vector2(1,0.25), transformTime).from_current()
#
#func to_crouch() -> void:
#	var tween = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT).set_parallel(true)
#	tween.tween_property(frame, "position", Vector2(0,-16), transformTime).from_current()
#	tween.tween_property(frame, "scale", Vector2(0.5,0.25), transformTime).from_current()
