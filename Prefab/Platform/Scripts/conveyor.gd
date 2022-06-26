extends StaticBody2D

#TODO make vertical work

@export var speed = 500
@export_enum("horizontal", "vertical") var orientation

func _ready():
	if orientation == 0:
		constant_linear_velocity.x = speed
	elif orientation == 1:
		constant_linear_velocity.y = speed

func _process(delta):
	if orientation == 0:
		$Sprite.texture.region.position.x -= speed * delta
	elif orientation == 1:
		$Sprite.texture.region.position.y -= speed * delta
