extends Node2D
class_name level
var max_enemies: int 

@onready var player := $player as CharacterBody2D
@onready var camera := $Camera2D as Camera2D


func _ready():
	Global.level_node = self
	player.follow_camera(camera)
