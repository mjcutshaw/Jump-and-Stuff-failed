extends Node
#TODO: set up paused signals
# probably only useful for nonpositional audio
enum audioType {music, background, sfx}
#TODO: add more types, fanfare?

@onready var musicBus: Node = $Music
@onready var backgroundBus: Node = $Backgrounds
@onready var sfxBus: Node = $SFX


func play_sound(type: int, clipName: AudioStream, volume: float = 0.0, pitch: float = 1.0) -> void:
	if type == audioType.music:
		print("need to create music")
	elif type == audioType.background:
		print("need to create background")
	elif type == audioType.sfx:
		_play_sfx(clipName,  volume, pitch)
	else:
		print("error player: " + clipName._get_stream_name() + ", unknown type")


func stop_sound(type: int, clipName: AudioStream):
	if type == audioType.music:
		print("need to create music")
	elif type == audioType.background:
		print("need to create background")
	elif type == audioType.sfx:
		_stop_sfx(clipName)


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

#FIXME: currently plays through all the audiostreams
func _play_sfx(clipName, volume: float = 0.0, pitch: float = 1.0) -> void:
	for audioPlayer in sfxBus.get_children():
		if audioPlayer.playing == false:
			audioPlayer.stream = clipName
			audioPlayer.volume_db = volume
			audioPlayer.pitch_scale = pitch
#			audioPlayer.position = positionS
			#currently not using positional
			audioPlayer.play()

func _stop_sfx(clipName) -> void:
	for audioPlayer in sfxBus.get_children():
		if audioPlayer.stream == clipName:
			print("please stop")
			audioPlayer.stop()
