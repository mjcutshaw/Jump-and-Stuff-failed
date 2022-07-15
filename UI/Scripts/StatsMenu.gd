extends Control

#TODO: need to process the delta time to readable for times, probably a global function
#TODO: grey out if ability not unlocked
#TODO: look to moving to each label

var GameStats = ResourceLoader.load("res://UI/Resources/GameStats.tres")
@onready var timePlayAmount: Label = $%TimePlayAmount
@onready var deathAmount: Label = $%DeathAmount

func _ready() -> void:
	deathAmount.text = str(GameStats.deaths)

func _process(delta: float) -> void:
	timePlayAmount.text = str(GameStats.playTime)

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
