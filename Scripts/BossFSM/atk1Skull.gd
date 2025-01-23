extends BossState
class_name atk1

@onready var fireball: PackedScene = preload("res://Scenes/fireball.tscn")
var player

func enter():
	super()
	$"../../AnimatedSprite2D".play("atk1")

func animFinished():
	super()
	if $"../../AnimatedSprite2D".animation == "atk1":
		Transitioned.emit(self, "chase")


func _on_animated_sprite_2d_frame_changed() -> void:
	if $"../../AnimatedSprite2D".animation == "atk1" and $"../../AnimatedSprite2D".frame == 12:
		var skull = fireball.instantiate() # 💀
		add_child(skull)
		skull.position = $"../../skullPoint".global_position
		skull.target = player.global_position
