extends CharacterBody2D

var rem_h = 5
const SPEED = 300.0
const JUMP_VELOCITY = -575.0
const CLIMB_VELOCITY  = -550.0

var on_ladder: bool = false
var is_dead: bool = false

var has_key: bool = false
var is_restarting: bool = false

var boss_dead = false

@onready var player_sprite: AnimatedSprite2D = $PlayerSprite
@onready var timer: Timer = $Timer

func _physics_process(delta: float) -> void:
	if not boss_dead:
		# Add the gravity.
		if not is_on_floor() and !on_ladder:
			velocity += get_gravity() * delta
		
		if not is_dead:
		
			handle_jump()

			handle_movement()
		
		var was_on_floor = is_on_floor()

		move_and_slide()
		
		if was_on_floor and !is_on_floor() and velocity.y >= 0:
			timer.start()

func handle_jump():
	if !on_ladder:
		if Input.is_action_just_pressed("up"):
			if is_on_floor():
				velocity.y = JUMP_VELOCITY
			elif timer.time_left > 0:
				velocity.y = JUMP_VELOCITY
		return
	
	# On ladder
	var direction = Input.get_axis("up", "down")
	if direction != 0:
		velocity.y = -direction * CLIMB_VELOCITY
		player_sprite.play("climb")
	else:
		velocity.y = 0
		player_sprite.play("climb")
		player_sprite.frame = 0

func handle_movement():
	var direction := Input.get_axis("left", "right")
	
	# Flipping of sprite
	if direction > 0:
		player_sprite.flip_h = false
	elif direction < 0:
		player_sprite.flip_h = true
		
	# Actually move the player
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Animation changer
	if !on_ladder:
		if direction == 0:
			player_sprite.play("idle")
		else:
			player_sprite.play("run")
		
		# Change animation for jumps
		if not is_on_floor():
			if velocity.y <= 0.0: # moving up
				player_sprite.play("jumpUp")
			elif velocity.y > 0.0 : # moving down
				player_sprite.play("fallDown")

func kill():
	player_sprite.play("dead")
	is_dead = true

func move_y_and_set_vel(n: int, v: int):
	position.y += n
	velocity.y += v

func _on_boss_dead() -> void:
	$Camera2D.global_position = $"../Boss".global_position
	boss_dead = true


func _on_obelisk_positions_obelisk_broken() -> void:
	rem_h -= 1
	if rem_h > 0:
		$Camera2D._camera_shake()
