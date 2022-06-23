extends Area2D

#TODO: send sound to audio bus
var PlayerAbilities: Resource = preload ("res://Actor/Player/Resources/PlayerAbilities.tres")
@export var ability: PlayerAbilities.abiliyList


func _on_collectable_body_entered(_body) -> void:
	#TODO: turn into signal
	PlayerAbilities.unlock_ability(ability)
	EventBus.emit_signal("ability_unlocked", ability)
	$SoundUnlocked.play()
	EventBus.emit_signal("ability_check")
	queue_free()
