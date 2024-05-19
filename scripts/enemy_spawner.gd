extends Node2D

var enemy_scene := preload("res://scenes/enemy.tscn")
var spawn_points := []

func _ready():
	# verificando filhos 
	for child in get_children():
		if child is Marker2D:
			spawn_points.append(child)

func _on_timer_timeout():
	if Global.enemies_spawn < Global.max_enemies: 
		# spawn em posição aleatoria dentre as posições possiveis 
		var spawn  = spawn_points[randi() % spawn_points.size()]
		# spawn de inimigos 
		var enemy = enemy_scene.instantiate()
		enemy.position = spawn.position
		get_parent().get_node("Enemies_group").add_child(enemy)
		enemy.add_to_group("Enemies")
		Global.enemies_spawn += 1

