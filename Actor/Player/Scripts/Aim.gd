extends Node2D

@onready var player = get_parent()
@onready var raycast: RayCast2D = $RayCast2D
@onready var aimIndicator: ColorRect = $AimIndicator
@onready var detector: Area2D = $Detector

func _ready() -> void:
	aimIndicator.visible = false


func _unhandled_input(event: InputEvent) -> void:
	if player.aimDirection != Vector2.ZERO:
		aimIndicator.visible = true
		aim()
	else:
		aimIndicator.visible = false

func _physics_process(delta: float) -> void:
	aim_direction()


func aim_direction() -> void:
	player.aimDirection =  Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down")
	

func aim()-> void:
	var cast: Vector2 = player.aimDirection * raycast.target_position.length()
	var angle: = cast.angle()
#	rotation = angle
	raycast.target_position = cast
	aimIndicator.rotation = angle
	detector.rotation = angle
	raycast.force_raycast_update()
