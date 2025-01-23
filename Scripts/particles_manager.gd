extends Node2D

var prev_screen_size

func _ready():
	prev_screen_size = get_viewport().size
	adjustParticles()

func adjustParticles():
	var screen_size = get_viewport().size
	for child in get_children():
		child.position.x = screen_size.x / 2

func _process(delta):
	# Check if the screen size has changed (e.g., window resizing)
	if get_viewport().size != prev_screen_size:
		prev_screen_size = get_viewport().size
		adjustParticles()  # Update the positions and sizes of the bars when the screen size changes
