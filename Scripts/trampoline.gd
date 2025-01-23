extends StaticBody2D

@export var applied_velocity = -1000

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$AnimatedSprite2D.play("jump")
		body.move_y_and_set_vel(0,applied_velocity)
