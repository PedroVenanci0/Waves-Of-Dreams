extends Node2D

var max_enemies: int 

@onready var player = $player as Player
@onready var camera := $Camera2D as Camera2D
@onready var portal = $Portal as Area2D
@onready var cam_portal = $CamPortal as Camera2D

## Estado atual do portal
var portalOpened: bool = false;


func _ready():
	player.follow_camera(camera)
	Global.onTavern = false

func _process(delta):
	# Ajustar texto da interface caso haja portal.
	var _portalText = get_node("CanvasLayer/PortalText") as Label;
	var _bottom = float(get_viewport().size.y)
	var _newY = 615.0 if portalOpened else 650.0;
	_portalText.position.y = lerp(_portalText.position.y, _newY, 0.169);

	
func _on_ineventory_gui_closed():
	get_tree().paused = false

func _on_ineventory_gui_opened():
	get_tree().paused = true


func _on_portal_portal_open():
	portalOpened = true;
	cam_portal.enabled = true
	camera.enabled = false
	portal.follow_camera(cam_portal)
	await get_tree().create_timer(2).timeout
	camera.enabled = true
	cam_portal.enabled = false
	player.follow_camera(camera)
