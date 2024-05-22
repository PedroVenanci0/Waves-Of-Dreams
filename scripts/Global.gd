extends Node

var transition_scene: PackedScene = preload("res://scenes/fade_in_canvas_layer.tscn")
var level_node: level
var enemies_killed: int = 0
var next_scene: String = "";

var scenes_database: Dictionary = {
	"title": preload("res://scenes/title_screen.tscn"),
	"tavern": preload("res://scenes/tavern_scene.tscn"),
	"cave": preload("res://scenes/cave_scene.tscn"),
	"transition": preload("res://scenes/transition.tscn"),
}

@export_category("Spawner Variables")
@export var max_enemies = 20
@export var enemies_spawn = 0
var spawn_permission: bool = true


@export_category("Player Variables")
@export var damage_player: int = 1
@export var life_player: int = 3
@export var move_speed: float = 128
@export var total_xp: int = 100

func transitionToScene(destiny_scene: String) -> void:
	var trans = transition_scene.instantiate()
	var _thisDestiny = "transition" if Global.next_scene == "" else Global.next_scene
	trans.destiny_scene = scenes_database.get(_thisDestiny) 
	Global.next_scene = destiny_scene
	if _thisDestiny == Global.next_scene:
		Global.next_scene = ""
	add_child(trans)

func _process(delta):
	if life_player > 5:
		life_player = 5
