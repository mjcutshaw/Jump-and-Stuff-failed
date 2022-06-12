class_name Player
extends CharacterBody2D

var gravity = 4  * Globals.TILE_SIZE
#TODO change to a global gravity

@onready var sm = $StateMachine

func _ready() -> void:
	sm.init(self)

func _unhandled_input(_event: InputEvent) -> void:
	sm.handle_input(_event)

func _physics_process(_delta: float) -> void:
	sm.physics(_delta)
	sm.state_check(_delta)
	$State.text = sm.currentState.name
	$Velocity.text = str(velocity.round())

func _process(_delta: float) -> void:
	sm.visual(_delta)
