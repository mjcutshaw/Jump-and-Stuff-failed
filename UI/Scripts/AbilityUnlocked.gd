extends Label

#TODO: Move to main node
var Abilities = ResourceLoader.load("res://Actor/Player/Resources/PlayerAbilities.tres")



func _ready() -> void:
	EventBus.ability_unlocked.connect(ability_unlocked_announcement)


func text_reset() -> void:
	await get_tree().create_timer(2).timeout
	self.text = ""
	

#TODO: logic on increased dashes
func ability_unlocked_announcement(ability: int) -> void:
	if ability == Abilities.abiliyList.All:
		text = "All abilities unlocked"
	elif ability == Abilities.abiliyList.Jump:
		text = "Jump Unlocked"
	elif ability == Abilities.abiliyList.JumpAir:
		if Abilities.maxJumpAir > 0:
			text = "Air Jump +1"
		else:
			text = "Air Jump Unlocked"
	elif ability == Abilities.abiliyList.Dash:
		text = "Dashes Unlocked"
	elif ability == Abilities.abiliyList.DashSide:
		text = "Side Dash Unlocked"
	elif ability ==  Abilities.abiliyList.DashUp:
		text = "Up Dash Unlocked"
	elif ability == Abilities.abiliyList.DashDown:
		text = "Down Dash Unlocked"
	else:
		print("Null Ability Unlocked Announcement " + str(ability))
	
	text_reset()
