extends Node

var cherries: int = 0

func add_cherries(n: int):
	cherries += n
	$"../HUD".change_text(cherries)
	Globals.bonusPoints += n

func set_cherries(n: int):
	cherries = n
	$"../HUD".change_text(cherries)
