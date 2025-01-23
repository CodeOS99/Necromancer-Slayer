extends State
class_name spike_idle

@export var sprite : AnimatedSprite2D
@export var raycast : RayCast2D

func Enter():
	sprite.play("Idle")
	
func Update(_delta: float):
	if raycast.is_colliding():
		if raycast.get_collider().name == "Player":
			state_transition.emit(self, "seen") # Transition from idle to crushDown

func Exit():
	pass # Nothing needs to be done
