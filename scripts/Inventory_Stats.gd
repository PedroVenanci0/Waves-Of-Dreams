extends CanvasLayer

@onready var inventory_ui = $InventoryUI

func _ready():
	inventory_ui.close()
	
func _input(event):
	if Input.is_action_just_pressed("toggle_inventory"):
		if inventory_ui.is_open:
			inventory_ui.close()
		else:
			inventory_ui.open()
