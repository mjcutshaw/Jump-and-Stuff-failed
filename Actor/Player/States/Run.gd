extends GroundState

func input(_event: InputEvent):
	var new_state = super.input(_event)
	if new_state:
		return new_state
	
	if Input.is_action_just_released("run"):
		return State.Walk

	return State.Null
