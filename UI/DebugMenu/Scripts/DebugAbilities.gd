extends HBoxContainer

#TODO: rest of abilities
#TOD: need to be able to relock abilities
@onready var allAbilitiesButton: Button = $%AllButton

@onready var Abilities: Resource = preload ("res://Actor/Player/Resources/PlayerAbilities.tres")

func _ready() -> void:
	allAbilitiesButton.pressed.connect(all_abilities_toggle)


func all_abilities_toggle():
	Abilities.unlock_ability(Abilities.abiliyList.All)
	EventBus.emit_signal("ability_unlocked", Abilities.abiliyList.All)
