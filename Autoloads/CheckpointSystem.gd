extends Node


var currentSpawn = null

func reset():
	currentSpawn = null
	get_tree().reload_current_scene()

func check_reset():
	if currentSpawn == null:
		reset()
	else:
		return false

func set_spawn(spawn):
	currentSpawn = spawn

func get_spawn():
	return currentSpawn
