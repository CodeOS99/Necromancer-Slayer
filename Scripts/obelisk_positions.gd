extends Node2D

signal obeliskBroken
signal appear

func _ready() -> void:
	for child in get_children():
		child.broken.connect(_obeliskBroken)

func _obeliskBroken():
	obeliskBroken.emit()

func _on_canvas_layer_can_target() -> void:
	for child in get_children():
		child.visible = true
	appear.emit()
