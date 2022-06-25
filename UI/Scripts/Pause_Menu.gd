extends ColorRect

#FIXME: esc key is taking you backto settings
#TODO: find a better way to swap menus instead of loading them all
@onready var buttonResume: Button = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/Resume
@onready var buttonSettings: Button = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/Options
@onready var buttonQuit: Button = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/Quit
@onready var animPlayer: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	buttonResume.pressed.connect(unpause)


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause_menu"):
		unpause()

#TODO: make tweens
func unpause():
	animPlayer.play("Unpause")
	get_tree().paused = false
#	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func pause():
	animPlayer.play("Pause")
	get_tree().paused = true
#	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	await get_tree().create_timer(0.1).timeout
	buttonResume.grab_focus()
