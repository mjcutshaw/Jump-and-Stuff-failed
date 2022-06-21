extends VBoxContainer

#TODO: resource to save settings
#TODO: need to convert the values to many 

@onready var muteOverall: CheckBox = $M/V/OverallVolume/V/H/MuteOverall
@onready var muteMusic: CheckBox = $M/V/MusicVolume/V/H/MuteMusic
@onready var muteSFX: CheckBox = $M/V/SFXVolume/V/H/MuteSFX
@onready var muteBG: CheckBox = $M/V/BackgroundVolume/V/H/MuteBackground
@onready var sliderOverall: HSlider = $M/V/OverallVolume/V/SliderOverall
@onready var sliderMusic: HSlider = $M/V/MusicVolume/V/SliderMusic
@onready var sliderSFX: HSlider = $M/V/SFXVolume/V/SliderSFX
@onready var sliderBG: HSlider = $M/V/BackgroundVolume/V/SliderBackground



func _ready() -> void:
	muteOverall.toggled.connect(mute_overall)
	muteMusic.toggled.connect(mute_music)
	muteSFX.toggled.connect(mute_sfx)
	muteBG.toggled.connect(mute_bg)
	sliderOverall.value_changed.connect(slider_overall_changed)
	sliderMusic.value_changed.connect(slider_music_changed)
	sliderSFX.value_changed.connect(slider_sfx_changed)
	sliderBG.value_changed.connect(slider_bg_changed)


func mute_overall(toggled: bool) -> void:
	if toggled:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
	elif !toggled: 
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)


func mute_music(toggled: bool) -> void:
	if toggled:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
	elif !toggled: 
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)


func mute_sfx(toggled: bool) -> void:
	if toggled:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
	elif !toggled: 
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)


func mute_bg(toggled: bool) -> void:
	if toggled:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
	elif !toggled: 
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)


func slider_overall_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)


func slider_music_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)


func slider_sfx_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)


func slider_bg_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Background"), value)
