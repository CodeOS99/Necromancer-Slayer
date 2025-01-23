extends State
class_name move_up

@export var sprite : AnimatedSprite2D
var t: Tween

func Enter():
	sprite.play("idle")
	t = get_tree().create_tween()
	t.tween_property(get_parent().get_parent(), "position", get_parent().get_parent().original_position, 1)
	t.finished.connect(transition)
	
func transition():
	state_transition.emit(self, "idle")
