extends Area2D

#TODO: send sound to audio bus
var Abilities = ResourceLoader.load("res://Actor/Player/Resources/PlayerAbilities.tres")
var sound = preload("res://Assests/Sounds/SUCCESS PICKUP Collect Chime 01.ogg")
@export var ability: PlayerAbilities.abiliyList


func _on_collectable_body_entered(_body) -> void:
	#TODO: turn into signal
	Abilities.unlock_ability(ability)
	EventBus.emit_signal("ability_unlocked", ability)
	AudioBus.play_sound(AudioBus.audioType.sfx, sound)
	EventBus.emit_signal("ability_check")
	queue_free()
