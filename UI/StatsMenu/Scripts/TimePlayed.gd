extends StatsMenuBase



func _ready() -> void:
	timePlayAmount.text = str(GameStats.playTime)
