extends State
class_name crush_down

@export var sprite : AnimatedSprite2D
var t: Tween

func Enter():
	t = get_tree().create_tween()
	t.tween_property(get_parent().get_parent(), "position", get_parent().get_parent().endpoint.position, 0.25)
	t.finished.connect(transition)
	
func transition():
	state_transition.emit(self, "impact")
