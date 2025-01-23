extends Node2D

signal dead

var health = 5

@export var player: Node2D

func _ready() -> void:
	$Flip/StateMachine/chase.player = player
	$Flip/StateMachine/atk1.player = player
	$ProgressBar.value = health

func _take_damage(n: int):
	health -= n
	$ProgressBar.value = health
	$Flip/StateMachine.current_state.Hit(health)
	
# This is in bossroom to wait for the black bars to show up i think
func _on_canvas_layer_can_target() -> void:
	$Flip/StateMachine.on_child_transitioned($Flip/StateMachine.current_state, "chase")
	$Flip/StateMachine/chase.canTarget = true

func _on_obelisk_positions_obelisk_broken() -> void:
	_take_damage(1)
