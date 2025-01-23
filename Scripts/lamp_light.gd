extends PointLight2D

var speed = 1.0

var colors = [
	Color(1.0, 1.0, 0.0),  # Yellow
	Color(1.0, 0.647, 0.0),  # Orange
	Color(1.0, 0.0, 0.0),  # Red
	Color(1.0, 1.0, 1.0)   # White
]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	energy += speed * delta * randf()
	if energy >= 2.5 or energy <= 1:
		speed *= -1
		
