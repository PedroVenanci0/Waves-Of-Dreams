extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _process(delta):
	if Global.num_wave == 1:
		visible = true
	else:
		visible = false

	if Input.is_action_just_pressed("ui_text_newline"):
		queue_free()
