extends Node2D

var ckicken_scene := preload("res://scenes/chicken.tscn")
var goblin_scene := preload("res://scenes/goblin.tscn")
var skeleton_scene := preload("res://scenes/skeleton.tscn")
var slime_scene := preload("res://scenes/slime.tscn")
var spawn_points := []

var enemy_chicken = 0
var enemy_goblin = 0
var enemy_slime = 0
var enemy_skeleton = 0
var scene_forest = true  #quando for apara cena da caverna portal muda essa variavel para false
var scene_cave = false

func _ready():
	# verificando filhos 
	for child in get_children():
		if child is Marker2D:
			spawn_points.append(child)

func _on_timer_timeout():
	if Global.enemies_spawn < Global.max_enemies and Global.spawn_permission: 
		# spawn em posição aleatoria dentre as posições possiveis 
		var spawn  = spawn_points[randi() % spawn_points.size()]
		# spawn de inimigos 
		if enemy_chicken <= 5 and scene_forest == true:
			var enemy = ckicken_scene.instantiate()
			enemy.global_position = spawn.global_position
			get_parent().get_node("Enemies_group").add_child(enemy)
			enemy.add_to_group("Enemies")
			Global.enemies_spawn += 1
			enemy_chicken += 1
			print("spawn")
		
		if enemy_goblin <= 5 and scene_forest == true:
			var enemy = goblin_scene.instantiate()
			enemy.global_position = spawn.global_position + Vector2(40,40)
			get_parent().get_node("Enemies_group").add_child(enemy)
			enemy.add_to_group("Enemies")
			Global.enemies_spawn += 1
			enemy_goblin += 1
			print("spawn")
			
		if enemy_skeleton <= 5 and scene_cave == true:
			var enemy = skeleton_scene.instantiate()
			enemy.global_position = spawn.global_position
			get_parent().get_node("Enemies_group").add_child(enemy)
			enemy.add_to_group("Enemies")
			get_tree().create_timer(1).timeout
			Global.enemies_spawn += 1
			enemy_goblin += 1
			print("spawn")
		
		if enemy_slime <= 5 and scene_cave == true:
			var enemy = slime_scene.instantiate()
			enemy.global_position = spawn.global_position 
			get_parent().get_node("Enemies_group").add_child(enemy)
			enemy.add_to_group("Enemies")
			get_tree().create_timer(1).timeout
			Global.enemies_spawn += 1
			enemy_goblin += 1
			print("spawn")
		
