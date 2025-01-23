extends Node2D

var can_open: bool = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("up") and can_open: # can_open represent the condition for checking if the player has enetered and if the door is open
		get_tree().change_scene_to_file("res://Scenes/bossroom.tscn")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if body.has_key:
			$AnimatedSprite2D.play("opened")
			$HowToEnter.visible = true
			body.has_key = false
		else:
			$Label.visible = true
			$LabelShowTimer.start()
		if $AnimatedSprite2D.animation == "opened":
			can_open = true


func _on_label_show_timer_timeout() -> void:
	$Label.visible = false


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		can_open = false
