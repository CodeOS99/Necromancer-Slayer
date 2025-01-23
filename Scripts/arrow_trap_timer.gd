extends Timer


func _ready() -> void:
	wait_time = randf()
	start()
	timeout.connect(timer_timeout)

func timer_timeout():
	$"../AnimationPlayer".play("shoot")
