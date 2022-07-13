extends AbilityBlockBase

#TODO: carries the player in specific direction until exit
#TODO: grab and jump out of the blocks

func _ready() -> void:
	valid_block(get_name(), global_position)
