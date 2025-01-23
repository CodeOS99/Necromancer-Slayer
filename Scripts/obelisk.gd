extends Node2D

signal broken
var playerIn = false
var alive = true
var active = false
var a = false

func _ready() -> void:
	get_parent().appear.connect(_appear)

func _process(delta: float) -> void:
	if playerIn and alive and a and active:
		if Input.is_action_just_pressed("interact"):
			var tween = get_tree().create_tween()
			tween.tween_property($".", "modulate", Color(1, 1, 1, 0), 1.0)
			tween.finished.connect(kill)
			alive = false

func _appear():
	var tween = get_tree().create_tween()
	tween.tween_property($".", "modulate", Color(1, 1, 1, 1), 1.0)

	active = true

func kill():
	broken.emit()
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if a:
		if body.name =="Player":
			$Label.visible = true
		playerIn = true
		print("in")

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		$Label.visible = false
	playerIn = false
	print("out")


func _on_timer_timeout() -> void:
	a = true
