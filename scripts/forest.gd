extends Node2D
class_name level
var max_enemies: int 

@onready var player = $player as Player
@onready var camera := $Camera2D as Camera2D
@onready var portal = $Portal


func _ready():
	player.follow_camera(camera)
	Global.level_node = self
	Global.onTavern = false
	
func _on_ineventory_gui_closed():
	get_tree().paused = false

func _on_ineventory_gui_opened():
	get_tree().paused = true

#func _on_portal_portal_open():
	#print("Executando _on_portal_portal_open")
	#portal.follow_camera(camera)
