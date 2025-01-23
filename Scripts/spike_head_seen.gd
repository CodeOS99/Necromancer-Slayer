extends State
class_name seen

@export var sprite : AnimatedSprite2D

func Enter():
	sprite.play("seen")
	sprite.animation_finished.connect(transition_state)

func transition_state():
	if sprite.animation == "seen":
		state_transition.emit(self, "crush_down") # Transition from seen to crushDown
