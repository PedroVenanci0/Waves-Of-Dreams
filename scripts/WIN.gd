extends Button

func _on_pressed():
	get_tree().quit()

func _ready():
	grab_focus()
