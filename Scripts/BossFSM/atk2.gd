extends BossState
class_name atk2

var player
var enemies = [preload("res://Scenes/skeleton.tscn"), preload("res://Scenes/flying_monster.tscn"), preload("res://Scenes/mushroom.tscn")]

func enter():
	super()
	$"../../AnimatedSprite2D".play("atk2")

func animFinished():
	super()
	var n = randi_range(1, 3) # no. of enemies
	for i in range(n):
		var initPos = $"../../..".global_position
		var posX = randi_range(initPos.x-250, initPos.x + 250)
		var posY = randi_range(initPos.y + 250, initPos.y - 250)
		
		var enemy = enemies[randi_range(0,2)].instantiate()
		add_child(enemy)
		enemy.position.x = posX
		enemy.position.y = posY
		Transitioned.emit(self, "chase")
