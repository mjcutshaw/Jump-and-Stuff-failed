extends Node2D
#TODO: set up paused signals

enum audioType {music, background, sfx}

@onready var musicBus: Node2D = $Music
@onready var backgroundBus: Node2D = $Backgrounds
@onready var sfxBus: Node2D = $SFX


func play_sound(type: int, clipName: AudioStream, volume: float = 0.0, pitch: float = 1.0) -> void:
	if type == audioType.music:
		print("need to create music")
	elif type == audioType.background:
		print("need to create background")
	elif type == audioType.sfx:
		_play_sfx(clipName, volume, pitch)
	else:
		print("error player: " + clipName._get_stream_name() + ", unknown type")



#func _play_music(clipName, loop: bool) -> void:
#	pass
#
#
#func _stop_music(clipName) -> void:
#	pass
#
#
#func _pause_music(clipName) -> void:
#	pass


func _play_sfx(clipName, volume: float = 0.0, pitch: float = 1.0) -> void:
	for audioPlayer in sfxBus.get_children():
		if audioPlayer.playing == false:
			audioPlayer.stream = clipName
			audioPlayer.volume_db = volume
			audioPlayer.pitch_scale = pitch
			audioPlayer.play()
