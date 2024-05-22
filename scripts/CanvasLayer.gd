extends CanvasLayer

@onready var ineventory_gui = $IneventoryGUI

func _ready():
	ineventory_gui.close()

func _input(event):
	if Input.is_action_just_pressed("toggle_inventory"):
		if ineventory_gui.is_open:
			ineventory_gui.close()
		else:
			ineventory_gui.open()
