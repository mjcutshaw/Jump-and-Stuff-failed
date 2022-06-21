extends ColorRect

@onready var buttonPreset: Button = $M/H/ButtonMargins/V/M/P/M/Buttons/M5/Presets
@onready var buttonGeneral: Button = $M/H/ButtonMargins/V/M/P/M/Buttons/M/General
@onready var buttonDifficutly: Button = $M/H/ButtonMargins/V/M/P/M/Buttons/M2/Difficulty
@onready var buttonVideo: Button = $M/H/ButtonMargins/V/M/P/M/Buttons/M3/Video
@onready var buttonAudio: Button = $M/H/ButtonMargins/V/M/P/M/Buttons/M4/Audio
@onready var buttonKeybindings: Button = $M/H/ButtonMargins/V/M/P/M/Buttons/Keybindings
@onready var buttonBack: Button = $M/H/ButtonMargins/V/M2/P/M/H/M/Back

@onready var settingPreset: VBoxContainer = $M/H/M/P/M/PresetSettings
@onready var settingGeneral: VBoxContainer = $M/H/M/P/M/GeneralSettings
@onready var settingDifficulty: VBoxContainer = $M/H/M/P/M/DifficultySettings
@onready var settingVideo: VBoxContainer = $M/H/M/P/M/VideoSettings
@onready var settingAudio: VBoxContainer = $M/H/M/P/M/AudioSettings
@onready var settingKeybinding: VBoxContainer = $M/H/M/P/M/Keybindings


func _ready() -> void:
	buttonPreset.pressed.connect(show_preset_settings)
	buttonGeneral.pressed.connect(show_general_settings)
	buttonDifficutly.pressed.connect(show_difficulty_settings)
	buttonVideo.pressed.connect(show_video_settings)
	buttonAudio.pressed.connect(show_audio_settings)
	buttonKeybindings.pressed.connect(show_keybindings_settings)


func hide_all() -> void:
	settingPreset.visible = false
	settingGeneral.visible = false
	settingDifficulty.visible = false
	settingVideo.visible = false
	settingAudio.visible = false
	settingKeybinding.visible = false


func show_preset_settings() -> void:
	hide_all()
	settingPreset.visible = true


func show_general_settings() -> void:
	hide_all()
	settingGeneral.visible = true


func show_difficulty_settings() -> void:
	hide_all()
	settingDifficulty.visible = true


func show_video_settings() -> void:
	hide_all()
	settingVideo.visible = true


func show_audio_settings() -> void:
	hide_all()
	settingAudio.visible = true

func show_keybindings_settings() -> void:
	hide_all()
	settingKeybinding.visible = true
