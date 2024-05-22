extends Control

signal opened
signal closed

var is_open: bool = false

func _process(delta):
	if Input.is_action_just_pressed("toggle_inventory"):
		visible = !visible
		opened.emit()
	else:
		closed.emit()
