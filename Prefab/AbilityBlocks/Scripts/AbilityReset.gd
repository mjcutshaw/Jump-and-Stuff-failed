extends AbilityBlockBase

#TODO: create fade tween, can't figure out how to use alpha
#TODO: add checks for invalid selection (ie grapple)

@onready var lockOutTimer: Timer = $LockOutTimer
@export var lockOutTime: float = 4



func _ready() -> void:
	block_color()
	modulate = blockColor
	detector.body_entered.connect(ability_rest)
	lockOutTimer.timeout.connect(cooldown)
	lockOutTimer.wait_time = lockOutTime
	
	valid_block(get_name(), global_position)


func ability_rest(body: Player) -> void:
	body.reset(ability)
	lockOutTimer.start()
	modulate = Color(Color.DARK_GRAY, .2)
	detector.set_deferred("monitoring", false)

func cooldown() -> void:
	modulate = blockColor
	detector.set_deferred("monitoring", true)
