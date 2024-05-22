extends Control

signal opened
signal closed

var is_open: bool = false

@onready var inventory: Inventory = preload("res://scripts/Resources/items/player_inventory.tres")
@onready var slots = $NinePatchRect/GridContainer.get_children()


func _ready():
	update()
	
func update():
	for i in range(min(inventory.items.size(), slots.size())):
		slots[i].update(inventory.items[i])

func open():
	visible = true 
	is_open = true
	opened.emit()
	
func close():
	visible = false
	is_open = false
	closed.emit()
