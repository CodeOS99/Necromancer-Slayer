extends Node2D

var is_player_restarting: bool = false
var is_player_col: bool = false

func _process(delta: float) -> void:
	if is_player_col and !is_player_restarting and Input.is_action_just_pressed("up"): # only need to check for collision and if player has been beaten up by the boss
			$ShouldNotGoNow.visible = true
			$Timer.start()

func _on_timer_timeout() -> void:
	$ShouldNotGoNow.visible = false

func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		is_player_col = true
		if body.is_restarting:
			is_player_restarting = true
		else:
			is_player_restarting = false

func _on_area_2d_2_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		is_player_col = false
