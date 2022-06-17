extends Area2D


var player: Player

#TODO: signal might be better
func _on_collectable_body_entered(body):
	body.unlockedDashSide = true
