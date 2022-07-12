extends MarginContainer

#TODO: change these to own scenes and canvas layers

var Settings = ResourceLoader.load("res://UI/Resources/Settings.tres")
var GameStats = ResourceLoader.load("res://UI/Resources/GameStats.tres")

@onready var playTimeLabel: Label = $Label

var strTimeElapsed

func _ready() -> void:
	EventBus.settings_update.connect(show_timer)
	visible = Settings.showTimer


func show_timer():
	visible = Settings.showTimer


func _process(delta):
	GameStats.playTime += delta
	var mils = fmod(GameStats.playTime,1)*1000
	var secs = fmod(GameStats.playTime,60)
	var mins = fmod(GameStats.playTime, 3600) / 60
	var hr = fmod(GameStats.playTime,3600 * 60) / 3600
	strTimeElapsed = "%02d : %02d : %02d . %03d" % [hr, mins, secs, mils]
	
	playTimeLabel.text = strTimeElapsed
