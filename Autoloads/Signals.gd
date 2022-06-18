extends Node

#TODO: change to SignalBus

signal jumped
signal dashed
signal spun
#TODO: All abilities

signal bonked

signal ability_check
signal ability_unlocked(data)
signal unlocked_dash_side

signal player_spawned
signal player_died
signal checkpoint(data)

signal small_screen_shake
signal medium_screen_shake
signal large_screen_shake

signal level_completed(data)
signal level_started(data)
signal change_scene(data)
signal free_look_camera(data)

signal game_paused(data)
signal game_exit
