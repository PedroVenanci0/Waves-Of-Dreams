extends Node

var transition_scene: PackedScene = preload("res://scenes/fade_in_canvas_layer.tscn")
var level_node: level
var enemies_killed: int = 0
var max_enemies = 20
var enemies_spawn = 0
var spawn_permission: bool = true
var scenes_database: Dictionary = {
	"title": preload("res://scenes/title_screen.tscn"),
	"tavern": preload("res://scenes/tavern_scene.tscn"),
	"transition": null
}
@export var damage_player: int = 1
@export var life_player: int = 3
@export var move_speed: float = 128
@export var total_xp: int = 00

func transitionToScene(destiny_scene: String) -> void:
	var trans = transition_scene.instantiate()
	trans.destiny_scene = scenes_database.get(destiny_scene) 
	add_child(trans)
