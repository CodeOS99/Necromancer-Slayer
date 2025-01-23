extends Label
var speed = 5.0
var maxPoints = 7
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = "You scored " + str(Globals.bonusPoints) + (" point!" if Globals.bonusPoints == 1 else " points") + " out of " + str(maxPoints) + " total points!" + ("" if Globals.bonusPoints != maxPoints else "\nNice! You got all " + str(maxPoints) + "!")
	
func _process(delta: float) -> void:
	if Globals.bonusPoints == maxPoints:
		# Calculate RGB values using sine waves
		var time = Time.get_ticks_msec() / 1000.0 * speed
		var red = int(127.5 * (1 + sin(time)))
		var green = int(127.5 * (1 + sin(time + 2 * PI / 3)))
		var blue = int(127.5 * (1 + sin(time + 4 * PI / 3)))

		# Set the label's modulate color
		self.modulate = Color(red / 255.0, green / 255.0, blue / 255.0)
