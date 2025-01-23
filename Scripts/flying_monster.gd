extends CharacterBody2D

const wt = 0.04
var dead = false
var offset_range = 20 # Adjust this value to control the offset range.

func _ready():
	# Add a small random offset to the initial position, to differentiate them
	position.x += randf_range(-offset_range, offset_range)
	position.y += randf_range(-offset_range, offset_range)

func _physics_process(delta: float) -> void:
	if not dead:
		var player_position = get_tree().get_nodes_in_group("player")[0].position
		# Calculate direction to the player
		var direction = (player_position - position).normalized()

		# Add a random offset to the direction vector
		direction.x += randf_range(-0.1, 0.1)  # Small random variation in X
		direction.y += randf_range(-0.1, 0.1)  # Small random variation in Y
		direction = direction.normalized()  # Re-normalize to maintain consistent speed

		# Move with the modified direction
		position += direction * wt * 100  # Adjust speed as necessary

		# Handle sprite flipping based on movement
		if l_or_r() == "right":
			$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.flip_h = true

		move_and_slide()

func l_or_r():
	var player = get_tree().get_nodes_in_group("player")[0]
	if position.x - player.position.x <= 0:
		return "right"
	else:
		return "left"


func _on_timer_timeout() -> void:
	$AnimatedSprite2D.play("death")
	dead = true

func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "death":
		var t = create_tween()
		t.tween_property($AnimatedSprite2D, "modulate", Color(255,255,255,0), 1)
		t.finished.connect(kill)
 
func kill():
	queue_free()
