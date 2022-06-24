extends MoveState
#TODO: turn off bonk in settings

var currentBonkTime: float
var bonkTime: float = 1.5



func enter() -> void:
	super.enter()

	currentBonkTime = bonkTime
	player.velocity = Vector2(300 * player.wallDirection.x, 800)
	var tween = create_tween()
	tween.tween_property(player.characterRig, "scale", Vector2(0.2, 0.8), .05)
	player.soundBonk.play()


func exit() -> void:
	super.exit()

#	player.previousVelocity = player.velocity


func physics(_delta) -> void:
	super.physics(_delta)

	if player.is_on_floor():
		currentBonkTime -= _delta
		player.velocity = Vector2.ZERO
		var tween = create_tween()
		tween.tween_property(player.characterRig, "scale", Vector2(1, 1), .5)


func visual(_delta) -> void:
	super.visual(_delta)

	facing(player.lastWallDirection.x)


func sound(_delta: float) -> void:
	super.sound(_delta)

	


func handle_input(_event: InputEvent) -> int:
	var newState = super.handle_input(_event)
	if newState:
		return newState

	

	return State.Null


func state_check(_delta: float) -> int:
	var newState = super.state_check(_delta)
	if newState:
		return newState

	if currentBonkTime < 0:
		return State.Idle

	return State.Null
