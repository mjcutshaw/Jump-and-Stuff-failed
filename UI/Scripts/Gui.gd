extends CanvasLayer

@onready var pauseMenu: ColorRect = $PauseMenu
@onready var settingsMenu: ColorRect = $SettingsMenu
@onready var devConsole: ColorRect = $DevConsole


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause_menu") and !pauseMenu.visible:
		pauseMenu.pause()
	if Input.is_action_just_pressed("dev_console"):
		EventBus.emit_signal("ability_check")
		devConsole.visible = !devConsole.visible 

func _ready() -> void:
	pauseMenu.buttonSettings.pressed.connect(go_to_settings)
	settingsMenu.buttonBack.pressed.connect(go_to_pause)

func go_to_settings():
	pauseMenu.visible = false
	settingsMenu.visible = true

func go_to_pause():
	settingsMenu.visible = false
	pauseMenu.visible = true
