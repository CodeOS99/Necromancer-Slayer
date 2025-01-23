extends Area2D

@onready var timer: Timer = $Timer
var canKill = true

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" and $"..".visible and canKill:
		body.get_node("PlayerCollision").queue_free()
		body.kill() # Custom method for handling all the animation and other changes
		Engine.time_scale = 0.25
		timer.start()


func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
