extends Node2D

## Array que guarda posições dos pontos de spawn, alimentados na _ready.
var spawn_points := []
var max_enemies_this_level : int = 5

## Dicionário com inimigos determinados para cada level.
var levelsEnemies: Dictionary = {
	"forest": [
		preload("res://scenes/chicken.tscn"),
		preload("res://scenes/goblin.tscn")
	],
	"cave": [
		preload("res://scenes/skeleton.tscn"),
		preload("res://scenes/slime.tscn")
	]
}

## Total de Inimigos criados:
var createdEnemiesNumber: int = 0;
var createdEnemiesNumberArray: Array[int] = [];

## Ao entrar em cena
func _ready():
	# Adicionar pontos de spawn ao array spawn_points.
	for child in get_children():
		if child is Marker2D:
			spawn_points.append(child)
	
	# Inimigos:
	# Inimigos desse level
	var _enemies = levelsEnemies.get(Global.actualSceneKey)
	
	# Criar um array que guarda quantos inimigos de cada tipo foram criados.
	createdEnemiesNumberArray = []
	createdEnemiesNumberArray.resize(len(_enemies))
	createdEnemiesNumberArray.fill(0)

## Acionado ao esgotar o tempo de spawn. Spawnará um inimigo em um posição aleatória do array spawn_points.
func _on_timer_timeout():
	# Valor maximo de cada inimigo: #TODO: Atualizar com algum valor da Global.
	var _maxEnemies = Global.max_enemies
	# Inimigos desse level
	var _enemies = levelsEnemies.get(Global.actualSceneKey)
	# Se a quantidade de inimigos for menor que o máximp
	if createdEnemiesNumber < _maxEnemies * len(_enemies):
		# Obter ponto de spawn aleatório.
		var spawn = spawn_points[randi() % spawn_points.size()]
		# Escolhe um inimigo aleatório
		var _randomEnemyInd = randi() % len(_enemies)
		# Ficar sorteando enquanto o inimigo escolhido já tiver alcançado o máximo
		while (createdEnemiesNumberArray[_randomEnemyInd] >= _maxEnemies):
			_randomEnemyInd = randi() % len(_enemies)
		# Nesse momento, já temos o inimigo que deverá ser criado:
		var _enemyToCreate = _enemies[_randomEnemyInd]
		# Incrementar a quantidade de inimigos criados deste tipo.
		createdEnemiesNumberArray[_randomEnemyInd] += 1
		createdEnemiesNumber += 1
		# Instanciar
		spawnEnemy(_enemyToCreate, spawn)


## Instancia um inimigo num ponto de spawn determinado.
func spawnEnemy(_enemyToCreate, _spawnPoint):
	var enemy = _enemyToCreate.instantiate();
	enemy.global_position = _spawnPoint.global_position;
	get_parent().get_node("Enemies_group").add_child(enemy)
	enemy.add_to_group("Enemies")
