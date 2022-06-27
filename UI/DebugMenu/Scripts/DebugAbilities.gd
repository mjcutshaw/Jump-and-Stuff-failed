extends HBoxContainer

#TODO: rest of abilities
#TODO: need to be able to relock abilities
#TODO: change color of text depending on what is unlocked
@onready var allAbilitiesButton: Button = $%AllButton

@onready var Abilities = ResourceLoader.load("res://Actor/Player/Resources/PlayerAbilities.tres")

func _ready() -> void:
	allAbilitiesButton.pressed.connect(all_abilities_toggle)


func all_abilities_toggle():
	Abilities.unlock_ability(Abilities.abiliyList.All)
	EventBus.emit_signal("ability_unlocked", Abilities.abiliyList.All)
