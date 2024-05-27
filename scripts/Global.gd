extends Node

@export_category("Spawner Variables")
@export var max_enemies = 5
@export var enemies_spawn = 0
var spawn_permission: bool = true

@export_category("Player Variables")
@export var damage_player: int = 1
@export var life_player: int = 5
@export var move_speed: int = 130
@export var total_xp: int = 0

var transition_scene: PackedScene = preload("res://scenes/fade_in_canvas_layer.tscn")
var level_node: level
var enemies_killed: int = 0
var scene_forest = true  
var scene_cave = false 
var next_scene: String = "";
var onTavern: bool = true;
var actualSceneKey: String = "";
var num_wave: int = 1;
var damage_enemy = 1
var life_cap = 5
var enemy_speed = 30
var enemy_life = 1

var debugLastLifeEnemy: int = 0;
var debugLastDamageEnemy: int = 0;


var scenes_database: Dictionary = {
	"title": preload("res://scenes/title_screen.tscn"),
	"tavern": preload("res://scenes/tavern_scene.tscn"),
	"cave": preload("res://scenes/cave_scene.tscn"),
	"forest": preload("res://scenes/forest_scene.tscn"), 
	"transition": preload("res://scenes/transition.tscn"),
	"win": preload("res://scenes/WIN.tscn")
}

func transitionToScene(destiny_scene: String) -> void:
	var trans = transition_scene.instantiate()
	var _thisDestiny = "transition" if Global.next_scene == "" else Global.next_scene
	trans.destiny_scene = scenes_database.get(_thisDestiny) 
	Global.next_scene = destiny_scene
	trans.nextSceneString = destiny_scene;
	if _thisDestiny == Global.next_scene:
		Global.next_scene = ""
	add_child(trans)

func _process(delta):
	if debugLastLifeEnemy != enemy_life:
		print("Novo valor de enemy_life: ", enemy_life)
		debugLastLifeEnemy = enemy_life
		
	if debugLastDamageEnemy != damage_enemy:
		print("Novo valor de damage_enemy: ", damage_enemy)
		debugLastDamageEnemy = damage_enemy

	if Input.is_action_just_pressed("kill"):
		enemies_killed = 999
