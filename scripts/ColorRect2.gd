extends ColorRect

func _process(delta):
		if Input.is_action_just_pressed("toggle_inventory"):
			visible = !visible
