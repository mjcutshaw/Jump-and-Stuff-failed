extends Label
#TODO: Move to main node

func _process(_delta: float) -> void:
	text = GameStats.strTimeElapsed
