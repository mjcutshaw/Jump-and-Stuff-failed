extends Area2D

#TODO: create fade tween, can't figure out how to use alpha

var Abilities = ResourceLoader.load("res://Actor/Player/Resources/PlayerAbilities.tres")
@export var ability: PlayerAbilities.abiliyList
@onready var lockOutTimer: Timer = $LockOutTimer
@export var lockOutTime: float = 4


func _ready() -> void:
	body_entered.connect(ability_rest)
	lockOutTimer.timeout.connect(cooldown)
	lockOutTimer.wait_time = lockOutTime


func ability_rest(body: Player) -> void:
	body.reset(ability)
	lockOutTimer.start()
	visible = false
	set_deferred("monitoring", false)

func cooldown() -> void:
	visible = true
	set_deferred("monitoring", true)
