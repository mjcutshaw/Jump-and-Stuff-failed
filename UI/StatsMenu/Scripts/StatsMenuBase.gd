extends MarginContainer
class_name StatsMenuBase

#FIXME: see about trying to convert a enum to regular var
var GameStats = ResourceLoader.load("res://UI/Resources/GameStats.tres")
@onready var statNameLabel: Label = $%Name
@onready var amountLabel: Label = $%Amount


@export var statName: String
@export var timeConvert: bool = false
@export var stat : GameStats.stats

func _ready() -> void:
	statNameLabel.text = str(stat)

func convert_time(time) -> void:
	var timeElapsed
	var mils = fmod(time, 1) * 1000
	var secs = fmod(time, 60)
	var mins = fmod(time, 3600) / 60
	var hr = fmod(time, 3600 * 60) / 3600
	timeElapsed = "%02d : %02d : %02d . %03d" % [hr, mins, secs, mils]
	
	amountLabel.text = timeElapsed
