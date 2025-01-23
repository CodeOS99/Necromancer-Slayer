extends CharacterBody2D

# straight-ish line straight-ish line straight-ish line straight-ish line

const rotationSpeed = 1.1
const lifeSpan = 5

var u1 : int = 500 # Initial speed for moving in a straight-ish line
var t1 : float = 1 # Time for which the skull should move in a straight-ish line
var uCap : int # Direction, left or right, for u1
var timer : Timer

var canTurn : bool = false
var u2 : int = u1 # speed for turning
var c : float = 0.01 # Speed of light /s
var target : Vector2

var lifeSpanTimer: Timer

var juiceOver = false # This basically means the skull can no longer home into the player target, so it moves straight

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if position.x < target.x:
		uCap = 1
	else:
		uCap = -1
	velocity.x = u1 * uCap
	$AnimatedSprite2D.scale.x = abs($AnimatedSprite2D.scale.x) * uCap
	
	timer = Timer.new()    
	add_child(timer)
	
	timer.wait_time = t1  # Set the wait time for the timer
	timer.one_shot = true  # Ensure the timer fires only once
	timer.autostart = true  # Automatically start the timer
	timer.timeout.connect(on_timer_timeout)
	timer.start()
	
	
	lifeSpanTimer = Timer.new()    
	add_child(lifeSpanTimer)
	
	lifeSpanTimer.wait_time = lifeSpan  # Set the wait time for the lifeSpanTimer
	lifeSpanTimer.one_shot = true  # Ensure the lifeSpanTimer fires only once
	lifeSpanTimer.autostart = true  # Automatically start the lifeSpanTimer
	lifeSpanTimer.timeout.connect(kill)
	lifeSpanTimer.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if canTurn:
		# Calculate the direction to the player
		var direction_to_player = (target - position).normalized()
		
		# Calculate the angle between the current facing direction and the target direction
		var current_angle = rotation  # Current angle of the object (in radians)
		var target_angle = direction_to_player.angle()  # Angle to the player
		
		# Calculate the difference between the current angle and the target angle
		var angle_diff = target_angle - current_angle
		
		# Ensure the angle difference is within -PI to PI range for smooth rotation
		angle_diff = fposmod(angle_diff + PI, PI * 2) - PI
		
		# Apply a smooth rotation towards the player
		rotate(angle_diff * rotationSpeed * delta)
		if position.distance_to(target)>10 and not juiceOver:
			# Move towards the player
			velocity = direction_to_player * u2
		else:
			juiceOver = true
	move_and_slide()

func on_timer_timeout():
	canTurn = true

func kill():
	queue_free()
