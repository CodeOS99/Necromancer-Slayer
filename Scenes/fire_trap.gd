extends Node2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$AnimationPlayer.play("on_activation")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "on_activation":
		$AnimationPlayer.play("default")
