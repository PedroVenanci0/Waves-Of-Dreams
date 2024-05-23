extends Node2D

@onready var player := $player as CharacterBody2D
@onready var camera := $Camera2D as Camera2D


func _ready():
	player.follow_camera(camera)
	Global.onTavern = true;

func _on_inventory_ui_closed():
	get_tree().paused = false
	
func _on_inventory_ui_opened():
	get_tree().paused = true
	

