extends Node

#TODO: need to create a resource to store this
var time = 0
var strTimeElapsed

func _ready():
	time = 0

func _process(delta):
	time += delta
	var ms = fmod(time,1)*1000
	var seconds = fmod(time,60)
	var minutes = fmod(time, 3600) / 60
	strTimeElapsed = "%02d : %02d . %02d" % [minutes, seconds, ms]
#	print("elapsed : ", strTimeElapsed)
