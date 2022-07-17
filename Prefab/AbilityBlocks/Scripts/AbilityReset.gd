extends AbilityBlockBase

#TODO: create fade tween, can't figure out how to use alpha


@onready var lockOutTimer: Timer = $LockOutTimer
@export var lockOutTime: float = 4


func _ready() -> void:
	modulate = Color.YELLOW
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
		modulate = Color(Color.DARK_GRAY, .2)
		set_deferred("monitoring", false)

func cooldown() -> void:
	modulate = Color.YELLOW
	set_deferred("monitoring", true)
