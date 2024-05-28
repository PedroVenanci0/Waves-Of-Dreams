extends Area2D
class_name Portal
signal portal_open
@onready var portal = $"."
@onready var remote = $RemoteTransform2D
var portal_spawn = true

@onready var portal_collider = $CollisionShape2D

@export_category("Variables") 
@export var destiny: String

@export_category("objects")
@export var _animator: AnimatedSprite2D = null

func _ready():
		if Global.onTavern:
			_animator.visible = true 
			_animator.play("spawn")
			await get_tree().create_timer(1).timeout
			_animator.play("idle")
			portal_collider.set_deferred("disabled", false)
			
func _process(delta):
	if Global.enemies_killed >= Global.max_enemies * 2 and portal_spawn:#TODO trocar magic number pelo comprimento do vetor de inimigos
		portal_collider.set_deferred("disabled",false)
		await get_tree().create_timer(0.5).timeout 
		_animator.play("spawn")
		_animator.visible = true
		await _animator.animation_finished
		_animator.play("idle")
		portal_open.emit()
		portal_spawn = false
	

## Retorna a chave da scene correspondente ao numero da wave no momento
func getDestinyByWaveNumber() -> String:
	if Global.num_wave < 10:
		return "forest";
	if Global.num_wave < 20:
		return "cave";
	if Global.num_wave == 20:
		return "win"
	
	return "forest"
	

## Função que verifica se o player entrou no portal
func _on_body_entered(_body) -> void:
	if _body is Player:
		_body.myPortal = self;
		
		if not Global.onTavern and Global.num_wave % 2 == 0:
			print("Global.num_wave: " + str(Global.num_wave))
			Global.enemy_life += 1
			print("Xp+")
			Global.total_xp += 3 # Experiência do jogador
			Global.max_enemies += 2
			Global.damage_enemy += 1
			Global.enemy_speed += 5
		
		
		if not Global.onTavern:
				Global.num_wave += 1
				Global.enemies_killed = 0
				print( "Enemy life: "+ str(Global.enemy_life))
	
		# Se entrou a partir do bar:
		if Global.onTavern:
			destiny = getDestinyByWaveNumber();
			Global.onTavern = false;
			print("Taverna: ", Global.onTavern)
		else: # Caso contrário (player na fase):
			# Saber se o numero da wave corresponde a um checkpoint para o bar
			if Global.num_wave % 5 == 0:
				destiny = "tavern"
				Global.onTavern = true
				print("Taverna: ", Global.onTavern)
			else:
				destiny = getDestinyByWaveNumber()
				print("Taverna: ", Global.onTavern);

		# Transiciona finalmente para a cena destino.
		Global.transitionToScene(destiny)
		print("Wave: ", Global.num_wave)
		portal_spawn = true
		
func follow_camera(camera) -> void:
	print("porta pegou cam")
	var cam_path = camera.get_path()
	remote.remote_path = cam_path
