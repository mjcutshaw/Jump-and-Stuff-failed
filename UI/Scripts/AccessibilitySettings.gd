extends VBoxContainer


@onready var buttonToggleGlide: CheckBox = $M/V/Glide/Toggle
@onready var buttonToggleGrab: CheckBox = $M/V/Grab/Toggle
@onready var buttonToggleVibration: CheckBox = $M/V/Vibration/Toggle
var settings = ResourceLoader.load("res://UI/Resources/Settings.tres")

func _ready() -> void:
	buttonToggleGlide.toggled.connect(toggle_glide)
	buttonToggleGrab.toggled.connect(toggle_grab)
	buttonToggleVibration.toggled.connect(toggle_vibration)



func toggle_glide(toggle):
	settings.toggleGlide = toggle
	EventBus.emit_signal("settings_update")


func toggle_grab(toggle):
	settings.toggleGrab = toggle
	EventBus.emit_signal("settings_update")


func toggle_vibration(toggle):
	settings.toggleVibration = toggle
	EventBus.emit_signal("settings_update")
