extends CanvasLayer

signal canTarget

@onready var top_bar = $Top
@onready var bottom_bar = $Bottom

var bar_percentage = 0.15
var prev_screen_size: Vector2i

func _ready():
	prev_screen_size = get_viewport().size
	adjust_bars()

# Function to adjust the position and size of the black bars dynamically
func adjust_bars():
	var screen_size = get_viewport().size
	var bar_height = screen_size.y * bar_percentage
	
	# Set size and position of the top bar
	top_bar.size = Vector2(screen_size.x, bar_height)
	top_bar.position = Vector2(0, 0)  # Position at the top of the screen
	
	# Set size and position of the bottom bar
	bottom_bar.size = Vector2(screen_size.x, bar_height)
	bottom_bar.position = Vector2(0, screen_size.y - bar_height)  # Position at the bottom of the screen

func _process(delta):
	# Check if the screen size has changed (e.g., window resizing)
	if get_viewport().size != prev_screen_size:
		prev_screen_size = get_viewport().size
		adjust_bars()  # Update the positions and sizes of the bars when the screen size changes


func _on_bar_showing_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		var tween = get_tree().create_tween().set_parallel(true)
		tween.tween_property(top_bar, "modulate", Color.BLACK, 1)
		tween.tween_property(bottom_bar, "modulate", Color.BLACK, 1)
		canTarget.emit()
