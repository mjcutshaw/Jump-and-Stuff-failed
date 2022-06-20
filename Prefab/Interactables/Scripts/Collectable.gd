extends Area2D


var PlayerAbilities: Resource = preload ("res://Actor/Player/Resources/PlayerAbilities.tres")
@export var ability: PlayerAbilities.abiliyList


func _on_collectable_body_entered(_body) -> void:
	PlayerAbilities.unlock_ability(ability)
	EventBus.emit_signal("ability_unlocked", ability)
	$SoundUnlocked.play()
	EventBus.emit_signal("ability_check")
#	queue_free()
