extends VBoxContainer

@onready var buttonTimer: CheckBox = $%ButtonTimer
var settings: Resource = preload("res://UI/Resources/Settings.tres")

func _ready() -> void:
	buttonTimer.toggled.connect(show_timer)


func _process(delta: float) -> void:
	pass

func show_timer(toggle):
	settings.showTimer = toggle
	EventBus.emit_signal("settings_update")
