extends BossState
class_name deadState

func enter():
	print("2")
	$"../../AnimatedSprite2D".play("death")
	var t = create_tween()
	t.tween_property($"../../..", "modulate", Color(1,1,1,0), 7)
	t.finished.connect(win)

func win():
	get_tree().change_scene_to_file("res://Scenes/win.tscn")
