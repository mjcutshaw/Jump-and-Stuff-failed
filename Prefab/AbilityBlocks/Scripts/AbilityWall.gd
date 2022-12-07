extends AbilityBlockBase

#TODO: let multiple abilities destroy blocks
#TODO: scale the blocks


@onready var wall: StaticBody2D = $%Block

func _ready() -> void:
	detector.body_entered.connect(destroy)
	
	valid_block(get_name(), global_position)
	
	if ability == Abilities.abiliyList.DashSide:
		set_collission(CollisionLayer.DashSide, true)
		set_collission(CollisionLayer.DashUp, false)
		set_collission(CollisionLayer.DashDown, false)
		self.modulate = AbilityColor.dashSideColor
	elif ability == Abilities.abiliyList.DashUp:
		set_collission(CollisionLayer.DashUp, true)
		set_collission(CollisionLayer.DashSide, false)
		set_collission(CollisionLayer.DashDown, false)
		self.modulate = AbilityColor.dashUpColor
	elif ability == Abilities.abiliyList.DashDown:
		set_collission(CollisionLayer.DashDown, true)
		set_collission(CollisionLayer.DashUp, false)
		set_collission(CollisionLayer.DashSide, false)
		self.modulate = AbilityColor.dashDownColor

#TODO: figure way to add to base class
func set_collission(collisionLayer, collisionBool):
	wall.set_collision_layer_value(collisionLayer, collisionBool)


func destroy(_body):
	queue_free()
