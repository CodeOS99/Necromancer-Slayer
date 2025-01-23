extends Area2D

@onready var game_manager: Node = $"../GameManager"

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" and $AnimatedSprite2D.animation != "collected":
		$AnimatedSprite2D.play("collected")
		game_manager.add_cherries(1)


func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "collected":
		queue_free()
