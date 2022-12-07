extends Node
#TODO: look at jump and stuff timers

func _ready() -> void:
	for timers in get_children():
		timers.one_shot = true
		## Sets all the timers to one shot
