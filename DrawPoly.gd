extends CollisionPolygon2D

@onready var polyShape: Polygon2D = $Polygon2D

func _ready() -> void:
	polyShape.polygon = polygon
