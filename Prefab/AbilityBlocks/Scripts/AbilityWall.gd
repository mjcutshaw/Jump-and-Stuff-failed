extends AbilityBlockBase


#TODO: let multiple abilities destroy blocks
#TODO: scale the blocks


@onready var wall: StaticBody2D = $%Block

func _ready() -> void:
	detector.body_entered.connect(destroy)
	
	valid_block(get_name(), global_position)
	
	if ability == Abilities.abiliyList.DashSide:
		set_collission(Globals.DASH_SIDE, true)
		set_collission(Globals.DASH_UP, false)
		set_collission(Globals.DASH_DOWN, false)
		self.modulate = Globals.dashSideColor
	elif ability == Abilities.abiliyList.DashUp:
		set_collission(Globals.DASH_UP, true)
		set_collission(Globals.DASH_SIDE, false)
		set_collission(Globals.DASH_DOWN, false)
		self.modulate = Globals.dashUpColor
	elif ability == Abilities.abiliyList.DashDown:
		set_collission(Globals.DASH_DOWN, true)
		set_collission(Globals.DASH_UP, false)
		set_collission(Globals.DASH_SIDE, false)
		self.modulate = Globals.dashDownColor

#TODO: figure way to add to base class
func set_collission(collisionLayer, collisionBool):
	wall.set_collision_layer_value(collisionLayer, collisionBool)


func destroy(_body):
	queue_free()
