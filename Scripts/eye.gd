extends Node2D

var state: int = 0
var words = ["(Press k to interact)", "The Necromancer offered to revive me after I die,\nif I were to help him", "... he did keep his promise...", "...but not in a way I anticipated.", "You're trying to have a go at him, right?", "He can't hurt you on his own, so he'll try to use other stuff to try and get your soul.", "Those obsidian pillars of his seem fishy to me...", "Obsidian pillars? Nothing!\nI'm getting ahead of myself!\n", "Have fun."]
var isPlayerWithinInteractionRange: bool = false

func _process(delta: float) -> void:
	if Input.is_action_just_released("interact") and isPlayerWithinInteractionRange:
		state += 1
		state = state % len(words)
		$Label.text = words[state]

func _on_interact_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		isPlayerWithinInteractionRange = true


func _on_interact_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		isPlayerWithinInteractionRange = false
