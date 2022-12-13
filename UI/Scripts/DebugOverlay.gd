extends MarginContainer

@onready var fpsLabel: Label = $MarginContainer/VBoxContainer/FPS
@onready var stateLabel: Label = $MarginContainer/VBoxContainer/State
@onready var velocityLabel: Label = $MarginContainer/VBoxContainer/Velocity

func _ready():
	EventBus.connect("debugState", set_state_label)
	EventBus.connect("debugVelocity", set_velocity_label)

func _process(delta: float) -> void:
	fpsLabel.text = "FPS: " + str(Engine.get_frames_per_second())

func set_state_label(info) -> void:
	stateLabel.text = "State: " + str(info)

func set_velocity_label(info) -> void:
	velocityLabel.text = "Velocity: " + str(info)
