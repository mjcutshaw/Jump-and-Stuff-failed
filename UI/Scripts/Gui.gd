extends CanvasLayer

@onready var pauseMenu: ColorRect = $PauseMenu

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause_menu") and !pauseMenu.visible:
		pauseMenu.pause()
