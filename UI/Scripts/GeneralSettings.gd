extends VBoxContainer

@onready var buttonTimer: CheckBox = $M/V/Timer/Toggle
var settings = ResourceLoader.load("res://Resources/Settings.tres")

func _ready() -> void:
	buttonTimer.toggled.connect(show_timer)


func _process(delta: float) -> void:
	pass

func show_timer(toggle):
	settings.showTimer = toggle
	EventBus.emit_signal("settings_update")
