extends MarginContainer

var settings = ResourceLoader.load("res://UI/Resources/Settings.tres")


func _ready() -> void:
	EventBus.settings_update.connect(show_timer)
	visible = settings.showTimer
	#TODO: add reading timer from save


func show_timer():
	visible = settings.showTimer
