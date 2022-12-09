extends Area2D
#TODO: rename to ability unlocker
#TODO: add to interactable block, grab from g3.5
#TODO: send sound to audio bus
#TODO: create null check, will happen after add to interactable
#TODO: color based on ability, same as above
var Abilities = ResourceLoader.load("res://Actor/Player/Resources/PlayerInfo.tres")
var sound = preload("res://Assets/Sounds/SUCCESS PICKUP Collect Chime 01.ogg")
@export var ability: PlayerAbilities.abiliyList


func _on_collectable_body_entered(_body) -> void:
	#TODO: turn into signal
	Abilities.unlock_ability(ability)
	EventBus.emit_signal("ability_unlocked", ability)
	AudioBus.play_sound(AudioBus.audioType.sfx, sound)
	EventBus.emit_signal("ability_check")
	queue_free()
