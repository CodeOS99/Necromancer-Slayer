extends CharacterBody2D

const wt = 0.02

var inLadder: bool = false
var canAtk: bool = true

var dead = false

var default = preload("res://Scenes/flying_monster.tscn")

func _physics_process(delta: float) -> void:
	if not dead:
		# Add the gravity.
		if not is_on_floor():
			if not inLadder:
				velocity += get_gravity() * delta

		if canAtk:
			position = lerp(position, get_tree().get_nodes_in_group("player")[0].position, wt)
			if l_or_r() == "right":
				if $AnimationPlayer.current_animation != "run_right":
					$AnimationPlayer.play("run_right")
			else:
				if $AnimationPlayer.current_animation != "run_left":
					$AnimationPlayer.play("run_left")

		move_and_slide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "Ladder":
		inLadder = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.name == "Ladder":
		inLadder = false

func _on_atk_range_body_entered(body: Node2D) -> void:
	if body.name == "Player" and canAtk:
		$AnimationPlayer.play("atk_" + l_or_r())
		canAtk = false
		createResetTimer()
		
func createResetTimer():
	var t = Timer.new()
	t.autostart = false
	t.one_shot = true
	t.wait_time = 1
	add_child(t)
	t.start()
	t.timeout.connect(resetAtk)

func resetAtk():
	canAtk = true

func l_or_r():
	var player = get_tree().get_nodes_in_group("player")[0]
	if position.x - player.position.x <= 0:
		return "right"
	else:
		return "left"

func _on_timer_timeout() -> void:
	dead = true
	$AnimationPlayer.play("death")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "death":
		var t = create_tween()
		t.tween_property($AnimatedSprite2D, "modulate", Color(255,255,255,0), 1)
		t.finished.connect(kill)
 
func kill():
	queue_free()

func _on_threshold_body_entered(body: Node2D) -> void:
	if is_instance_of(body, TileMapLayer):
		# Use call_deferred to delay the execution of adding the child
		call_deferred("_add_flying_monster", position)
		queue_free()

func _add_flying_monster(spawn_position: Vector2) -> void:
	var s = default.instantiate()  # Instantiate the flying monster scene
	add_child(s)  # Add the instance as a child of the current node
	s.position = spawn_position  # Set the position of the new flying monster
