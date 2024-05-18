extends Node2D
class_name level
var max_enemies: int 

func _ready():
	Global.level_node = self
	max_enemies = 20
