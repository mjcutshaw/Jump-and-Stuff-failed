extends AbilityBlockBase

#TODO: create fade tween, can't figure out how to use alpha


@onready var lockOutTimer: Timer = $LockOutTimer
@export var lockOutTime: float = 4


func _ready() -> void:
	detector.body_entered.connect(ability_rest)
	lockOutTimer.timeout.connect(cooldown)
	lockOutTimer.wait_time = lockOutTime
	
	valid_block(get_name(), global_position)


func ability_rest(body: Player) -> void:
	if ability == Abilities.abiliyList.Null:
		print("null ability reset")
	else:
		body.reset(ability)
		lockOutTimer.start()
		visible = false
		set_deferred("monitoring", false)

func cooldown() -> void:
	visible = true
	set_deferred("monitoring", true)
