extends ColorRect

 
#TODO: make menu loader

@onready var buttonPreset: Button = $%PresetsButton
@onready var buttonGeneral: Button = $%GeneralButton
@onready var buttonDifficutly: Button = $%DifficultyButton
@onready var buttonAccessibility: Button = $%AccessibilityButton
@onready var buttonVideo: Button = $%VideoButton
@onready var buttonAudio: Button = $%AudioButton
@onready var buttonKeybindings: Button = $%KeybindingsButton
@onready var buttonBack: Button = $%BackButton

@onready var settingPreset: VBoxContainer = $%PresetSettings
@onready var settingGeneral: VBoxContainer = $%GeneralSettings
@onready var settingDifficulty: VBoxContainer = $%DifficultySettings
@onready var settingAccessibility: VBoxContainer = $%AccessibilitySettings
@onready var settingVideo: VBoxContainer = $%VideoSettings
@onready var settingAudio: VBoxContainer = $%AudioSettings
@onready var settingKeybinding: VBoxContainer = $%KeybindingsSettings


func _ready() -> void:
	buttonPreset.pressed.connect(show_preset_settings)
	buttonGeneral.pressed.connect(show_general_settings)
	buttonDifficutly.pressed.connect(show_difficulty_settings)
	buttonAccessibility.pressed.connect(show_accessibility_settings)
	buttonVideo.pressed.connect(show_video_settings)
	buttonAudio.pressed.connect(show_audio_settings)
	buttonKeybindings.pressed.connect(show_keybindings_settings)
	show_preset_settings()


func hide_all() -> void:
	settingPreset.visible = false
	settingGeneral.visible = false
	settingDifficulty.visible = false
	settingAccessibility.visible = false
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


func show_accessibility_settings() ->void:
	hide_all()
	settingAccessibility.visible = true


func show_video_settings() -> void:
	hide_all()
	settingVideo.visible = true


func show_audio_settings() -> void:
	hide_all()
	settingAudio.visible = true

func show_keybindings_settings() -> void:
	hide_all()
	settingKeybinding.visible = true
