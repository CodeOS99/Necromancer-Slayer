extends Node2D

var collected: bool = false
@export var player: Node2D

func _process(delta: float) -> void:
	if collected:
		position = lerp(position, player.position,.03)
	if collected and player.has_key == false:
		queue_free() # queue_free after the player has opened the door

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		collected = true
		body.has_key = true
		if $AnimationPlayer:
			$AnimationPlayer.queue_free()
