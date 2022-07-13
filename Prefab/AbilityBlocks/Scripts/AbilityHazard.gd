extends AbilityBlockBase

#TODO: hurts the player when enter, unless using ability

func _ready() -> void:
	valid_block(get_name(), global_position)
