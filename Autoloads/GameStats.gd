extends Node

#TODO: need to create a resource to store this
var time = 0
var strTimeElapsed

func _ready():
	time = 0

func _process(delta):
	time += delta
	var mils = fmod(time,1)*1000
	var secs = fmod(time,60)
	var mins = fmod(time, 3600) / 60
	var hr = fmod(time,3600 * 60) / 3600
	strTimeElapsed = "%02d : %02d : %02d . %03d" % [hr, mins, secs, mils]
#	print("elapsed : ", strTimeElapsed)
