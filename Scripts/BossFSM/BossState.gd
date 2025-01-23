extends Node
class_name BossState

signal Transitioned

func enter():
	$"../../AnimatedSprite2D".animation_finished.connect(animFinished)

func exit():
	$"../../AnimatedSprite2D".animation_finished.disconnect(animFinished)
	
func Update(delta:float):
	pass

func Hit(health):
	if health == 0:
		$"../../..".dead.emit()
		Transitioned.emit(self, "deadState")
		print("1")
	else:
		$"../../AnimatedSprite2D".play("hurt")

func animFinished():
	if $"../../AnimatedSprite2D".animation == "hurt":
		enter()

func PhysicsUpdate(delta:float):
	pass
