extends Label

#TODO: Move to main node
var Abilities: Resource = preload ("res://Actor/Player/Resources/PlayerAbilities.tres")



func _ready() -> void:
	EventBus.ability_unlocked.connect(ability_unlocked_announcement)


func text_reset() -> void:
	await get_tree().create_timer(2).timeout
	self.text = ""
	

#TODO: logic on increased dashes
func ability_unlocked_announcement(ability: int) -> void:
	if ability == PlayerAbilities.abiliyList.All:
		text = "All abilities unlocked"
	elif ability == PlayerAbilities.abiliyList.Jump:
		text = "Jump Unlocked"
	elif ability == PlayerAbilities.abiliyList.JumpAir:
		if Abilities.maxJumpAir > 0:
			text = "Air Jump +1"
		else:
			text = "Air Jump Unlocked"
	elif ability == PlayerAbilities.abiliyList.Dash:
		text = "Dashes Unlocked"
	elif ability == PlayerAbilities.abiliyList.DashSide:
		text = "Side Dash Unlocked"
	elif ability ==  PlayerAbilities.abiliyList.DashUp:
		text = "Up Dash Unlocked"
	elif ability == PlayerAbilities.abiliyList.DashDown:
		text = "Down Dash Unlocked"
	else:
		print("Null Ability Unlocked Announcement " + str(ability))
	
	text_reset()
