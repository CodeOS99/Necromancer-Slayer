extends State
class_name impact

@export var sprite : AnimatedSprite2D

func Enter():
	sprite.play("hitBottom")
	sprite.animation_finished.connect(transition_state)

func transition_state():
	if sprite.animation == "hitBottom":
		state_transition.emit(self, "move_up") # Transition from seen to crushDown
