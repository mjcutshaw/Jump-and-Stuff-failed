extends Label

var PlayerAbilities: Resource = preload ("res://Actor/Player/Resources/PlayerAbilities.tres")



func _ready() -> void:
	EventBus.ability_unlocked.connect(ability_unlocked_announcement)


func text_reset() -> void:
	await get_tree().create_timer(2).timeout
	self.text = ""


func _unlocked_dash_side() -> void:
	self.text = "Side Dash Unlocked"
	text_reset()

func ability_unlocked_announcement(ability: int) -> void:
	if ability == PlayerAbilities.abiliyList.Jump:
		self.text = "Jump Unlocked"
	elif ability == PlayerAbilities.abiliyList.JumpAir:
		self.text = "Air Jump Unlocked"
	elif ability == PlayerAbilities.abiliyList.Dash:
		self.text = "Dashes Unlocked"
	elif ability == PlayerAbilities.abiliyList.DashSide:
		self.text = "Side Dash Unlocked"
	elif ability ==  PlayerAbilities.abiliyList.DashUp:
		self.text = "Up Dash Unlocked"
	elif ability == PlayerAbilities.abiliyList.DashDown:
		self.text = "Down Dash Unlocked"
	else:
		print("Null Ability Unlocked Announcement")
	
	text_reset()
