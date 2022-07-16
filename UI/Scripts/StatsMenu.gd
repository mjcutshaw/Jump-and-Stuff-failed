extends Control

#TODO: need to process the delta time to readable for times, probably a global function
#TODO: grey out if ability not unlocked
#TODO: look to moving to each label, make class to inherit from

var GameStats = ResourceLoader.load("res://UI/Resources/GameStats.tres")

@onready var timePlayAmount: Label = $%TimePlayedAmount
@onready var timeOnGroundAmount: Label = $%TimeGroundAmount
@onready var timeInAirAmount: Label = $%TimeAirAmount
@onready var timeInWaterAmount: Label = $%TimeWaterAmount
@onready var timeBurrowedAmount: Label = $%TimeBurrowedAmount
@onready var timeLongestLifedAmount: Label = $%LongLifeAmount

@onready var jumpsAmount: Label = $%JumpsAmount
@onready var jumpsWallAmount: Label = $%JumpsWallAmount
@onready var dashsAmount: Label = $%DashsAmount
@onready var grapplesAmount: Label = $%GrapplesAmount

@onready var deathAmount: Label = $%DeathAmount

@onready var completionAmount: Label = $%CompletionAmount
@onready var completionPercent: int = (GameStats.pickups / GameStats.totalPickups) * 100


func _ready() -> void:
	timePlayAmount.text = convert_time(GameStats.timePlayed)
	timeOnGroundAmount.text  = convert_time(GameStats.timeOnGround)
	timeInAirAmount.text  = convert_time(GameStats.timeInAir)
	timeInWaterAmount.text = convert_time(GameStats.timeInWater)
	timeBurrowedAmount.text = convert_time(GameStats.timeBurrowed)
	timeLongestLifedAmount.text = convert_time(GameStats.timeLongestLife)
	
	jumpsAmount.text = str(GameStats.jumps)
	jumpsWallAmount.text = str(GameStats.jumpsWall)
	dashsAmount.text = str(GameStats.dashes)
	grapplesAmount.text = str(GameStats.grapples)
	
	deathAmount.text = str(GameStats.deaths)
	
	completionAmount.text = str(completionPercent) + "%"
	
	


func convert_time(time) -> String:
	var strTimeElapsed
	var mils = fmod(time, 1)*1000
	var secs = fmod(time, 60)
	var mins = fmod(time, 3600) / 60
	var hr = fmod(time, 3600 * 60) / 3600
	strTimeElapsed = "%02d : %02d : %02d . %03d" % [hr, mins, secs, mils]
	
	return strTimeElapsed


## Ori Stats ##
#Time alive
#% Completed
#Total deaths
#Times Drowne
#Deaths by Enemy
#Deaths by Hazard
#Damage taken
#Enemies Slain
#Energy Spent
#Life Regenerated
#Abilities Upgraded
#Biggest Single Attack
#Jumps
#Wall Jumps
#Dashes
#Bashes
#Grapples
#Distance Travelled
#Distance Swam
#Distance Burrowed
#Distance Glided
#Glow Time
#Airborne Time
#Longest Air Time
#Times Warped
#Total Spirit Light Collected
#Total Spirit Light Spent
#Abilities Discovered
#Life Cells Collected
#Energy Cells Collected
#Shard Slot Upgrades Collected
#Shards Collected
#Shrines Discovered
#Shrines Completed
#% Shard Upgrades Complete
