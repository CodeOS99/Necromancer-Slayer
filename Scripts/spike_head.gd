extends StaticBody2D

@export var endpoint: Node2D
var original_position: Vector2

func _ready() -> void:
	original_position = position
