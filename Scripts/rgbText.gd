extends Label

@export var speed = 5.0 # Speed of color change

func _process(delta):
	# Calculate RGB values using sine waves
	var time = Time.get_ticks_msec() / 1000.0 * speed
	var red = int(127.5 * (1 + sin(time)))
	var green = int(127.5 * (1 + sin(time + 2 * PI / 3)))
	var blue = int(127.5 * (1 + sin(time + 4 * PI / 3)))

	# Set the label's modulate color
	self.modulate = Color(red / 255.0, green / 255.0, blue / 255.0)
