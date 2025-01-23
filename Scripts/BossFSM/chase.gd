extends BossState
class_name chase

var player : Node2D
var canTarget = false
var timer: Timer
var canMove = true

func enter():
	super()
	$"../../AnimatedSprite2D".play("idle")
	canMove = true
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.autostart = false
	timer.wait_time = randi_range(5, 8)
	timer.timeout.connect(timerTimeout)
	timer.start()

func timerTimeout():
	var choices = ["atk1", "atk2"] # atk1 is skull, atk 2 is zombie
	Transitioned.emit(self, choices[randi_range(0, 1)])

func PhysicsUpdate(delta):
	if canTarget and canMove:
		$"../../..".position = lerp($"../../..".position, player.position, 0.005)
		if $"../../..".position.x > player.position.x:
			$"../..".scale.x = 1
		else:
			$"../..".scale.x = -1

func Hit(health):
	super(health)
	canMove = false
