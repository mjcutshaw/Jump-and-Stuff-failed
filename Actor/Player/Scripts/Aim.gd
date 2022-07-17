extends Node2D

@onready var player = get_parent()
@onready var raycast: RayCast2D = $RayCast2D
@onready var aimIndicator: Node2D = $AimIndicator
@onready var detector: Area2D = $Detector

func _ready() -> void:
	aimIndicator.visible = false


func _unhandled_input(event: InputEvent) -> void:
	pass

func _physics_process(delta: float) -> void:
	aim_direction()
	
	
	
	if player.aimDirection == Vector2.ZERO:
		aimIndicator.visible = false
	else:
		aimIndicator.visible = true
		aim()


func aim_direction() -> void:
	player.aimStrength =  Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down")
	#todo: change deadzone to settings
	var deadzone_radius: = 0.2
	if player.aimStrength.length() > deadzone_radius:
		player.aimDirection = player.aimStrength
	else:
		player.aimDirection = Vector2.ZERO

func aim()-> void:
	var cast: Vector2 = player.aimDirection.normalized() * raycast.target_position.length()
	var angle: = cast.angle()
	raycast.target_position = cast
	aimIndicator.rotation = angle
	detector.rotation = angle
	raycast.force_raycast_update()
